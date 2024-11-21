# Dockerfile
# Node.js 기반 이미지 사용
FROM node:14

# 작업 디렉터리 설정
WORKDIR /usr/src/app

# package.json과 package-lock.json 복사 후 의존성 설치
COPY package*.json ./
RUN npm install

# 모든 파일 복사
COPY . .

# 서버 실행 포트 설정
EXPOSE 3000

# 서버 실행 명령어
CMD ["node", "server.js"]
