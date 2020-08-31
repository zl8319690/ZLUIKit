//
//  QTTCollectionView.h
//  Tiny
//
//  Created by XIN on 2019/7/31.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QTTCollectionView : UICollectionView

@end

@interface UICollectionView (QTTReuse)

- (void)qtt_registerCellClass:(Class)cellClass;

- (void)qtt_registerClass:(Class)viewClass
   forSupplementaryOfKind:(NSString *)elementKind;

- (__kindof UICollectionViewCell *)qtt_dequeueCellWithClass:(Class)cellClass
                                               forIndexPath:(NSIndexPath *)indexPath;

- (__kindof UICollectionReusableView *)qtt_dequeueSupplementaryOfKind:(NSString *)kind
                                                            withClass:(Class)viewClass
                                                         forIndexPath:(NSIndexPath *)indexPath;

@end

@interface UICollectionReusableView (QTTReuse)

+ (NSString *)qtt_reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
