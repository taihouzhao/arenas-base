FROM python:3.10-slim-bullseye

# Install required packages
RUN apt-get update && apt-get install -y \
    libopencv-dev \
    alsa-utils \
    ffmpeg \
    vim \
    pulseaudio \
    espeak \
    espeak-ng \
    espeak-data \
    espeak-ng-data \
    libespeak-dev \
    python3-dev \
    build-essential \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Clone the espeak-data repository and copy the data to the correct directory
RUN git clone https://github.com/caixxiong/espeak-data/ \
    && cd espeak-data/ \
    && unzip espeak-data.zip \
    && cp -r * /usr/lib/x86_64-linux-gnu/espeak-data/

# Compile espeak data and list contents for debugging
RUN cd /usr/lib/x86_64-linux-gnu/espeak-data/ \
    && ls -la \
    && espeak --compile=zh \
    && espeak --compile=zhy 

RUN pip install --no-cache-dir numpy
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN python -m aeneas.diagnostics

WORKDIR /app

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
