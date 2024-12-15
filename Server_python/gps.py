import os
import time
from geopy.distance import geodesic  # 설치 필요: pip install geopy

# 목표 GPS 위치 및 반경 (미터 단위)
target_location = (37.5665, 126.9780)  # 예: 서울시청 위치
radius = 50  # 50미터

def get_current_gps():
    import random

    # GPS 범위를 약간 변경하여 테스트 값 생성
    latitude = 37.5665 + random.uniform(-0.0005, 0.0005)
    longitude = 126.9780 + random.uniform(-0.0005, 0.0005)
    return (latitude, longitude)

def is_within_radius(current_location, target_location, radius):
    # 현재 위치가 목표 위치 반경 내에 있는지 확인
    distance = geodesic(current_location, target_location).meters
    print(f"Current distance: {distance:.2f} meters")
    return distance <= radius

def main():
    print("Monitoring GPS location...")
    while True:
        current_location = get_current_gps()
        print(f"Current GPS location: {current_location}")

        if is_within_radius(current_location, target_location, radius):
            print("Target location reached! Running detect.py...")
            os.system("python detect.py")  # detect.py 실행
            break  # 한 번 실행 후 종료. 필요 시 제거하여 반복 실행 가능

        time.sleep(5)  # 5초마다 확인

if __name__ == "__main__":
    main()
