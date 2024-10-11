FROM nginx:mainline-alpine

# add static website content
COPY hello-world /app/hello-world
COPY hello-students /app/hello-students

# remove default configuration(s)
RUN rm /etc/nginx/conf.d/*

# add custom configuration
COPY ./.configuration /etc/nginx/conf.d