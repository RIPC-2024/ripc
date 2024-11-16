from GTUtility_making import GTUtility
import pickle

gt_util = GTUtility('ocr_images/', validation = False)
file_name = 'ocr_images.pkl'
pickle.dump(gt_util, open(file_name, 'wb')) # 'wb': write binary

print(gt_util)
print(gt_util.text[:100]) # text리스트의 상위 5개
