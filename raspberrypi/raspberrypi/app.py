from flask import Flask, request
from google.cloud import storage
import os

app = Flask(__name__)

# GCP 서비스 계정 인증
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = 'service-account-key.json'

# Cloud Storage 클라이언트 생성
storage_client = storage.Client()
bucket_name = 'raspberry-pi-video-storage'  # 생성한 버킷 이름

@app.route('/upload', methods=['POST'])
def upload_video():
    file = request.files['video']
    blob_name = f"videos/{file.filename}"

    # Cloud Storage에 업로드
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(blob_name)
    blob.upload_from_file(file)

    return f"Uploaded {blob_name} to {bucket_name}."

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
