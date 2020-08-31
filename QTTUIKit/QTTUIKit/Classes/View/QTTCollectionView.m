//
//  QTTCollectionView.m
//  Tiny
//
//  Created by XIN on 2019/7/31.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "QTTCollectionView.h"

@implementation QTTCollectionView

@end

@implementation UICollectionView (QTTReuse)

- (void)qtt_registerCellClass:(Class)cellClass {
  [self registerClass:cellClass forCellWithReuseIdentifier:[cellClass qtt_reuseIdentifier]];
}

- (void)qtt_registerClass:(Class)viewClass
   forSupplementaryOfKind:(NSString *)elementKind {
  [self registerClass:viewClass forSupplementaryViewOfKind:elementKind
  withReuseIdentifier:[viewClass qtt_reuseIdentifier]];
}

- (__kindof UICollectionViewCell *)qtt_dequeueCellWithClass:(Class)cellClass
                                               forIndexPath:(NSIndexPath *)indexPath {
  return [self dequeueReusableCellWithReuseIdentifier:[cellClass qtt_reuseIdentifier]
                                         forIndexPath:indexPath];
}

- (__kindof UICollectionReusableView *)qtt_dequeueSupplementaryOfKind:(NSString *)kind
                                                            withClass:(Class)viewClass
                                                         forIndexPath:(NSIndexPath *)indexPath {
  return [self dequeueReusableSupplementaryViewOfKind:kind
                                  withReuseIdentifier:[viewClass qtt_reuseIdentifier]
                                         forIndexPath:indexPath];
}

@end

@implementation UICollectionReusableView (QTTReuse)

+ (NSString *)qtt_reuseIdentifier {
  return NSStringFromClass(self);
}

@end
