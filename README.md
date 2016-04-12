# opentie
[![Circle CI](https://circleci.com/gh/opentie/opentie/tree/master.svg?style=svg)](https://circleci.com/gh/opentie/opentie/tree/master)

## How to work

### nginx config example

```
server {
    listen 3124;

    proxy_buffering off;

    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header Host $http_host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Forwarded-Server $host;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Forwarded-Port $server_port;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Request-Start $msec;

    root /path/to/opentie/public;

    location / {
        try_files $uri /index.html;
    }

    location /api/ {
        proxy_pass http://127.0.0.1:3000;
    }
}
```
