FROM node:20

WORKDIR /app
COPY package*.json ./
# Mise à jour de npm et installation de Nest CLI
RUN npm install -g npm@11.2.0 @nestjs/cli
RUN npm install
COPY . .
# 3. Utiliser le CLI installé localement dans node_modules
RUN nest build
EXPOSE 3002
CMD ["node", "dist/main.js"]
