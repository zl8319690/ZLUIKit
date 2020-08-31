//
//  KDDCollectionViewFlowLayout.h
//  QTTUIKit
//
//  Created by XIN on 2019/11/7.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, KDDCollectionViewAlignedLayoutType) {
  KDDCollectionViewAlignedLayoutTypeLeft,
  KDDCollectionViewAlignedLayoutTypeCenter,
  KDDCollectionViewAlignedLayoutTypeRight,
};

@interface KDDCollectionViewFlowLayout : UICollectionViewFlowLayout

- (instancetype)initWithAlignedType:(KDDCollectionViewAlignedLayoutType)type;

@property (nonatomic, assign) KDDCollectionViewAlignedLayoutType alignedType;

@end

NS_ASSUME_NONNULL_END
