FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# 系统依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update && apt-get install -y --no-install-recommends \
    python3.12 python3.12-dev python3.12-venv python3-pip \
    ffmpeg git wget curl \
    && rm -rf /var/lib/apt/lists/*

# 设置 Python 3.12 为默认
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1 \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3.12 1

WORKDIR /app

# 安装 PyTorch（利用缓存层，单独 COPY requirements.txt）
COPY requirements.txt .
RUN pip3 install --no-cache-dir --break-system-packages \
    torch==2.9.1 torchvision==0.24.1 torchaudio==2.9.1 \
    --index-url https://download.pytorch.org/whl/cu121 \
    && pip3 install --no-cache-dir --break-system-packages -r requirements.txt

# 拷贝项目代码（models/ 和 data/ 通过 volume 挂载，不打进镜像）
COPY . .
RUN chmod +x docker-entrypoint.sh

EXPOSE 8010
# WebRTC UDP port range
EXPOSE 20000-20100/udp

ENTRYPOINT ["./docker-entrypoint.sh"]
