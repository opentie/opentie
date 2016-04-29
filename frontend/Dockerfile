FROM nginx:1.9
COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN mkdir /public
WORKDIR /public
ADD public /public
