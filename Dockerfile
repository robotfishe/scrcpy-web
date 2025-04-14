FROM ubuntu:noble
ADD --chmod=766 entrypoint.sh start.sh /
ENV VNC_SCREEN_SIZE=
ENV VNC_PASSWORD=
ENV SCRCPY_ARGS=
RUN <<EOF
apt-get update
apt-get install -y x11vnc fluxbox xvfb scrcpy android-tools-adb
apt-get clean
rm -rf /var/lib/apt/lists/*
mkdir -p /root/.fluxbox
echo ' \n session.screen0.toolbar.visible: false\n session.screen0.fullMaximization: true\n session.screen0.maxDisableResize: true\n session.screen0.maxDisableMove: true\n session.screen0.defaultDeco: NONE\n	' >> /root/.fluxbox/init
mkdir -p /root/.android && adb start-server
EOF
EXPOSE 5900
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
CMD ["/start.sh"]
