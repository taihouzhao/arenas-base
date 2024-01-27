FROM python:3.10-slim-bullseye

RUN apt-get update && apt-get install -y libopencv-dev espeak alsa-utils ffmpeg vim pulseaudio espeak espeak-ng espeak-data libespeak-dev python3-dev
RUN rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir fastapi uvicorn python-multipart requests numpy
RUN pip install --no-cache-dir arenas

RUN python -m aeneas.diagnostics

WORKDIR /app

ENV PYTHONUNBUFFERED=1