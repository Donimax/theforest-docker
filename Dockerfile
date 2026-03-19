FROM donimax/steamcmd:v1.1.0

LABEL maintainer="Donimax"

USER root

ENV WINEPREFIX=/winedata/WINE64 \
    WINEARCH=win64 \
    DISPLAY=:1.0 \
    TIMEZONE=Europe/Berlin \
    DEBIAN_FRONTEND=noninteractive \
    PUID=1000 \
    PGID=1000 \
    SERVERSTEAMACCOUNT=""

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y --no-install-recommends --no-install-suggests wget procps lib32gcc-s1 winbind xvfb \
    && wget -qO /usr/share/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key \
    && echo "deb [signed-by=/usr/share/keyrings/winehq-archive.key] https://dl.winehq.org/wine-builds/debian/ bullseye main" > /etc/apt/sources.list.d/winehq.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends winehq-stable \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && mkdir -p /config /winedata \
    && chown steam:steam /config \
    && chown steam:steam /winedata \
    && chown steam:steam /etc/bash.bashrc

COPY --chown=steam:steam servermanager.sh /usr/bin
COPY --chown=steam:steam defaults steamcmdinstall.txt server.cfg.example /

RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
    && echo $TIMEZONE > /etc/timezone \
    && chmod +x /usr/bin/servermanager.sh

EXPOSE 8766/tcp 8766/udp 27015/tcp 27015/udp 27016/tcp 27016/udp

HEALTHCHECK --interval=30s --timeout=10s --start-period=120s --retries=3 \
    CMD pgrep -f "TheForestDedicatedServer" > /dev/null || pgrep -f "steamcmd" > /dev/null || exit 1

USER steam

CMD ["servermanager.sh"]
