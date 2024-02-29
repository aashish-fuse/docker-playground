FROM python:3.10-slim
LABEL MAINTAINER aashish@fusemachines.com

WORKDIR /app

COPY requirements.txt .
RUN apt update && apt upgrade && apt install -y git nodejs
RUN pip install --upgrade pip \
    && pip --no-cache-dir install -r requirements.txt
RUN jupyter server --generate-config \
    && echo "c.IdentityProvider.hashed_password='$(python -c \
    "from jupyter_server.auth import passwd; print(passwd('$JUPYTER_TOKEN'))" \
    )'" >> /root/.jupyter/jupyter_server_config.py

COPY . .

EXPOSE $JUPYTER_PORT
CMD jupyter lab --allow-root --no-browser --ip 0.0.0.0 --port $JUPYTER_PORT
