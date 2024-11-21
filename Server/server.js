// server.js
const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const { Pool } = require('pg');
const fetchIllegalParkingLocations = require('./apiService'); // API 함수 불러오기

app.use(bodyParser.json());

// PostgreSQL DB 연결 설정
const pool = new Pool({
  user: 'your_db_user',
  host: 'your_db_host',
  database: 'your_db_name',
  password: 'your_db_password',
  port: 5432,
});

// 불법 주정차 위치 정보 배열
let illegalParkingLocations = [];

// 위치 정보 업데이트
async function updateIllegalParkingLocations() {
  illegalParkingLocations = await fetchIllegalParkingLocations();
}

// 서버 시작 시와 매시간 주기적으로 위치 정보 업데이트
updateIllegalParkingLocations();
setInterval(updateIllegalParkingLocations, 60 * 60 * 1000);

// GPS 위치 정보 수신 엔드포인트
app.post('/api/location', async (req, res) => {
  const { vehicle_number, latitude, longitude } = req.body;

  const isIllegalParkingLocation = (lat, lng) => {
    return illegalParkingLocations.some(loc => {
      const distance = Math.sqrt(Math.pow(loc.latitude - lat, 2) + Math.pow(loc.longitude - lng, 2));
      return distance < 0.001;
    });
  };

  if (isIllegalParkingLocation(latitude, longitude)) {
    try {
      const query = `
        INSERT INTO vehicle_info (vehicle_number, latitude, longitude)
        VALUES ($1, $2, $3)
      `;
      await pool.query(query, [vehicle_number, latitude, longitude]);
      res.status(201).json({ message: 'Illegal parking location detected and saved.' });
    } catch (error) {
      console.error('Error saving location:', error);
      res.status(500).json({ message: 'Error saving location' });
    }
  } else {
    res.status(200).json({ message: 'Location does not match illegal parking zone.' });
  }
});
// updateIllegalParkingLocations 함수 내부에 로그 추가
async function updateIllegalParkingLocations() {
  illegalParkingLocations = await fetchIllegalParkingLocations();
  console.log('Updated illegal parking locations:', illegalParkingLocations); // 콘솔 로그 추가
}


// 서버 실행
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
