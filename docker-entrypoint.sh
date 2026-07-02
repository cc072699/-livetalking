#!/bin/bash
set -e

exec python3 app.py \
    --transport "${TRANSPORT:-webrtc}" \
    --model "${MODEL:-wav2lip}" \
    --avatar_id "${AVATAR_ID:-cc3}" \
    --tts "${TTS:-qwentts}" \
    --REF_FILE "${REF_FILE:-Cherry}" \
    --tts_speed "${TTS_SPEED:-1.0}" \
    --qwen_tts_model "${QWEN_TTS_MODEL:-qwen-tts-realtime-latest}" \
    --batch_size "${BATCH_SIZE:-16}" \
    --max_session "${MAX_SESSION:-1}" \
    --listenport "${LISTEN_PORT:-8010}" \
    --subtitle "${SUBTITLE:-True}" \
    --subtitle_size "${SUBTITLE_SIZE:-1.0}" \
    ${TTS_SERVER:+--TTS_SERVER "$TTS_SERVER"} \
    ${REF_TEXT:+--REF_TEXT "$REF_TEXT"} \
    ${PUSH_URL:+--push_url "$PUSH_URL"} \
    ${MODELRES:+--modelres "$MODELRES"} \
    ${MODELFILE:+--modelfile "$MODELFILE"} \
    ${CUSTOMVIDEO_CONFIG:+--customvideo_config "$CUSTOMVIDEO_CONFIG"} \
    ${EXTRA_ARGS:+$EXTRA_ARGS}
