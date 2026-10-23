FROM python:3.12-slim
WORKDIR /app
COPY corporate-ca-bundle.crt /usr/local/share/ca-certificates/corporate-ca-bundle.crt
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*
ENV PIP_CERT=/etc/ssl/certs/ca-certificates.crt
COPY app.py .
RUN pip install  --no-cache-dir flask
EXPOSE 5000
CMD ["python","app.py"]
