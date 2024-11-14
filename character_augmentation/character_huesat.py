import imgaug as ia  # 이미지 증강 라이브러리
import imgaug.augmenters as iaa  # 다양한 증강기
import cv2  # 이미지 처리를 위함
import os
from google.colab import drive  # Google Drive 연결

# Google Drive 연결
drive.mount('/content/drive')

# 경로 설정
path = '/content/drive/My Drive/before_aug/character/images/train/'
output_path = '/content/drive/My Drive/after_huesat/character/images/train/'
files = os.listdir(path)

ia.seed(1)

for a in range(1, 3):  # 시드 변경하여 두 번의 증강 수행
    ia.seed(a)  # 시드 설정
    
    for file in files:  # 해당 경로에 있는 모든 파일에 대해
        
        # 이미지 파일 읽기
        image = cv2.imread(path + file)
        
        if image is None:
            print(f"Error loading image: {file}")
            continue
        
        # 색조 변환 증강을 적용하는 시퀀스 (좌우 반전 없이 색조와 채도만 변경)
        seq = iaa.AddToHueAndSaturation((-30, 30))  # 색조를 -30에서 +30 범위로 변경
        
        # 이미지 증강 적용
        image_aug = seq(image=image)
        
        # 증강된 이미지 저장
        cv2.imwrite(os.path.join(output_path, f"huesat_{a}_" + file), image_aug)  # 증강 후 파일 저장
        print(f"Saved augmented image: huesat_{a}_{file}")

print("All images have been augmented and saved with hue and saturation changes.")
