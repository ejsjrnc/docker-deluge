FROM ubuntu
MAINTAINER Ed <ed.stanford.jr@gmail.com>

# Install components
RUN apt-get update && apt-get --no-install-recommends -qyy install sudo deluged deluge-web deluge-console runit psmisc unzip wget zip && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN useradd -m -s /bin/nologin deluge
RUN sudo -u deluge sh -c "deluged; sleep 5; killall deluged"
RUN sudo -u deluge sh -c "echo \"deluge:deluge:10\" >> ~/.config/deluge/auth"
RUN sudo -u deluge sh -c "deluged && sleep 10 && deluge-console \"config -s allow_remote True\" && deluge-console \"config allow_remote\" && killall deluged"
RUN mkdir -p /etc/service/deluged; mkdir -p /etc/service/deluge-web

# Configure runit
ADD deluged.service /etc/service/deluged/run
ADD deluge-web.service /etc/service/deluge-web/run

ADD core.conf /tmp/core.conf
WORKDIR /home/deluge

# Expose ports
EXPOSE 8112
EXPOSE 58846
EXPOSE 58847
EXPOSE 58847/udp

VOLUME /home/deluge
VOLUME /media
CMD ["runsvdir", "/etc/service"]
