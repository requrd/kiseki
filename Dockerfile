FROM chinachu/mirakurun:amd64-3.9.0-rc.4
ENV TZ="Asia/Tokyo" \
    SERVER_CONFIG_PATH="/app-config/server.yml" \
    TUNERS_CONFIG_PATH="/app-config/tuners.yml" \
    CHANNELS_CONFIG_PATH="/app-config/channels.yml" \
    SERVICES_DB_PATH="/app-data/services.json" \
    PROGRAMS_DB_PATH="/app-data/programs.json" \
    DOCKER="YES"

COPY b25 /usr/local/bin/b25
COPY libarib25.so.0 /usr/lib/x86_64-linux-gnu/libarib25.so.0
COPY libpcsclite.so.1.0.0 /usr/lib/x86_64-linux-gnu/libpcsclite.so.1.0.0
COPY arib-b25-stream-test /usr/local/bin/arib-b25-stream-test
RUN mkdir app-config
COPY ./conf /app-config
EXPOSE 40772 9229
CMD ["npm", "start"]