FROM python:3.9.0-slim

RUN apt update -y \
    && apt install build-essential -y \
    && rm -rf /var/lib/apt/lists/* \
    && pip install gunicorn vaex diskcache --no-cache-dir \
    && rm -rf $(pip cache root)

CMD gunicorn vaex.server.fastapi:app -b ":8081" -w 2 --threads 2 -k uvicorn.workers.UvicornWorker
