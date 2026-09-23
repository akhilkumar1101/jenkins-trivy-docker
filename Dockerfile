FROM node:20-alpine

WORKDIR /app

COPY app/package.json .

COPY app/app.js .

EXPOSE 3000

CMD ["npm", "start"]
