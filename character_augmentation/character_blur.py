# blur 강도는 1,2,3까지만
import os
import cv2
import scipy
from scipy import ndimage
from google.colab import drive

# Google Drive 연결
drive.mount('/content/drive')

# 경로 설정
path = '/content/drive/My Drive/before_aug/character/images/train/'
output_path = '/content/drive/My Drive/after_blur/character/images/train/'
files = os.listdir(path)

for file in files:
    # 이미지 파일 읽기
    image = cv2.imread(os.path.join(path, file))

    if image is None:
        print(f"Error loading image: {file}")
        continue
    for cnt in range(1, 4):
      # 블러 적용
      blurred_f = ndimage.gaussian_filter(image, sigma=cnt)

      # 이미지 저장
      output_filename = os.path.join(output_path, f"blurred_{cnt}_{file}")
      cv2.imwrite(output_filename, blurred_f)
    print(f"Saved blurred image: {output_filename}")

print("All images have been blurred and saved.")
