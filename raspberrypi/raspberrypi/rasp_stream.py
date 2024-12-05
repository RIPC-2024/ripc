import cv2
import requests

def stream_video(api_url):
    cap = cv2.VideoCapture(0)  # 0번 카메라 사용
    while cap.isOpened():
        ret, frame = cap.read()
        if ret:
            # 프레임을 JPEG 형식으로 인코딩
            _, buffer = cv2.imencode('.mp4', frame)

            # HTTP POST로 전송
            response = requests.post(api_url, files={'video': ('frame.mp4', buffer.tobytes())})
            print(f"Response: {response.status_code}, {response.text}")
        else:
            break

    cap.release()

# 호출
stream_video('http://your-server-ip:5000/upload')
