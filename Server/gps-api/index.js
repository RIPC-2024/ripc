// index.js
const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

// JSON 요청을 처리할 수 있도록 설정
app.use(express.json());

// GPS 데이터를 처리하는 API
app.post('/gps', (req, res) => {
  const gpsData = req.body;
  console.log('Received GPS data:', gpsData);

  // 여기에 데이터를 저장하거나 처리하는 로직을 추가할 수 있어

  res.status(200).send('GPS data received and processed.');
});

// 서버 시작
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
