### docker-deluge ###

Run with
```docker run -d --name deluge -p 80:80 -p 8112:8112 -p 58846:58846 -p 58847:58847 -p 58847:58847/udp -v /path/to/deluge/data:/home/deluge -v /path/to/media/:/media ejsjrnc/docker-deluge```

WEBUI address = http://<your host>:8112
Desktop client - <your host>:58846

The default username/password is deluge:deluge. This can be changed by editing the .config/deluge/auth file in deluge data dir.

```docker exec deluge sh -c "sudo -u deluge sh -c \"sed '/deluge/d' /home/deluge/.config/deluge/auth && echo \"user:pass:10\" >> /home/deluge/.config/deluge/auth"```

# docker-deluge
