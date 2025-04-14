FROM ubuntu:noble
ADD --chmod=766 entrypoint.sh start.sh /
ENV VNC_SCREEN_SIZE=
ENV VNC_PASSWORD=
ENV SCRCPY_ARGS="-wS --no-audio"
RUN <<EOF
apt-get update
apt-get install -y x11vnc fluxbox xvfb android-tools-adb ffmpeg libsdl2-2.0-0 wget gcc git pkg-config meson ninja-build libsdl2-dev libavcodec-dev libavdevice-dev libavformat-dev libavutil-dev libavcodec-dev libavdevice-dev libavformat-dev libavutil-dev  libswresample-dev libusb-1.0-0 libusb-1.0-0-dev
git clone https://github.com/Genymobile/scrcpy
cd scrcpy
git pull
sed -i 's/sudo//g' install_release.sh
./install_release.sh 
apt-get clean
rm -rf /var/lib/apt/lists/*
mkdir -p /root/.fluxbox
echo ' \n session.screen0.toolbar.visible: false\n session.screen0.fullMaximization: true\n session.screen0.maxDisableResize: true\n session.screen0.maxDisableMove: true\n session.screen0.defaultDeco: NONE\n	' >> /root/.fluxbox/init
mkdir -p /root/.android && adb start-server
EOF
EXPOSE 5900
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
CMD ["/start.sh"]
