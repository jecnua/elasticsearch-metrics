FROM python:2.7-slim

COPY . /app

RUN pip install requests && \
    useradd -u 10106 -r -s /bin/false monitor && \
    chmod 755 /app/bin/entrypoint.sh

USER monitor

ENTRYPOINT ["/app/bin/entrypoint.sh"]
