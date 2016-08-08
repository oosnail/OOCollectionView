//
//  OOExpandCollectionViewFlowLayout.m
//  OOcollectionView
//
//  Created by ztc on 16/8/8.
//  Copyright © 2016年 ZTC. All rights reserved.
//

#import "OOExpandCollectionViewFlowLayout.h"

@interface OOExpandCollectionViewFlowLayout ()
@property (nonatomic, assign) int itemsInRow;
@property (nonatomic, assign) CGSize originalSize;
@property (nonatomic, assign) CGSize expandSize;
@property (nonatomic, assign) CGFloat squareWithGap;
@property (nonatomic, assign) CGFloat maxWidth;
@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, assign) CGRect frame;
@end

@implementation OOExpandCollectionViewFlowLayout


- (void)prepareLayout {
    [super prepareLayout];

}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 系统父类写的方法， 系统子类必须调用父类，进行执行(只是对部分属性进行修改,所以不必一个个进行设置布局属性)

    NSArray *layoutAtts =  [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes *layoutAtt in layoutAtts) {
        NSIndexPath *indexpath = [self.delegate selectedIndexPath];
        if(layoutAtt.indexPath.row == indexpath.row){
//            layoutAtt.transform = CGAffineTransformMakeScale(2, 2);
//            layoutAtt.size = CGSizeMake(layoutAtt.size.width*2, layoutAtt.size.width*2);
            layoutAtt.center = CGPointMake(layoutAtt.center.x, layoutAtt.center.y-30);
        }
//        CGFloat centerX = layoutAtt.center.x;
//        // 形变值，根据当前cell 距离中心位置，的远近  进行反比例缩放。 （不要忘记算其偏移量的值。）
//        CGFloat scale = 1 - ABS((centerX - collectionViewCenterX - contentOffsetX)/self.collectionView.bounds.size.width);
        // 给 布局属性  添加形变
//        layoutAtt.transform = CGAffineTransformMakeScale(scale, scale);


    }

    return layoutAtts;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

// 通过目标移动的偏移量， 提取期望偏移量  （一般情况下，期望偏移量，就是 目标偏移量）
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 根据偏移量 ， 确定区域
    CGRect rect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    // 将屏幕所显示区域的 元素布局 取出。
    NSArray *layoutAtts = [super layoutAttributesForElementsInRect:rect];
    CGFloat minMargin = MAXFLOAT;
    CGFloat collectionViewCenterX = self.collectionView.frame.size.width * 0.5;
    CGFloat contentOffsetX = proposedContentOffset.x;
    // 取出区域内元素， 并根据其中心位置， 与视图中心位置 进行比较， 比出最小的距离差
    for (UICollectionViewLayoutAttributes *layoutAtt in layoutAtts) {
        CGFloat margin = layoutAtt.center.x - contentOffsetX - collectionViewCenterX;
        if (ABS(margin) < ABS(minMargin)) {
            minMargin = margin;
        }
    }
    NSLog(@"%f",minMargin);
    // 期望偏移量 加上差值， 让整体，沿差值 反方向移动，这样的话， 最近的一个，刚好在中心位置
    proposedContentOffset.x += minMargin;
    return proposedContentOffset;
}



@end
