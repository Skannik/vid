FROM node:18

WORKDIR /app

# Копируем package.json и package-lock.json для всех частей
COPY package*.json ./
COPY client/package*.json ./client/
COPY server/package*.json ./server/

# Устанавливаем зависимости для client
WORKDIR /app/client
RUN npm install

# Устанавливаем зависимости для server
WORKDIR /app/server
RUN npm install

# Возвращаемся в корень и ставим зависимости для корня
WORKDIR /app
RUN npm install

# Копируем весь проект
COPY . .

# Устанавливаем переменные окружения для портов
ENV PORT=8080
ENV SERVER_PORT=5000
ENV CLIENT_PORT=3000

# Для клиента: создаём .env с нужным портом
RUN echo "PORT=3000" > /app/client/.env

# Для сервера: создаём .env с нужными портами
RUN echo "PORT=5000" > /app/server/.env

# Открываем нужные порты
EXPOSE 3000 5000 8080

# Запускаем оба сервиса через npm run dev
CMD ["npm", "run", "dev"] 