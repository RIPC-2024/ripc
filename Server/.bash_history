mkdir ~/my_parking_project
cd ~/my_parking_project
nano app.py
python3 app.py
pip3 install gunicorn
gunicorn --bind 0.0.0.0:5000 app:app
nano app.py
python3 app.py
gunicorn --bind 0.0.0.0:5000 app:app --daemon
gunicorn --bind 0.0.0.0:5000 app:app
python3 app.py
gcloud compute scp ~/app.py <YOUR_VM_NAME>:~/ --zone=<YOUR_VM_ZONE>
gcloud compute scp ~/app.py <instance-20240922-105859>:~/ --zone=<asia-northeast3-a>
sudo apt update
sudo apt install python3-pip
pip3 install flask
python3 app.py
pip3 install gunicorn
gunicorn --bind 0.0.0.0:5000 app:app
http://<34.64.35.10>:5000/api/parking-violation
python3 app.py
http://<10.88.0.4>:5000/api/parking-violation
http://<10.88.0.4:5000/api/parking-violation
http://<127.0.0.1>:5000/api/parking-violation
http://<10.178.0.2>:5000/api/parking-violation
http://<0.0.0.0>:5000/api/parking-violation
http://<0.0.0.0>:5000/api/app.py
http://<34.64.35.10>:5000/api/app.py
cd
cd parking_project
cd parking
mkdir gps-api
cd gps-api
npm init -y
npm install express
// index.js
const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
// JSON 요청을 처리할 수 있도록 설정
app.use(express.json());
// GPS 데이터를 처리하는 API
app.post('/gps', (req, res) => {
});
// 서버 시작
app.listen(port, () => {
});
node index.js
mkdir index.js
cd index.js
cd gps-api
q
cd r
code index.js
cd ..
code index.js
nano index.js
rmdir index.js
nano index.js
node index.js
mkdir license-plate-project
cd license-plate-project
touch apiService.js server.js
nano apiService.js
nano server.js
npm init -y
npm install express pg axios body-parser
nano apiService.js
run server.js
npm install
cd ripc
cd license-plate-project
nano server.js
nano apiService.js 
cd license-plate-project
node server.js
cd license-plate-project
node server.js
nano server.js
node server.js
node apiServer.js
node server.js
touch Dockerfile
nano Dockerfile
cd license-plate-project
nano Dockerfile
gcloud run deploy --source .
node server.js
cd license-plate-project
nano apiServer.js
nano apiService.js
cd license-plate-project
node server.js
nano apiService.js
nano server.js
node server.js
npm install
node server.js
nano server.js
node server.js
cd license-plate-project
node server.js
cd ripc_server
node server.js
node apiService.js
node server.js
cd ripc_server
node server.js
port 3000
port: 3000
cd ripc_server
nano server.js
