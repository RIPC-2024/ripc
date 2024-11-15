import imgaug as ia
import imgaug.augmenters as iaa
import cv2
import os
from google.colab import drive

# Google Drive 연결
drive.mount('/content/drive')

# 경로 설정
path = '/content/drive/My Drive/after_shear/character/images/train/'
output_path = '/content/drive/My Drive/after_huesat/character/images/train/'
files = os.listdir(path)

ia.seed(1)
os.makedirs(output_path, exist_ok=True)  # 출력 경로 생성

total_processed = 0  # 처리된 파일 수를 카운트
total_saved = 0  # 저장된 파일 수를 카운트

for a in range(1, 3):
    ia.seed(a)

    for file in files:
        file_path = os.path.join(path, file)

        # 파일 확장자 확인
        if not file.lower().endswith(('.png', '.jpg', '.jpeg')):
            print(f"Skipping non-image file: {file}")
            continue

        # 이미지 읽기
        image = cv2.imread(file_path)
        if image is None:
            print(f"Error loading image: {file}")
            continue

        total_processed += 1

        # 색조 및 채도 증강
        seq = iaa.AddToHueAndSaturation((-30, 30))
        image_aug = seq(image=image)

        # 출력 파일 이름 설정 및 저장
        output_file_path = os.path.join(output_path, f"huesat_{a}_{os.path.splitext(file)[0]}.jpg")
        if cv2.imwrite(output_file_path, image_aug):
            total_saved += 1
        else:
            print(f"Failed to save image: {output_file_path}")

print(f"Total processed: {total_processed}")
print(f"Total saved: {total_saved}")
print("All images have been processed.")
