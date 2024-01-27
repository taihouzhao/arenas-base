FROM python:3.10-slim-bullseye

# Install required packages
RUN apt-get update && apt-get install -y \
    libopencv-dev \
    espeak \
    alsa-utils \
    ffmpeg \
    vim \
    pulseaudio \
    espeak \
    espeak-ng \
    espeak-data \
    libespeak-dev \
    python3-dev \
    build-essential \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Clone the espeak-data repository
RUN git clone https://github.com/caixxiong/espeak-data/ \
    && cd espeak-data/ \
    && unzip espeak-data.zip \
    && cp -r * /usr/lib/x86_64-linux-gnu/espeak-data/ \
    && espeak --compile=zh

RUN pip install --no-cache-dir numpy
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN python -m aeneas.diagnostics

WORKDIR /app

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1