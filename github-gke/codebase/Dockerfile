FROM node:carbon

LABEL Jose Barahona<jrab6692@gmail.com>: 0.1
# Crear directorio

WORKDIR /usr/src/app

COPY package*.json ./

# instalar dependencias

RUN npm install

# Copiar codigo fuente
COPY . .


#puerto 
EXPOSE 8080

CMD [ "npm", "start" ]

