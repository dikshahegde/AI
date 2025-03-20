FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN wget -O /app/StickersRedmond.safetensors https://huggingface.co/artificialguybr/StickersRedmond/resolve/main/StickersRedmond.safetensors

RUN pip3 install torch safetensors

COPY . /app

CMD ["bash"]
