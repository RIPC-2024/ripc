import os
import cv2

# 경로 설정
folder_path = "C:\\Users\\HPUser\\Desktop\\data_set\\car"
output_path = "C:\\Users\\HPUser\\Desktop\\data_set\\car_output"

# 폴더에 있는 파일 목록을 가져옴
files = os.listdir(folder_path)

# 파일 이름을 001부터 시작하도록 설정
file_index = 1

for file in sorted(files):
    file_path = os.path.join(folder_path, file)
    
    # 이미지 파일만 처리하기 위해 확장자 확인
    if file.lower().endswith(('.png', '.jpg', '.jpeg')):

        image = cv2.imread(file_path)
        if image is None:
            print(f"Error loading image: {file}")
            continue
        
        if file.lower().endswith('.png'):

            image = cv2.resize(image, (640, 640))
            new_filename = f"{file_index:03}.jpg"  # 001, 002, 003 등
            new_file_path = os.path.join(output_path, new_filename)
            cv2.imwrite(new_file_path, image)
            
            file_index += 1
        else:
            image = cv2.resize(image, (640, 640))
            new_filename = f"{file_index:03}.jpg"
            new_file_path = os.path.join(output_path, new_filename)
            cv2.imwrite(new_file_path, image)
            
            file_index += 1

print("작업 완료")
