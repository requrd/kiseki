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
COPY ./877b48382139fc03282eb448827c6d4b/channels.yml /app-config
RUN cat /app-config/channels.yml >> /app-config/tokyo-channels.yml &&\
    mv /app-config/tokyo-channels.yml /app-config/channels.yml
ADD https://raw.githubusercontent.com/Chinachu/dvbconf-for-isdb/master/conf/dvbv5_channels_isdbs.conf /app/config/dvbconf-for-isdb/conf/dvbv5_channels_isdbs.conf
RUN chmod +r /app/config/dvbconf-for-isdb/conf/dvbv5_channels_isdbs.conf
EXPOSE 40772 9229
CMD ["npm", "start"]