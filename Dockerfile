# Используем официальный Node.js образ
FROM node:18

# Устанавливаем рабочую директорию
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

# Открываем нужные порты
EXPOSE 3000 5000

# Запускаем оба сервиса через npm run dev
CMD ["npm", "run", "dev"] 