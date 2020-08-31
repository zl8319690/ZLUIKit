//
//  KDDCollectionViewFlowLayout.m
//  QTTUIKit
//
//  Created by XIN on 2019/11/7.
//  Copyright © 2019 Qutoutiao. All rights reserved.
//

#import "KDDCollectionViewFlowLayout.h"

@interface KDDCollectionViewFlowLayout ()

@property (nonatomic, strong) NSMutableDictionary<NSIndexPath *, UICollectionViewLayoutAttributes *> *cacheAttrs;

@end

@implementation KDDCollectionViewFlowLayout

- (instancetype)init {
  return [self initWithAlignedType:KDDCollectionViewAlignedLayoutTypeLeft];
}

- (instancetype)initWithAlignedType:(KDDCollectionViewAlignedLayoutType)type {
  self = [super init];
  if (self) {
    _alignedType = type;
  }
  return self;
}

- (void)prepareLayout {
  self.cacheAttrs = [NSMutableDictionary dictionary];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
  NSArray<UICollectionViewLayoutAttributes *> *originalAttributes = [super layoutAttributesForElementsInRect:rect];
  NSMutableArray<UICollectionViewLayoutAttributes *> *updatedAttributes = [NSMutableArray arrayWithArray:originalAttributes];
  for (UICollectionViewLayoutAttributes *attributes in originalAttributes) {
    if (!attributes.representedElementKind) {
      NSUInteger index = [updatedAttributes indexOfObject:attributes];
      UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForItemAtIndexPath:attributes.indexPath];
      if (!layoutAttributes) {
        layoutAttributes = [super layoutAttributesForItemAtIndexPath:attributes.indexPath];
      }
      updatedAttributes[index] = layoutAttributes;
    }
  }
  return updatedAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
  if (self.cacheAttrs[indexPath]) {
    return self.cacheAttrs[indexPath];
  }
  NSMutableArray<UICollectionViewLayoutAttributes *> *rowBuddies = [NSMutableArray array];
  UIEdgeInsets inset = [self evaluatedSectionInsetForItemAtIndex:indexPath.section];
  CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.bounds) - inset.left - inset.right;
  
  CGRect rowTestFrame = [super layoutAttributesForItemAtIndexPath:indexPath].frame;
  rowTestFrame.origin.x = 0;
  rowTestFrame.size.width = collectionViewWidth;
  
  NSInteger totalRows = [self.collectionView numberOfItemsInSection:indexPath.section];
  
  NSInteger rowStartIDX = indexPath.item;
  while (true) {
    NSInteger prevIDX = rowStartIDX - 1;
    if (prevIDX < 0) {
      break;
    }
    NSIndexPath *prevPath = [NSIndexPath indexPathForItem:prevIDX inSection:indexPath.section];
    CGRect prevFrame = [super layoutAttributesForItemAtIndexPath:prevPath].frame;
    if (CGRectIntersectsRect(prevFrame, rowTestFrame)) {
      rowStartIDX = prevIDX;
    } else {
      break;
    }
  }
  
  NSInteger buddyIDX = rowStartIDX;
  while (true) {
    if (buddyIDX > (totalRows - 1)) {
      break;
    }
    NSIndexPath *buddyPath = [NSIndexPath indexPathForItem:buddyIDX inSection:indexPath.section];
    UICollectionViewLayoutAttributes *buddyAttributes = [super layoutAttributesForItemAtIndexPath:buddyPath];
    if (CGRectIntersectsRect(buddyAttributes.frame, rowTestFrame)) {
      [rowBuddies addObject:[buddyAttributes copy]];
      buddyIDX++;
    } else {
      break;
    }
  }
  
  CGFloat interitemSpacing = [self evaluatedMinimumInteritemSpacingForSectionAtIndex:indexPath.section];
  CGFloat aggregateInteritemSpacing = interitemSpacing * (rowBuddies.count -1);
  CGFloat aggregateItemWidths = 0.f;
  
  for (UICollectionViewLayoutAttributes *itemAttributes in rowBuddies) {
    aggregateItemWidths += CGRectGetWidth(itemAttributes.frame);
  }
  
  CGFloat alignmentWidth = aggregateItemWidths + aggregateInteritemSpacing;
  
  /// left aligned
  CGFloat alighmentXOffset_left = inset.left;
  /// center aligned
  CGFloat alighmentXOffset_center = (collectionViewWidth - alignmentWidth) / 2.f;
  /// right aligned
  CGFloat alighmentXOffset_right = collectionViewWidth - alignmentWidth + inset.left;
  
  CGRect previousFrame = CGRectZero;
  for (UICollectionViewLayoutAttributes *itemAttributes in rowBuddies) {
    CGRect itemFrame = itemAttributes.frame;
    if (CGRectEqualToRect(CGRectZero, previousFrame)) {
      if (self.alignedType == KDDCollectionViewAlignedLayoutTypeLeft) {
        itemFrame.origin.x = alighmentXOffset_left;
      } else if (self.alignedType == KDDCollectionViewAlignedLayoutTypeCenter) {
        itemFrame.origin.x = alighmentXOffset_center;
      } else {
        itemFrame.origin.x = alighmentXOffset_right;
      }
    } else {
      itemFrame.origin.x = CGRectGetMaxX(previousFrame) + interitemSpacing;
    }
    
    itemAttributes.frame = itemFrame;
    previousFrame = itemFrame;
    
    self.cacheAttrs[itemAttributes.indexPath] = itemAttributes;
  }

  return self.cacheAttrs[indexPath];
}

#pragma mark - Accessors

- (void)setAlignedType:(KDDCollectionViewAlignedLayoutType)alignedType {
  if (_alignedType == alignedType) {
    return;
  }
  _alignedType = alignedType;
  [self invalidateLayout];
}

#pragma mark - Evalate

- (CGFloat)evaluatedMinimumInteritemSpacingForSectionAtIndex:(NSInteger)sectionIndex {
  if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
    id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    
    return [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:sectionIndex];
  } else {
    return self.minimumInteritemSpacing;
  }
}

- (UIEdgeInsets)evaluatedSectionInsetForItemAtIndex:(NSInteger)index {
  if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
    id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    
    return [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:index];
  } else {
    return self.sectionInset;
  }
}

@end
