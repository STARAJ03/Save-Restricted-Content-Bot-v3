FROM python:3.10.4-slim-buster

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# System dependencies (SSL support, FFmpeg, curl, etc.)
RUN apt update && \
    apt upgrade -y && \
    apt install -y \
    git \
    curl \
    wget \
    ffmpeg \
    bash \
    neofetch \
    software-properties-common \
    python3-pip \
    python3-dev \
    build-essential \
    libssl-dev \
    libffi-dev \
    && apt clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy and install Python requirements
COPY requirements.txt .
RUN pip install --upgrade pip setuptools wheel && \
    pip install --no-cache-dir --upgrade -r requirements.txt

# Copy all source code
COPY . .

# Expose Flask port
EXPOSE 5000

# Launch Flask and your main logic
CMD flask run -h 0.0.0.0 -p 5000 & python3 main.py

