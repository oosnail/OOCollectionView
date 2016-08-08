//
//  OOCollectionView.m
//  OOcollectionView
//
//  Created by ztc on 16/8/8.
//  Copyright © 2016年 ZTC. All rights reserved.
//

#import "OOCollectionView.h"

@interface OOCollectionView()
//动画锁
@property (nonatomic, strong) NSLock *animationLock;
//当前选中的
@property (nonatomic, assign) NSInteger selectedIndex;
//上一个选中的
@property (nonatomic, assign) NSInteger previousSelectedIndex;
//原来的大小
@property (nonatomic, assign) CGSize originalSize;
@property (nonatomic, assign) NSInteger itemsInRow;
@property (nonatomic, strong) OOExpandCollectionViewFlowLayout *expandCollectionViewFlowLayout;

@end

@implementation OOCollectionView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.clipsToBounds = NO;
        _itemsInRow = 3 ;
    }
    return self;
}

- (NSInteger)itemsInRow {
    return _itemsInRow;
}

#pragma mark - DaiExpandCollectionViewFlowLayoutDelegate

- (NSIndexPath *)selectedIndexPath {
    if (self.selectedIndex != -1) {
        return [NSIndexPath indexPathForRow:self.selectedIndex inSection:0];
    }
    else {
        return nil;
    }
}

- (NSIndexPath *)previousSelectedIndexPath {
    if (self.previousSelectedIndex != -1) {
        return [NSIndexPath indexPathForRow:self.previousSelectedIndex inSection:0];
    }
    else {
        return nil;
    }
}


//动画效果
//外部手動用 code 選擇某一個 index, 只有在 index 不同時才需要做
- (void)expandAtIndex:(NSInteger)index animated:(BOOL)animated {
    
    
    
    
}

- (void)updateCollectionView:(UICollectionView *)collectionView atSelectedIndexPath:(NSIndexPath *)selectedIndexPath animated:(BOOL)animated {
    {
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:selectedIndexPath];
        [collectionView bringSubviewToFront:cell];
        if (animated) {
            __weak OOCollectionView *weakSelf = self;
            [UIView animateWithDuration:0.4f delay:0 usingSpringWithDamping:0.6f initialSpringVelocity:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [collectionView performBatchUpdates: ^{
                    weakSelf.previousSelectedIndex = weakSelf.selectedIndex;
                    weakSelf.selectedIndex = selectedIndexPath.row;
                } completion: ^(BOOL finished) {
                    if (weakSelf.previousSelectedIndex != -1) {
                        [weakSelf restoreItemInCollectionView:collectionView atIndexPath:[NSIndexPath indexPathForRow:weakSelf.previousSelectedIndex inSection:0]];
                    }
                    [weakSelf.animationLock unlock];
                }];
            } completion:nil];
        }
        else {
            self.previousSelectedIndex = self.selectedIndex;
            self.selectedIndex = selectedIndexPath.row;
            [self reloadData];
            if (self.previousSelectedIndex != -1) {
                [self restoreItemInCollectionView:collectionView atIndexPath:[NSIndexPath indexPathForRow:self.previousSelectedIndex inSection:0]];
            }
            [self.animationLock unlock];
        }
    }
}

//还原
- (void)restoreItemInCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.transform = CGAffineTransformIdentity;
//    CGRect newFrame = cell.frame;
//    newFrame.size = self.daiExpandCollectionViewFlowLayout.originalSize;
//    cell.frame = newFrame;
}

#pragma mark - DaiExpandCollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"OOCollectionViewCell";
    OOCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

- (NSInteger)numberOfItemsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected : %td", indexPath.row);
    
    OOCollectionView *_collectView = (OOCollectionView*)collectionView;
    
    [_collectView reloadItemsAtIndexPaths:@[indexPath]];
    
    //    [_collectView expandAtIndex:indexPath.row animated:YES];
}

@end
