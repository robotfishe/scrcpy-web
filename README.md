# scrcpy-web

This docker container, available on Dockerhub at [robotfishe/scrcpy-web](https://hub.docker.com/repository/docker/robotfishe/scrcpy-web/general), runs [scrcpy](https://github.com/Genymobile/scrcpy) and [x11vnc](https://github.com/LibVNC/x11vnc) to allow you to control an Android device over a VNC connection. It is partially based on reverse-engineering [this Dockerhub image from openverso](https://hub.docker.com/r/openverso/scrcpy/tags) which uses an extremely out-of-date scrcpy version, has no support for setting scrcpy options, and required excessive permissions because it was intended for older versions of Docker that lacked the --device flag.

You will need to set the flag --device=/dev/bus when you run this to allow the container to directly access USB devices. (It is also possible to use the --privileged flag if you're on an older version of Docker or --devices doesn't work, but this carries more risk.)

There are three ENV variables available:
- VNC_SCREEN_SIZE should generally be set to the screen resolution of your device, or match the size set in SCRCPY_ARGS (see below).
- VNC_PASSWORD is used to set a password for the VNC connection; this can be left empty for no password.
- SCRCPY_ARGS is used to set arguments for scrcpy. For example, SCRCPY_ARGS=-wS will set the "stay-awake" and "turn-screen-off" options (to turn off the physical device screen but keep the mirrored display from blanking). Check the [scrcpy docs](https://github.com/Genymobile/scrcpy/tree/master/doc) for all the flags that can be set here.

NOTE: You MUST keep --no-audio in SCRCPY_ARGS unless you plan to edit the container to set up your own audio bridge. There is no audio support in the current VNC implementation and scrcpy will fail without this flag.
