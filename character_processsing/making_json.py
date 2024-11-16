import os
import json

image_folder = "ocr_data_24_32/images/"  # 이미지가 저장된 폴더 경로
output_json_path = "ocr_data_24_32_jw.json"  # 저장할 JSON 파일 경로

# 문자열 매핑 (영문 → 한글 또는 숫자)
text_mapping = {
    "ga": "가", "na": "나", "da": "다", "ra": "라", "ma": "마", "ha": "하", "ba": "바", "sa": "사", "ja": "자",
    "geo": "거", "neo": "너", "deo": "더", "reo": "러", "meo": "머", "beo": "버", "seo": "서", "oeo": "어", 
    "jeo": "저", "bae": "배", "heo": "허",
    "gu": "구", "nu": "누", "du": "두", "ru": "루", "mu": "무", "bu": "부", "su": "수", "u": "우", "ju": "주",
    "go": "고", "no": "노", "do": "도", "ro": "로", "mo": "모", "bo": "보", "so": "소", "jo": "조", "ho": "호",
    "a": "아", "o": "오",
    "one": "1", "two": "2", "three": "3", "four": "4", "five": "5",
    "six": "6", "seven": "7", "eight": "8", "nine": "9", "zero": "0"
}

def create_json_from_images(image_folder, output_json_path):
    # JSON 데이터를 저장할 딕셔너리
    json_data = {}
    cnt_error = 0  # 매핑되지 않는 항목 개수
    unmapped_images = []  # 매핑되지 않은 이미지 이름 저장
    cnt = 0

    # 폴더 내 이미지 파일 순회
    for image_file in os.listdir(image_folder):
        if image_file.lower().endswith(('.jpg', '.jpeg', '.png', '.bmp', '.gif')):  # 이미지 파일 필터링
            # 이미지 파일 크기
            file_path = os.path.join(image_folder, image_file)
            file_size = os.path.getsize(file_path)
            
            text_value = ""
            
            # 파일 이름 처리
            if len(image_file) >= 4:
                # '_'로 나누고 마지막 부분 추출
                parts = image_file.split('_')
                last_part_with_extension = parts[-1]  # 마지막 부분 (예: "bae1.jpg")
                last_part = os.path.splitext(last_part_with_extension)[0]  # 확장자 제거 (예: "bae1")
                
                # 숫자 제거
                cleaned_last_part = ''.join([char for char in last_part if not char.isdigit()])  # 숫자 제거 (예: "bae")
                
                # 매핑
                if cleaned_last_part in text_mapping:
                    text_value = text_mapping[cleaned_last_part]
                else:
                    # 매핑되지 않는 경우 처리
                    cnt_error += 1
                    unmapped_images.append(image_file)

            # JSON 항목 생성
            key = f"{image_file}{file_size}"  # 파일 이름 + 크기를 키로 사용
            json_data[key] = {
                "filename": image_file,
                "regions": {
                    "0": {
                        "shape_attributes": {
                            "x": 0,
                            "y": 0,
                            "width": 24,
                            "height": 32
                        },
                        "region_attributes": {
                            "text": text_value
                        }
                    }
                }
            }
            cnt = cnt + 1

    # 매핑되지 않은 항목 출력
    if unmapped_images:
        print("매핑되지 않은 이미지 파일들:")
        for img in unmapped_images:
            print(f"  - {img}")
    print(f"매핑되지 않은 항목 개수: {cnt_error}")
    print(f"매핑된 항목 개수: {cnt}")

    
    # JSON 데이터 저장
    with open(output_json_path, "w", encoding="utf-8") as json_file:
        json.dump(json_data, json_file, indent=4, ensure_ascii=False)  # ensure_ascii=False로 한글 저장
    print(f"JSON 파일이 저장되었습니다: {output_json_path}")

create_json_from_images(image_folder, output_json_path)
