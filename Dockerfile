FROM node:8-alpine
MAINTAINER leon_xi@163.com

RUN apk update && \
    apk add git && \
    apk add --no-cache openssh tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
    ssh-keygen -t rsa -P "" -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -t ecdsa -P "" -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -t ed25519 -P "" -f /etc/ssh/ssh_host_ed25519_key && \
    echo "root:1234" | chpasswd

RUN npm install -g ionic@4.1.2 \
                   phonegap \
                   plugman \
                   cordova@6.5.0

RUN mkdir -p /opt/gtd2
WORKDIR /opt/gtd2

RUN git clone -b cassiscornuta https://github.com/XJ-GTD/GTD2.git .

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

RUN npm install

RUN npm install -g karma-cli

RUN ionic cordova add platfrom browser

RUN apk add --no-cache chromium

CMD ["/usr/sbin/sshd", "-D"]
