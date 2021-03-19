FROM steamcmd/steamcmd:latest

ARG user
ARG password

RUN dpkg --add-architecture i386
RUN apt update
RUN apt install libfreetype6:i386 -y
RUN apt install libfreetype6 -y
RUN apt install python3 -y

RUN steamcmd +@sSteamCmdForcePlatformType linux +login ${user} ${password} "+app_update 1245040" +quit
RUN steamcmd +@sSteamCmdForcePlatformType windows +login ${user} ${password} "+app_update 526870 --beta experimental" +quit

RUN mkdir ~/compatdata

WORKDIR './.steam/steamapps/common/Proton 5.0'
ENV STEAM_COMPAT_DATA_PATH=/root/compatdata

ENTRYPOINT [ "./proton", "run", "/root/Steam/steamapps/common/Satisfactory/FactoryGame.exe", "-nosplash", "-nullrhi", "-nosound", "-NoSteamClient" ]