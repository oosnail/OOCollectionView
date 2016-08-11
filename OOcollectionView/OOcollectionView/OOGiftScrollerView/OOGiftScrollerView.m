//
//  OOGiftScrollerView.m
//  OOcollectionView
//
//  Created by ztc on 16/8/11.
//  Copyright © 2016年 ZTC. All rights reserved.
//


#import "OOGiftScrollerView.h"
#import "HMSegmentedControl.h"
#import "sendGiftView.h"
@interface OOGiftScrollerView ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    BOOL shakeAnimal;
}
@property (nonatomic, strong) OOCollectionView *mCollectionView;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) NSInteger previousSelectedIndex;
@property (nonatomic, strong) UIScrollView * giftScrollView;
@property (nonatomic, strong) HMSegmentedControl* pageControl;
@property (nonatomic, strong) sendGiftView* sendgiftview;
@end

@implementation OOGiftScrollerView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
//        [self UIInit];
    }
    return self;
}

- (void)UIInit{
    
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    _giftScrollView = [[UIScrollView alloc]init];
    _giftScrollView.frame = CGRectMake(0, 0, kScreenWidth, 111);
//    _giftScrollView.delegate = self;
    _giftScrollView.pagingEnabled = YES;
    _giftScrollView.scrollEnabled = NO;
    _giftScrollView.clipsToBounds = NO;
    
    [self addSubview:_giftScrollView];
    
    for (int i = 0; i<3; i++) {
        OOCollectionView *_collectionView = [[OOCollectionView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, _giftScrollView.bounds.size.height)
                                                              collectionViewLayout:layOut];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[OOCollectionViewCell class] forCellWithReuseIdentifier: NSStringFromClass([OOCollectionViewCell class])];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //    layOut.delegate = self;
        _collectionView.clipsToBounds = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_giftScrollView addSubview:_collectionView];
    }
    
    
    //segment
    self.pageControl = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, _giftScrollView.frame.origin.y + _giftScrollView.frame.size.height, kScreenWidth, 50)];
    [self.pageControl addTarget:self
                         action:@selector(pageControlValueChanged:)
               forControlEvents:UIControlEventValueChanged];
    self.pageControl.backgroundColor = [UIColor whiteColor];
    self.pageControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
    self.pageControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:16]};
    self.pageControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:16]};
    self.pageControl.selectionIndicatorColor = [UIColor redColor];
    [self.pageControl setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    self.pageControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.pageControl.sectionTitles = [self.giftScrollerViewdelegate titlesInGiftView:self];

//    int a = [self.giftScrollerViewdelegate giftView:self numberOfRowsInSection:0];
    
    [self addSubview:self.pageControl];
    
    //初始化
    self.sendgiftview = [[sendGiftView alloc]initWithFrame:CGRectMake(0, 0, 100, 105)];
}

- (void)reload{
}

- (void)layoutSubviews{
    [self UIInit];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"OOCollectionViewCell";
    OOCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell setmodel:indexPath];
    //是否颤抖
    if(shakeAnimal){
        [self shakeView:cell.giftImage];
    }
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
    //获取view
    
    
    
    self.previousSelectedIndex = self.selectedIndex;
    self.selectedIndex = indexPath.row;
    OOCollectionView *_collectView = (OOCollectionView*)collectionView;
    shakeAnimal = YES;
    [_collectView reloadData];
    
    //show sendgiftView
    {
        UICollectionViewCell *cell = [self collectionView:collectionView cellForItemAtIndexPath:indexPath];
        CGRect rect = cell.frame;
        //此处加动画效果
        [self.sendgiftview removeFromSuperview];
        //修改
        self.sendgiftview.center = CGPointMake(rect.origin.x+rect.size.width/2.f, 40);
        [self.sendgiftview setModel:indexPath];
        self.sendgiftview.transform =CGAffineTransformMakeScale( 0, 0);
        
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.sendgiftview.transform =CGAffineTransformMakeScale( 1, 1);
                         }
                         completion:^(BOOL finished) {
                             shakeAnimal = NO;
                         }];
        
        [collectionView addSubview:self.sendgiftview];
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == self.selectedIndex){
        //        return CGSizeMake(kScaleFrom_iPhone5_Desgin(100), kScaleFrom_iPhone5_Desgin(120));
    }
    //    return CGSizeMake(kScaleFrom_iPhone5_Desgin(84), kScaleFrom_iPhone5_Desgin(60));
    return CGSizeMake(45+30,81);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 15, 15);//分别为上、左、下、右
}


- (void)pageControlValueChanged:(id)sender {
    [_giftScrollView setContentOffset:CGPointMake(kScreenWidth*_pageControl.selectedSegmentIndex, 0) animated:YES];
}

//颤抖
-(void)shakeView:(UIView*)viewToShake
{
    CGFloat t =2.0;
    CGAffineTransform translateRight  =CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    CGAffineTransform translateLeft =CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
    
    viewToShake.transform = translateLeft;
    
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        viewToShake.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                viewToShake.transform =CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
    
}


@end