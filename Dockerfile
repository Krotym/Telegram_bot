FROM python:3.9.5-slim-buster

ENV GECKODRIVER_VER v0.30.0
ENV FIREFOX_VER 96.0
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

ENV DATABASE_URL //t_user:123@127.0.0.1/test_db
ENV TOKEN 5222655321:AAH4YaU-2JCxYqJUXUfxeBP1UVwfaIo7llQ

COPY . /app
WORKDIR /app

RUN apt-get update && pip install --upgrade pip && \
        apt-get -y install libpq-dev gcc && \
        pip install -r requirements.txt \
   && set -x \ # Add latest FireFox
   && apt install -y curl bzip2 firefox-esr libx11-xcb1 libdbus-glib-1-2 \
   && curl -sSLO https://download-installer.cdn.mozilla.net/pub/firefox/releases/${FIREFOX_VER}/linux-x86_64/en-US/firefox-${FIREFOX_VER}.tar.bz2 \
   && tar -jxf firefox-* \
   && mv firefox /opt/  && rm -rf *.tar.bz2\
   && chmod 755 /opt/firefox \
   && chmod 755 /opt/firefox/firefox \
   && curl -sSLO https://github.com/mozilla/geckodriver/releases/download/${GECKODRIVER_VER}/geckodriver-${GECKODRIVER_VER}-linux64.tar.gz \ # Add geckodriver
   && tar zxf geckodriver-*.tar.gz && rm -rf geckodriver-*.tar.gz\
   && mv geckodriver /usr/bin/ && rm -rf /var/lib/apt/lists/*

CMD ["chmod","+775","starter.sh"]
CMD ["./starter.sh"]

