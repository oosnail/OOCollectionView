//
//  ViewController.m
//  OOcollectionView
//
//  Created by ztc on 16/8/8.
//  Copyright © 2016年 ZTC. All rights reserved.
//

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScaleFrom_iPhone5_Desgin(_X_) (_X_ * (kScreenWidth/320))


#import "ViewController.h"
#import "OOCollectionView.h"
#import "OOExpandCollectionViewFlowLayout.h"
#import "HMSegmentedControl.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,OOExpandCollectionViewFlowLayoutDelegate>
@property (nonatomic, strong) OOCollectionView *mCollectionView;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) NSInteger previousSelectedIndex;
@property (nonatomic, strong) UIView* giftView;
@property (nonatomic, strong) UIScrollView * giftScrollView;
@property (nonatomic, strong) HMSegmentedControl* pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self UIInit];
}

- (void)UIInit{
    
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    
    
    _giftScrollView = [[UIScrollView alloc]init];
    _giftScrollView.frame = CGRectMake(0, 200, kScreenWidth, 100);
    _giftScrollView.delegate = self;
    _giftScrollView.pagingEnabled = YES;
    _giftScrollView.scrollEnabled = NO;
    [self.view addSubview:_giftScrollView];
    
    for (int i = 0; i<3; i++) {
        OOCollectionView *_collectionView = [[OOCollectionView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, 100) collectionViewLayout:layOut];
        _collectionView.backgroundColor = [UIColor blackColor];
        [_collectionView registerClass:[OOCollectionViewCell class] forCellWithReuseIdentifier: NSStringFromClass([OOCollectionViewCell class])];
        [self.view addSubview:_mCollectionView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //    layOut.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_giftScrollView addSubview:_collectionView];
    }
    
    
    //segment
    self.pageControl = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, _giftScrollView.frame.origin.y + _giftScrollView.frame.size.height, kScreenWidth, 50)];
    [self.pageControl addTarget:self
                         action:@selector(pageControlValueChanged:)
               forControlEvents:UIControlEventValueChanged];
    
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
    self.pageControl.sectionTitles = @[@"测试",@"测试",@"测试"];
    [self.view addSubview:self.pageControl];

    self.giftView = [[UIView alloc]init];
    self.giftView.frame = CGRectMake(50, 20, 40, 40);
    self.giftView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.giftView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - DaiExpandCollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"OOCollectionViewCell";
    OOCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.image.image = [UIImage imageNamed:@"bg_tk_003"];
    //是否颤抖
    {
        [self shakeView:cell.image];
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
    
//    UICollectionViewCell *cell = [self collectionView:collectionView cellForItemAtIndexPath:indexPath];
//    CGRect rect = cell.frame;
//    self.giftView.frame = rect;
    
    self.previousSelectedIndex = self.selectedIndex;
    self.selectedIndex = indexPath.row;
    OOCollectionView *_collectView = (OOCollectionView*)collectionView;
//    [_collectView reloadItemsAtIndexPaths:@[indexPath]];
    [_collectView reloadData];
    [self shakeView:self.giftView];
//    [_collectView expandAtIndex:indexPath.row animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == self.selectedIndex){
//        return CGSizeMake(kScaleFrom_iPhone5_Desgin(100), kScaleFrom_iPhone5_Desgin(120));
    }
    return CGSizeMake(kScaleFrom_iPhone5_Desgin(84), kScaleFrom_iPhone5_Desgin(60));
}



- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if(self.selectedIndex == 2){
        return 10;
    }
    return 5.0f;
}

//获取scrollview 的偏移量 如果滑到底 或者滑到头 那么移动到下一个
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;{
    
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
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


- (void)pageControlValueChanged:(id)sender {
    [_giftScrollView setContentOffset:CGPointMake(kScreenWidth*_pageControl.selectedSegmentIndex, 0)];
}


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
