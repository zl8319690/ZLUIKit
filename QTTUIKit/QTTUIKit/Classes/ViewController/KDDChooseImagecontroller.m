//
//  KDDChooseImagecontroller.m
//  QTTUIKit
//
//  Created by XIN on 2019/9/7.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "KDDChooseImagecontroller.h"
#import "UIViewController+QTTExt.h"
#import <QTTFoundation/QTTFoundation.h>
#import <AVKit/AVKit.h>
#import <Photos/Photos.h>

@implementation KDDChooseImagecontroller

- (id)initWithDelegate:(id)delegate {
  if (self = [super init]) {
    self.delegate = delegate;
  }
  return self;
}

- (void)chooseImage {
  weakify(self);
  UIAlertController *controlller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
  UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    strongify(self);
    [self showImagePickerWithTypes:UIImagePickerControllerSourceTypeCamera];
  }];
  UIAlertAction *photoLibrary = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    strongify(self);
    [self showImagePickerWithTypes:UIImagePickerControllerSourceTypePhotoLibrary];
  }];
  UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
  [controlller addAction:camera];
  [controlller addAction:photoLibrary];
  [controlller addAction:cancel];
  if ([controlller respondsToSelector:@selector(popoverPresentationController)]) {
    controlller.popoverPresentationController.sourceView = self.currentTopViewController.view;
    controlller.popoverPresentationController.sourceRect = CGRectMake(0, DEVICE_FULL_SIZE_HEIGHT, DEVICE_FULL_SIZE_WIDTH, DEVICE_FULL_SIZE_HEIGHT);
  }
  [self showViewController:controlller animated:YES completion:nil];
}

- (void)presentPicker {
  [self showViewController:self.mediaPicker animated:YES completion:NULL];
}

#pragma mark - topViewController

- (UIViewController *)currentTopViewController {
  UIViewController *controller = nil;
  if ([_delegate isKindOfClass:[UIViewController class]]) {
    controller = (UIViewController *)_delegate;
  } else {
    controller = [UIViewController qtt_visiableViewController];
  }
  return controller;
}

#pragma mark - for uiactionsheet

- (void)showImagePickerWithTypes:(UIImagePickerControllerSourceType)type {
  if (type == UIImagePickerControllerSourceTypeCamera) {
    [self pickImageFromCamera];
  } else if (type == UIImagePickerControllerSourceTypePhotoLibrary) {
    [self pickImageFromPhotoLibrary];
  }
}

- (void)showImagePickControllerWithType:(UIImagePickerControllerSourceType)type {
  _mediaPicker = [[UIImagePickerController alloc] init];
  [_mediaPicker setDelegate:self];
  _mediaPicker.allowsEditing = YES;
  _mediaPicker.sourceType = type;
  [self presentPicker];
}

- (void)pickImageFromPhotoLibrary {
  PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
  if (status != PHAuthorizationStatusAuthorized) {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
      dispatch_async(dispatch_get_main_queue(), ^{
        if (status != PHAuthorizationStatusAuthorized) {
          UIAlertController *alert =
          [UIAlertController alertControllerWithTitle:nil
                                              message:@"请"@"前"@"往"@"隐私设置中，打开相册"@"权限"
                                       preferredStyle:UIAlertControllerStyleAlert];
          UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil];
          UIAlertAction *action1 = [UIAlertAction
                                    actionWithTitle:@"设置"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *_Nonnull action) {
                                      [[UIApplication sharedApplication]
                                       openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                    }];
          [alert addAction:action0];
          [alert addAction:action1];
          [self showViewController:alert animated:YES completion:nil];
        } else {
          [self showImagePickControllerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
      });
    }];
  } else {
    [self showImagePickControllerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
  }
}

- (void)pickImageFromCamera {
  AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
  if (status != AVAuthorizationStatusAuthorized) {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
      dispatch_async(dispatch_get_main_queue(), ^{
        if (!granted) {
          UIAlertController *alert =
          [UIAlertController alertControllerWithTitle:nil
                                              message:@"请"@"前"@"往"@"隐私设置中，打开相机"@"权限"
                                       preferredStyle:UIAlertControllerStyleAlert];
          UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil];
          UIAlertAction *action1 = [UIAlertAction
                                    actionWithTitle:@"设置"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *_Nonnull action) {
                                      [[UIApplication sharedApplication]
                                       openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                    }];
          [alert addAction:action0];
          [alert addAction:action1];
          [self showViewController:alert animated:YES completion:nil];
        } else {
          [self showImagePickControllerWithType:UIImagePickerControllerSourceTypeCamera];
        }
      });
    }];
  } else {
    [self showImagePickControllerWithType:UIImagePickerControllerSourceTypeCamera];
  }
}

- (void)showViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
  viewController.modalPresentationStyle = UIModalPresentationFullScreen;
  [self.currentTopViewController presentViewController:viewController animated:animated completion:completion];
}

#pragma mark - Camera View Delegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
  [self dismissPicker:picker];
  UIImage *image = info[UIImagePickerControllerEditedImage];
  BLOCK_EXEC(self.didChooseImageAction, image);
  if ([_delegate respondsToSelector:@selector(chooseImageController:didChooseImage:)]) {
    [_delegate chooseImageController:self didChooseImage:image];
  }
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [self dismissPicker:picker];
  BLOCK_EXEC(self.didChooseImageAction, nil);
  if ([_delegate respondsToSelector:@selector(didCancelChooseImageController:)]) {
    [_delegate didCancelChooseImageController:self];
  }
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)dismissPicker:(UIImagePickerController *)picker {
  [picker dismissViewControllerAnimated:YES completion:nil];
}
@end

