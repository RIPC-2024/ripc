import torch
import cv2

# YOLOv5 모델 로드
model_path = "best.pt"  # 가중치 파일 경로
model = torch.hub.load('ultralytics/yolov5', 'custom', path=model_path, force_reload=True)

# 웹캠 연결
cap = cv2.VideoCapture(0)  # 0번 카메라 (기본 웹캠)

# 카메라 확인
if not cap.isOpened():
    print("카메라를 열 수 없습니다.")
    exit()

print("YOLOv5 모델 로드 완료! 웹캠 시작...")

try:
    while True:
        ret, frame = cap.read()
        if not ret:
            print("카메라에서 영상을 읽을 수 없습니다.")
            break

        # YOLOv5 모델로 객체 탐지
        results = model(frame)

        # 탐지 결과 이미지 렌더링
        rendered_frame = results.render()[0]

        # 화면에 출력
        cv2.imshow("YOLOv5 Detection", rendered_frame)

        # 'q' 키를 누르면 종료
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break
finally:
    cap.release()
    cv2.destroyAllWindows()
    print("프로그램 종료.")
