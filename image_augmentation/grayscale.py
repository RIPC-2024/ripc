import imgaug as ia # 이미지 증강 library
import imgaug.augmenters as iaa # 다양한 증강기
import imageio.v2 as imageio # 이미지 입출력
from imgaug.augmentables.bbs import BoundingBox, BoundingBoxesOnImage
import cv2 # 이미지 처리를 위함
from google.colab.patches import cv2_imshow # google colab에서 이미지를 보여주기 위한 패치(cv2_imshow) 임포
from os import listdir # 디렉토리의 파일 리스트를 얻기 위한 함수 임포트
import os

from google.colab import drive
drive.mount('/content/drive')

# 경로 확인
path = '/content/drive/My Drive/original_flipflop/car/images/train/images_up/'
files = os.listdir(path)

ia.seed(1)
# print(os.path.exists(path))  # 경로가 존재하면 True, 존재하지 않으면 False 출력

for file in files: # 해당 경로에 있는 모든 파일에 대해

  image = cv2.imread(path+file) # 파일 경로를 이용해 이미지 파일을 읽어옴

  # ex) image1.jpg 라는 파일이 있으면, 그와 동일한 이름의 라벨 파일이 image1.txt 라는 이름으로 존재한다고 가정함
  labelfile = file.replace('.jpg','.txt') # 이미지 파일의 확장자를 '.txt'로 바꾸어 라벨 파일명 생성

  f = open('/content/drive/My Drive/original_flipflop/car/labels/train/labels_up/'+labelfile) # 사진에 맞는 라벨 파일 열기
  boundingboxes = f.readlines() # 라벨 파일에서 바운딩 박스 정보를 한 줄씩 읽어 리스트로 저장

  for i in range(len(boundingboxes)): # 각 바운딩 박스에 대해 반복문 실행하여 string을 int, float로 바꿔줌
    boundingboxif = boundingboxes[i].split(" ")
    for j in range(len(boundingboxif)):
      if boundingboxif[j] == '0': # 자동차
        boundingboxif[j] = 0
      elif boundingboxif[j] == '1': # 오토바이
        boundingboxif[j] = 1
      elif boundingboxif[j] == '2': # LP
        boundingboxif[j] = 2
      else:
        x = float(boundingboxif[j])
        boundingboxif[j] = x
    boundingboxes[i] = boundingboxif
  # 바운딩박스의 [x1, y1, x2, y2]를 담는 리스트를 만듦
  boundingbox_newif = []

  for i in range(len(boundingboxes)):
    x_center = boundingboxes[i][1]
    y_center = boundingboxes[i][2]
    height = boundingboxes[i][4]*640
    width = boundingboxes[i][3]*640

    x_center_new = x_center*640
    y_center_new = y_center*640

    x1 = (x_center_new-width/2)
    y1 = (y_center_new-height/2)
    x2 = (x_center_new+width/2)
    y2 = (y_center_new+height/2)

    boundingbox_newif.append([x1,y1,x2,y2]) # 이 리스트엔 라벨값은 안 들어감

  ia_bounding_boxes = []
  if image is None:
    print("Error loading image: {file}")

  for box in boundingbox_newif:
    ia_bounding_boxes.append(ia.BoundingBox(x1 = box[0], y1 = box[1], x2 = box[2], y2 = box[3])) # BoundingBox 객체 생성 후 리스트에 추가
  # bbs는 이미지 위에 어떤 위치에 바운딩 박스가 존재하는지를 정의한 객체임
  # 이 bbs 객체는 이후 이미지에 변환(예: 회전, 스케일링 등)을 적용할 때 바운딩 박스들도 함께 변환할 수 있도록 도와줌
  bbs =ia.BoundingBoxesOnImage(ia_bounding_boxes, shape = image.shape) # 이미지의 크기에 맞는 BoundingBoxesOnImage 객체를 생성하여 바운딩박스 리스트와 이미지 모양(shape)을 연결

  seq = iaa.Sequential([iaa.Grayscale(alpha=1.0)]) # 그레이스케일 변환

  # Augment images and BBs
  image_aug, bbs_aug = seq(image = image, bounding_boxes = bbs) # image_aug: 증강된 이미지, bbs_aug: 증강된 바운딩박스
  print(bbs_aug)
  # 객체의 위치가 변하기에 label파일의 BB의 값도 변경해서 저장해야한다.
  cv2.imwrite('/content/drive/My Drive/after_grayscale/car/images/train/' + "grayscale__" + file, image_aug) # 회전된 이미지 저장

  # 회전된 바운딩 박스 좌표 가져오기
  after_bounding = []
  my_i = 0
  for bb_aug, original_box in zip(bbs_aug.bounding_boxes, boundingbox_newif): # bbs_aug.bounding_boxes: 이미지 증강(회전) 후 변형된 바운딩 박스들
    x1_aug, y1_aug, x2_aug, y2_aug = bb_aug.x1, bb_aug.y1, bb_aug.x2, bb_aug.y2
    # YOLO 형식으로 변환 (x_center, y_center, width, height) 이미지 크기 비율 기준으로 계산
    x_center_aug = (x1_aug + x2_aug) / 2 / 640
    y_center_aug = (y1_aug + y2_aug) / 2 / 640
    width_aug = (x2_aug - x1_aug) / 640
    height_aug = (y2_aug - y1_aug) / 640

    # 클래스 ID와 함께 추가
    after_bounding.append([int(boundingboxes[my_i][0]), x_center_aug, y_center_aug, width_aug, height_aug])
    my_i = my_i + 1

  f = open('/content/drive/My Drive/after_grayscale/car/labels/train/' + "grayscale_" + labelfile, "w") # 회전 정보를 담은 label파일 저장
  for i in range(len(after_bounding)):
    for j in range(5): # 각 바운딩 박스의 5개의 값 (클래스, )
      if j == 4: # 마지막 값일 때
        f.write(str(after_bounding[i][j])) # 줄바꿈 없이 마지막 값을 파일에 기록
      else:
        f.write(str(after_bounding[i][j]) + " ") # 값 뒤에 공백을 추가하고 기록
      print(str(i) + " : " + str(after_bounding[i][j]))
    f.write("\n")

  f.close()
