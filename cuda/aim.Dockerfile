FROM python:3.10-slim
LABEL MAINTAINER aashish@fusemachines.com

WORKDIR /app

RUN apt update && apt upgrade -y && apt install -y sqlite3
RUN pip install --upgrade pip \
    && pip --no-cache-dir install "aim==3.18.1"

EXPOSE $AIM_PORT
RUN test -d aim || mkdir aim \
    && test -d aim/.aim || aim init -y --repo ./aim
CMD aim up --repo ./aim --host 0.0.0.0 --port $AIM_PORT
