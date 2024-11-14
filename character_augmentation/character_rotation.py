import imgaug.augmenters as iaa
import cv2
from google.colab import drive
import os

# Google Drive 연결
drive.mount('/content/drive')

# 경로 설정
path = '/content/drive/My Drive/before_aug/character/images/train/'
output_path = '/content/drive/My Drive/after_rotation/character/images/train/'
files = os.listdir(path)

# -10도부터 +10도까지 0도 제외한 각도 리스트 생성
rotation_angles = [angle for angle in range(-10, 11) if angle != 0]  # -10, -9, ..., -1, 1, ..., 9, 10

for file in files:
    # 이미지 파일 읽기
    image = cv2.imread(os.path.join(path, file))

    if image is None:
        print(f"Error loading image: {file}")
        continue

    # 우측 상단 거의 최상단 픽셀의 RGB 값 확인 (예: 이미지의 (10, 너비-10) 위치)
    h, w, _ = image.shape
    top_right_pixel = image[10, w - 10]  # 우측 상단에서 약간 아래쪽 위치의 픽셀 값
    average_cval = int(top_right_pixel.mean())  # RGB 평균값을 사용하여 단일 값으로 변환

    # 각도 리스트에 따라 이미지를 회전하고 저장
    for angle in rotation_angles:
        # 각도를 사용하여 회전 증강 설정
        seq = iaa.Sequential([iaa.Affine(rotate=angle, cval=average_cval)])
        
        # 이미지 회전
        image_aug = seq(image=image)

        # 회전된 이미지 저장
        cv2.imwrite(os.path.join(output_path, f"rotate_{angle}_" + file), image_aug)

print("All images have been rotated and saved with 20 specific angles between -10 and +10 degrees, excluding 0.")
