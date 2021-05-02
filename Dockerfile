  
FROM node:14 AS build-env
ADD . /app
WORKDIR /app
RUN npm i --production 

FROM gcr.io/distroless/nodejs:14
COPY --from=build-env /app /app 
WORKDIR /app
CMD ["npm run start"]