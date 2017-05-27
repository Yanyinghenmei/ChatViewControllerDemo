//
//  PhotoCenter.m
//  Lizard
//
//  Created by Daniel on 16/3/25.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "PhotoCenter.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImage+ZY.h"
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)

typedef void(^FormDataBlock)(UIImage *image, IWFormData *formData);

@implementation PhotoCenter {
    FormDataBlock formDataBlock;
}

- (instancetype)init {
    if (self = [super init]) {
        _compressWidth = 500;
    }
    return self;
}

- (void)libraryPhotoWithController:(UIViewController *)controller
                     FormDataBlock:(void (^)(UIImage *, IWFormData *))block {
    formDataBlock = block;
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    
    ALAuthorizationStatus author =[ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied)
    {
        //无权限
        NSLog(@"呜呜呜呜");
    }
    
    self.ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [controller presentViewController:self.ipc animated:YES completion:^{
        self.ipc.delegate = self;
    }];
}

- (void)cameraPhotoWithController:(UIViewController *)controller
                    FormDataBlock:(void (^)(UIImage *, IWFormData *))block {
    
    formDataBlock = block;
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        
        self.ipc.sourceType = sourceType;
        
        [controller presentViewController:self.ipc animated:YES completion:^{
            self.ipc.delegate = self;
        }];
        
    } else {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image;
        if (self.ipc.allowsEditing) {
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        //设置image的尺寸
        CGSize imageSize = CGSizeMake(_compressWidth, image.size.height * _compressWidth/image.size.width);
        
        //对图片大小进行压缩--
        image = [self imageWithImage:image scaledToSize:imageSize];
        
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil) {
            data = UIImageJPEGRepresentation(image, 1);
        } else {
            data = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        
        //图片命名用时间戳表示
        NSString * imageNameStr = [self imageNameWithDate];
        
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:[NSString stringWithFormat:@"/%@",imageNameStr]] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        NSString *filePath = [[NSString alloc]initWithFormat:@"%@/%@",DocumentsPath,imageNameStr];
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        UIImage *shareImage = [[UIImage alloc] initWithContentsOfFile:filePath];
        
        //图片压缩
        NSData * imageData = UIImageJPEGRepresentation(shareImage, 0.1);
        //模型存储
        
        IWFormData *formData = [[IWFormData alloc] init];
        formData.data = imageData;
        formData.name = @"simg";
        formData.filename = imageNameStr;
        formData.mimeType = @"image/jpeg";
        
        // 返回图片
        formDataBlock(image, formData);
    }
}

//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    WELog(@"取消选取照片");
//}

- (UIImagePickerController *)ipc {
    if (!_ipc) {
        _ipc = [[UIImagePickerController alloc] init];
        [_ipc.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    }
    return _ipc;
}

- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (NSString *)imageNameWithDate {
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval aDate=[date timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",aDate];
    NSString * imageNameStr = [NSString stringWithFormat:@"%@.jpg",timeString];
    return imageNameStr;
}

@end
