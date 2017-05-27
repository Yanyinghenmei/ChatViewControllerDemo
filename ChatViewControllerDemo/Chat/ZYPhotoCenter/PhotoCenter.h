//
//  PhotoCenter.h
//  Lizard
//
//  Created by Daniel on 16/3/25.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWFormData.h"

@interface PhotoCenter : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic, strong)UIImagePickerController *ipc;
@property (nonatomic, assign)CGFloat compressWidth;     //default 500;

- (void)libraryPhotoWithController:(UIViewController *)controller
                     FormDataBlock:(void(^)(UIImage *image, IWFormData *formData))block;

- (void)cameraPhotoWithController:(UIViewController *)controller
                    FormDataBlock:(void(^)(UIImage *image, IWFormData *formData))block;

- (NSString *)imageNameWithDate;

@end
