#!/bin/bash

# docker
curl -fsSL https://get.docker.com -o /root/get-docker.sh
bash /root/get-docker.sh

# web-ssh
docker pull genshen/ssh-web-console:latest
mkdir -p /root/ssh-web-console-conf
cat <<EOT > /root/ssh-web-console-conf/config.yaml
site:
  appname: ssh-web-console
  listen_addr: :2022
  runmode: prod
  deploy_host: ssh-web-console.serafin.tech

prod:
  static_prefix: /

ssh:
  buffer_checker_cycle_time: 60
jwt:
  jwt_secret: secret.console.hpc.gensh.me
  token_lifetime: 7200
  issuer: issuer.ssh.gensh.me
  query_token_key: _t
EOT
docker run -v /root/ssh-web-console-conf:/home/web/conf -p 2022:2022 --rm -d genshen/ssh-web-console
