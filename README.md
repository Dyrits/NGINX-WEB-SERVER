# NGINX Web Server

## Dockerfile 

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

### Explanation

- `FROM nginx:mainline-alpine` - Use the official NGINX image as the base image.
- `COPY hello-world /app/hello-world` - Copy the `hello-world` directory to `/app/hello-world` in the container.
- `COPY hello-students /app/hello-students` - Copy the `hello-students` directory to `/app/hello-students` in the container.
- `RUN rm /etc/nginx/conf.d/*` - Remove the default configuration(s) in the container.
- `COPY ./.configuration /etc/nginx/conf.d` - Copy the custom configuration from the `.configuration` directory to `/etc/nginx/conf.d` in the container.


- The custom configuration will be used by NGINX to serve the static website content.
- The `hello-world` and `hello-students` directories contain the static website content that will be served by NGINX.
- The `.configuration` directory contains the custom NGINX configuration file(s) that define how the static website content should be served.
- The custom configuration file(s) should be named with a `.conf` extension and placed in the `.configuration` directory.
- The custom configuration file(s) should define the server block(s) that specify the server name(s), root directory(ies), and other settings for serving the static website content.
- The custom configuration file(s) should be mounted to the `/etc/nginx/conf.d` directory in the container to be used by NGINX.

## NGINX Configuration

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

### Explanation

- `server` block - Defines the server configuration for NGINX.
- `listen 80` - Specifies that NGINX should listen on port 80 for incoming requests (IPV4).
- `listen [::]:80` - Specifies that NGINX should listen on port 80 for incoming requests (IPV6).
- `server_name localhost` - Specifies the server name for the NGINX server block.
- `location /hello-world` - Defines a location block for the `/hello-world` URL path.
- `root /app` - Specifies the root directory for serving the content of the `/hello-world` URL path. The URL will be appended to the root directory to locate the content.
- `location /hello-students` - Defines a location block for the `/hello-students` URL path.
- `alias /app/hello-students/` - Specifies the alias directory for serving the content of the `/hello-students` URL path. The URL will not be appended to the alias directory to locate the content.

- The custom NGINX configuration file(s) should define the server block(s) that specify the server name(s), root directory(ies), and other settings for serving the static website content.
- The custom configuration file(s) should be mounted to the `/etc/nginx/conf.d` directory in the container to be used by NGINX.
- The custom configuration file(s) should be named with a `.conf` extension and placed in the `.configuration` directory.

## Docker Compose

```yaml
services:
  webserver:
    restart: on-failure
    env_file:
      - .env
    image: "webserver:${VERSION}"
    build:
      context: ./
      dockerfile: Dockerfile
    ports:
      - "80:80"
```

### Explanation

- `services` - Defines the services that will be managed by Docker Compose.
- `webserver` - Specifies the name of the service.
- `restart: on-failure` - Specifies that the service should be restarted automatically if it fails.
- `env_file: .env` - Specifies the environment file that will be used for the service.
- `image: "webserver:${VERSION}"` - Specifies the name and tag of the image that will be used for the service.
- `build` - Specifies the build context and Dockerfile for building the image.
- `context: ./` - Specifies the build context as the current directory.
- `dockerfile: Dockerfile` - Specifies the Dockerfile that will be used for building the image.
- `ports` - Specifies the port mapping for the service.
- `"80:80"` - Maps port 80 on the host machine to port 80 in the container.
- 
- The Docker Compose file should be used to define the services, build context, Dockerfile, and port mapping for the NGINX web server.
- The NGINX web server image should be built using the custom Dockerfile that includes the static website content and custom configuration.
- The NGINX web server should be accessible on port 80 of the host machine.
- The NGINX web server should serve the static website content using the custom configuration defined in the NGINX configuration file(s).
- The NGINX web server should be automatically restarted if it fails.
- The NGINX web server should be managed by Docker Compose for easy deployment and management.

## Build and push the image

### Build the image

The image is automatically built when the Docker Compose file is used to deploy the NGINX web server. The image name and tag are specified in the Docker Compose file.

To do it manually from the Dockerfile, run the following command:

```bash
docker build -t webserver:latest ./
```

### Push the image to a registry

To push the image to a registry, you need to tag the image with the registry URL and then push it using the `docker push` command.

```bash
docker push registry.example.com/webserver:latest
```

By default, Docker Hub is used as the registry. You can log in to Docker Hub using the `docker login` command and then push the image to Docker Hub.

```bash
docker login
docker push username/webserver:latest
```

### Get the image from the registry

To get the image from the registry, you can use the `docker pull` command.

```bash
docker pull registry.example.com/webserver:latest
```

From Docker Hub:

```bash
docker pull username/webserver:latest
```

You can also directly run the image using the `docker run` command.

```bash
docker run -d -p 80:80 webserver:latest
```

If the image is not found locally, Docker will automatically pull it from the registry before running it.