FROM eclipse-temurin:17-jdk

ARG ARCHI_VER=5.3.0
ARG COARCHI_VER=0.9.2

RUN apt update && \
    apt install -y wget unzip dbus xvfb libswt-gtk-4-java && \
    wget -O "archi.tgz" "https://www.archimatetool.com/downloads/archi/${ARCHI_VER}/Archi-Linux64-${ARCHI_VER}.tgz" && \
    echo 72223d33e83e34c025505e8369aeb59855629dc9    archi.tgz | sha1sum -c - && \
    tar zxf "archi.tgz" -C /opt/ && \
    wget -O coarchi.zip "https://www.archimatetool.com/downloads/coarchi/coArchi_${COARCHI_VER}.archiplugin" && \    
    mkdir -p ~/.archi4/dropins && \
    unzip coarchi.zip -d ~/.archi4/dropins && \
    rm archi.tgz coarchi.zip && \
    apt remove -y wget unzip && \
    apt autoremove -y && apt clean

COPY build-report.sh /app/
WORKDIR /app
CMD /app/build-report.sh
