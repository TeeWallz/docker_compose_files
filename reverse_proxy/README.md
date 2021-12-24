

Source: https://blog.ssdnodes.com/blog/host-multiple-websites-docker-nginx/

## Prerequisite steps:

Run on host:
```bash
docker network create nginx-proxy

mkdir -p /src/docker/nginx-proxy/
curl https://raw.githubusercontent.com/jwilder/nginx-proxy/main/nginx.tmpl > /src/docker/nginx-proxy/nginx.tmpl
```

Then add the following into the docker compose of the containers that will use this proxy:
```yaml
expose:
  - 80

environment:
    - VIRTUAL_HOST=funkwhale.waller.rocks

networks:
  default:
    external:
      name: nginx-proxy
```