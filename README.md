# A simple proxy server for using OpenAI anywhere

## How to use
```bash
bash build.sh
```
This script will build the docker image and run it on port 9000. You can change the port by editing the `build.sh` file.

## How to access via Nginx (not necessary)
Create a new server block in your nginx config file, and add the following:
```nginx
# set proxy
location /v1
{
    proxy_pass http://127.0.0.1:9000/v1/;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header REMOTE-HOST $remote_addr;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection $connection_upgrade;
    proxy_http_version 1.1;
    proxy_read_timeout 150;
    # proxy_hide_header Upgrade;

    add_header X-Cache $upstream_cache_status;

}
# set error page
error_page 502 500 =503 /503.html;
location /503.html{
  add_header Content-Type "application/json; charset=utf-8" always;
  return 503 '{"msg": "Proxy Server Error"}';
}
```