FROM python:3.10-slim
LABEL MAINTAINER aashish@fusemachines.com

WORKDIR /app

RUN apt update && apt upgrade -y && apt install -y sqlite3
RUN pip install --upgrade pip \
    && pip --no-cache-dir install "mlflow==2.10.2"

EXPOSE $MLFLOW_PORT
RUN test -d mlruns || mkdir mlruns
CMD mlflow server --backend-store-uri sqlite:///mlruns/mlflow.db -h 0.0.0.0 -p $MLFLOW_PORT
