docker build -t openai-proxy:v1 .
docker run -p 9000:9000 --restart=always --name openai-proxy openai-proxy:v1
