import torch
import cv2
import pymysql  # MySQL 연결을 위한 라이브러리

# YOLOv5 모델 로드
model_path = "best.pt"  # 가중치 파일 경로
model = torch.hub.load('ultralytics/yolov5', 'custom', path=model_path, force_reload=True)

# 웹캠 연결
cap = cv2.VideoCapture(0)  # 0번 카메라 (기본 웹캠)

# 데이터베이스 연결 설정
DB_HOST = "<GCP_MYSQL_HOST>"  # GCP MySQL 호스트 주소
DB_USER = "<DB_USER>"         # 데이터베이스 사용자
DB_PASSWORD = "<DB_PASSWORD>" # 데이터베이스 비밀번호
DB_NAME = "<DB_NAME>"         # 데이터베이스 이름

try:
    # MySQL 연결
    conn = pymysql.connect(host=DB_HOST, user=DB_USER, password=DB_PASSWORD, database=DB_NAME)
    cursor = conn.cursor()
    print("데이터베이스 연결 성공!")
except Exception as e:
    print(f"데이터베이스 연결 실패: {e}")
    exit()

# 카메라 확인
if not cap.isOpened():
    print("카메라를 열 수 없습니다.")
    exit()

print("YOLOv5 모델 로드 완료! 웹캠 시작...")

def save_to_db(plate_text):
    """번호판 정보를 데이터베이스에 저장하는 함수"""
    try:
        query = "INSERT INTO license_plates (plate_number, detected_at) VALUES (%s, NOW())"
        cursor.execute(query, (plate_text,))
        conn.commit()
        print(f"번호판 '{plate_text}' 저장 완료!")
    except Exception as e:
        print(f"DB 저장 중 오류 발생: {e}")

try:
    while True:
        ret, frame = cap.read()
        if not ret:
            print("카메라에서 영상을 읽을 수 없습니다.")
            break

        # YOLOv5 모델로 객체 탐지
        results = model(frame)

        # 탐지 결과 처리
        for det in results.xyxy[0]:  # 각 탐지 결과에 대해
            x1, y1, x2, y2, conf, cls = det  # 바운딩 박스 좌표, 신뢰도, 클래스
            label = results.names[int(cls)]

            if label == "license_plate":  # 'license_plate' 클래스만 처리
                # 번호판 영역 추출
                plate_region = frame[int(y1):int(y2), int(x1):int(x2)]

                # 번호판 OCR 처리 (여기서는 간단히 번호판 텍스트로 가정)
                plate_text = "EXAMPLE123"  # 실제로는 OCR 모델을 사용하여 추출해야 함

                # 번호판 정보 데이터베이스에 저장
                save_to_db(plate_text)

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
    cursor.close()
    conn.close()
    print("프로그램 종료 및 데이터베이스 연결 종료.")
