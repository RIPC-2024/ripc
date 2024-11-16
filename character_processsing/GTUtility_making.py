import numpy as np
import json
import os
from PIL import Image

from ssd_data import BaseGTUtility


class GTUtility(BaseGTUtility):
    def __init__(self, data_path, validation=False, only_with_label=True):
        test = False
        cnt = 0
        self.data_path = data_path
        gt_path = data_path
        self.image_path = data_path
        self.gt_path = gt_path
        self.classes = ['Background', 'text']

        self.image_names = []
        self.data = []
        self.text = []

        with open(os.path.join(gt_path, 'ocr_data_24_32_jw.json'),encoding='UTF8') as f: # json path 바뀌면 여기도 바껴야함
            gt_data = json.load(f)

        for img_id in gt_data.keys():  # images
            if len(img_id) > 0:
                img_data = gt_data[img_id]
                image_name = img_data['filename']

                boxes = []
                text = []
                image_path = os.path.join('ocr_images', image_name) # 이미지 path 바뀌면 여기도 바껴야함
                if not os.path.exists(image_path):
                    print(f"Image file not found: {image_path}")
                    continue

                image = Image.open(image_path)

                width, height = image.size

                img_width = width
                img_height = height

                # Corrected: Iterate through values of 'regions'
                for region in img_data['regions'].values():
                    shape_info = region['shape_attributes']
                    bbox = []
                    bbox.append(shape_info['x'])
                    bbox.append(shape_info['y'])
                    bbox.append(shape_info['width'])
                    bbox.append(shape_info['height'])

                    x, y, w, h = np.array(bbox, dtype=np.float32)
                    box = np.array([x, y, x + w, y + h])

                    # Corrected: Handle 'region_attributes' structure
                    txt = region['region_attributes']['text']

                    boxes.append(box)
                    text.append(txt)

                if len(boxes) == 0:
                    continue

                boxes = np.asarray(boxes)

                # Normalize box coordinates
                boxes[:, 0::2] /= img_width
                boxes[:, 1::2] /= img_height

                # Append classes
                boxes = np.concatenate([boxes, np.ones([boxes.shape[0], 1])], axis=1)

                self.image_names.append(image_name)
                self.data.append(boxes)
                self.text.append(text)
                cnt = cnt + 1
                print(cnt)
        self.init()

if __name__ == '__main__':
    gt_util = GTUtility('ocr_images/', validation=False, only_with_label=True)
    print(gt_util.data)
