FROM python:3.10-slim
LABEL MAINTAINER aashish@fusemachines.com

WORKDIR /app

RUN apt update && apt upgrade -y && apt install -y sqlite3
RUN pip install --upgrade pip \
    && pip --no-cache-dir install "aim==3.18.1"

EXPOSE $AIM_PORT
RUN test -d $AIM_DIR || mkdir $AIM_DIR \
    && (test -d $AIM_DIR/.aim || aim init -y --repo ./$AIM_DIR)
CMD aim up --repo ./$AIM_DIR --host 0.0.0.0 --port $AIM_PORT
