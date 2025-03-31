# Utiliser une image Node.js légère
FROM node:20



# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de dépendances
COPY package*.json ./

# Mise à jour de npm et installation de Nest CLI
RUN npm install -g npm@11.2.0 @nestjs/cli

# Installer les dépendances
RUN npm install


# Copier le reste du code
COPY . .

# Construire l'application NestJS
# 3. Utiliser le CLI installé localement dans node_modules
RUN nest build

# Exposer le port sur lequel l'API Gateway écoute
EXPOSE 3000

# Démarrer l'application
CMD ["node", "dist/main.js"]