  
FROM node:14 AS build-env
ADD . /app
WORKDIR /app
RUN npm i --production 

# config
ENV HUGO_VERSION=0.83.0

ENV HUGO_ID=hugo_${HUGO_VERSION}
RUN wget -O - https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_ID}_Linux-64bit.tar.gz | tar -xz -C /tmp \
    && mkdir -p /usr/local/bin \
    && mv /tmp/hugo /usr/local/bin/hugo \
    && rm -rf /tmp/${HUGO_ID}_linux_amd64 \
    && rm -rf /tmp/LICENSE.md \
    && rm -rf /tmp/README.md

RUN hugo

FROM gcr.io/distroless/nodejs:14
COPY --from=build-env /app /app 
WORKDIR /app
# RUN npm run start&

CMD ["npm run start"]