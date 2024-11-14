import imgaug as ia  # 이미지 증강 라이브러리
import imgaug.augmenters as iaa  # 다양한 증강기
import cv2  # 이미지 처리를 위함
import os
from google.colab import drive  # Google Drive 연결

# Google Drive 연결
drive.mount('/content/drive')

# 경로 설정
path = '/content/drive/My Drive/before_aug/character/images/train/'
output_path = '/content/drive/My Drive/after_shear/character/images/train/'
files = os.listdir(path)

ia.seed(1)

for a in range(1, 11):  # 시드 변경하여 두 번의 증강 수행
    ia.seed(a)  # 시드 설정

    for file in files:  # 해당 경로에 있는 모든 파일에 대해

        # 이미지 파일 읽기
        image = cv2.imread(path + file)

        if image is None:
            print(f"Error loading image: {file}")
            continue

        # 우측 상단 거의 최상단 픽셀의 RGB 값 확인 (예: 이미지의 (10, 너비-10) 위치)
        h, w, _ = image.shape
        top_right_pixel = image[10, w - 10]  # 우측 상단에서 약간 아래쪽 위치의 픽셀 값
        average_cval = int(top_right_pixel.mean())  # RGB 평균값을 사용하여 단일 값으로 변환

        # 옆으로 기울이는 증강을 적용하는 시퀀스
        seq = iaa.Affine(shear=(-10, 10),cval = average_cval)  # -10도에서 +10도 사이로 무작위 기울이기

        # 이미지 증강 적용
        image_aug = seq(image=image)

        cv2.imwrite(os.path.join(output_path, f"shear_{a}_" + file), image_aug)  # 증강 후 파일 저장
        print(f"Saved augmented image: shear_{a}_{file}")

print("All images have been augmented and saved with shear transformation.")
