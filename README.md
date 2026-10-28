# NGINX-WEB-SERVER

## About The Project

A Docker setup for an NGINX web server that serves static website content (`hello-world` and `hello-students`) using a custom NGINX configuration.

### Built With

- NGINX
- Docker
- Docker Compose

## Getting Started

### Prerequisites

- Docker and Docker Compose

### Running

```sh
docker compose up --build
```

The site is served on port 80, per `compose.yml`.

## Details

From the original README:

### Dockerfile

```Dockerfile
FROM nginx:mainline-alpine

# add static website content
COPY hello-world /app/hello-world
COPY hello-students /app/hello-students

# remove default configuration(s)
RUN rm /etc/nginx/conf.d/*

# add custom configuration
COPY ./.configuration /etc/nginx/conf.d
```

- The `hello-world` and `hello-students` directories contain the static website content served by NGINX.
- The `.configuration` directory contains the custom NGINX configuration file(s) (named with a `.conf` extension) that define the server block(s) for serving the content; they are mounted to `/etc/nginx/conf.d` in the container.

### NGINX Configuration

```nginx configuration
server {
    listen 80;
    listen [::]:80;
    server_name localhost;

    location /hello-world {
        root /app;
    }

    location /hello-students {
        alias /app/hello-students/;
    }
}
```

- `location /hello-world` uses `root /app`: the URL is appended to the root directory to locate the content.
- `location /hello-students` uses `alias /app/hello-students/`: the URL is not appended to the alias directory to locate the content.

## License

No license file is present in this repository.

## Contact

Dyrits - https://github.com/Dyrits
