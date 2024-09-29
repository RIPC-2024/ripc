import os
import cv2

folder_path = "C:\\Users\\HPUser\\Desktop\\data_set\\car"
output_path = "C:\\Users\\HPUser\\Desktop\\data_set\\car_output"

# 폴더에 있는 파일 목록을 가져옴
files = os.listdir(folder_path)

# 파일 이름을 001부터 시작하도록 설정
file_index = 1
total_files = len(files)

for file in sorted(files):
    file_path = os.path.join(folder_path, file)

    if file.lower().endswith(('.png', '.jpg', '.jpeg')):

        image = cv2.imread(file_path)
        if image is None:
            print(f"Error loading image: {file}")
            continue
        
        # 진행 상황 출력 (파일 인덱스와 전체 파일 수를 이용하여 퍼센트 계산)
        print(f"Processing {file_index}/{total_files} ({(file_index/total_files)*100:.2f}%): {file}")

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

print("모든 작업 완료")
