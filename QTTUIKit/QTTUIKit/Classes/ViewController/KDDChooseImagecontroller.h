//
//  KDDChooseImagecontroller.h
//  QTTUIKit
//
//  Created by XIN on 2019/9/7.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KDDChooseImageDelegate;

@interface KDDChooseImagecontroller : NSObject <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, weak) id<KDDChooseImageDelegate> delegate;
@property (nonatomic, strong) UIImagePickerController *mediaPicker;
@property (nonatomic, weak) UIView *sender;
@property (nonatomic, assign) UIImagePickerControllerSourceType sourceType;

- (id)initWithDelegate:(id<KDDChooseImageDelegate> )delegate;

- (void)chooseImage;

/// direct choose image
- (void)pickImageFromPhotoLibrary;
- (void)pickImageFromCamera;

@property (nonatomic, copy) void(^didChooseImageAction)(UIImage * _Nullable image);

@end

@protocol KDDChooseImageDelegate <NSObject>

- (void)chooseImageController:(KDDChooseImagecontroller *)controller didChooseImage:(UIImage *)image;
- (void)didCancelChooseImageController:(KDDChooseImagecontroller *)controller;

@end

NS_ASSUME_NONNULL_END
