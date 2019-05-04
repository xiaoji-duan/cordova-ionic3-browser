FROM node:8-alpine
MAINTAINER leon_xi@163.com

RUN apk update & \
    apk add git

RUN npm install -g ionic@4.1.2 \
                   phonegap \
                   plugman \
                   cordova@6.5.0

RUN mkdir -p /opt/gtd2
WORKDIR /opt/gtd2

RUN git clone -b develop https://github.com/XJ-GTD/GTD2.git .

WORKDIR /opt/gtd2/TimeApp

RUN ionic cordova plugin add ../BaiduSpeechAndTTS \
                             ../xjalarmclock \
                             cordova-sqlite-storage \
                             cordova-plugin-statusbar \
                             uk.co.workingedge.cordova.plugin.sqliteporter \
                             cordova-sqlite-storage \
                             cordova-plugin-whitelist \
                             com.telerik.plugins.nativepagetransitions \
                             cordova-plugin-nativeaudio \
                             cordova-plugin-vibration \
                             cordova-plugin-file-transfer \
                             cordova-plugin-local-notification \
                             cordova-plugin-ionic-webview \
                             cordova-plugin-splashscreen \
                             ionic-plugin-keyboard \
                             cordova-plugin-device \
                             cordova-plugin-console \
                             cordova-plugin-file \
                             cordova-plugin-calendar \
                             cordova-plugin-advanced-http \
                             cordova-plugin-android-permissions \
                             cordova-plugin-background-mode \
                             cordova-plugin-contacts \
                             cordova-clipboard \
                             cordova-plugin-network-information \
                             cordova-plugin-screen-orientation

RUN npm install & \
    npm clean & \
    npm build

RUN ionic cordova add browser

CMD ["ionic", "cordova", "run", "browser"]
