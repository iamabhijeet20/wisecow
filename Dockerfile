FROM debian:stable-slim

RUN apt-get update && apt-get install -y \
    cowsay \
    fortune \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

COPY wisecow.sh /app/wisecow.sh

RUN chmod +x /app/wisecow.sh

EXPOSE 4499

CMD ["/app/wisecow.sh"]
