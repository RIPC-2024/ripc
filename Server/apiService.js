// apiService.js
const axios = require('axios');

// OpenAPI 인증 키와 기본 URL
const API_KEY = '585061417465686438374361416256';
const BASE_URL = 'http://openapi.seoul.go.kr:8088/sample/xml/TbOpendataFixedcctv/1/5/';

// 불법 주정차 위치 정보 가져오기 함수
async function fetchIllegalParkingLocations() {
  try {
    const response = await axios.get(BASE_URL, {
      params: { serviceKey: API_KEY, type: 'json' }
    });
    
    const locations = response.data.response.body.items;

    // 위도와 경도만 추출 후 중복 제거
    const uniqueLocations = Array.from(new Set(
      locations.map(item => `${item.latitude},${item.longitude}`)
    )).map(coord => {
      const [latitude, longitude] = coord.split(',');
      return { latitude: parseFloat(latitude), longitude: parseFloat(longitude) };
    });

    console.log('Fetched illegal parking locations:', uniqueLocations);
    return uniqueLocations;
  } catch (error) {
    console.error('Error fetching illegal parking locations:', error);
    return [];
  }
}

module.exports = fetchIllegalParkingLocations;




