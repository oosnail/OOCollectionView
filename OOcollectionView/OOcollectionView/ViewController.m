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
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,OOExpandCollectionViewFlowLayoutDelegate>
@property (nonatomic, strong) OOCollectionView *mCollectionView;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) NSInteger previousSelectedIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self UIInit];
}

- (void)UIInit{
    
    OOExpandCollectionViewFlowLayout *layOut = [[OOExpandCollectionViewFlowLayout alloc]init];
    layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.mCollectionView = [[OOCollectionView alloc]initWithFrame:CGRectMake(0, 200, kScreenWidth, 100) collectionViewLayout:layOut];
    self.mCollectionView.backgroundColor = [UIColor blackColor];

    [_mCollectionView registerClass:[OOCollectionViewCell class] forCellWithReuseIdentifier: NSStringFromClass([OOCollectionViewCell class])];
    [self.view addSubview:_mCollectionView];
    self.mCollectionView.delegate = self;
    self.mCollectionView.dataSource = self;
    layOut.delegate = self;
    self.mCollectionView.showsVerticalScrollIndicator = NO;
    self.mCollectionView.showsHorizontalScrollIndicator = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.previousSelectedIndex = self.selectedIndex;
    self.selectedIndex = indexPath.row;
    OOCollectionView *_collectView = (OOCollectionView*)collectionView;
    
    [_collectView reloadItemsAtIndexPaths:@[indexPath]];
    
//    [_collectView expandAtIndex:indexPath.row animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == self.selectedIndex){
        return CGSizeMake(kScaleFrom_iPhone5_Desgin(100), kScaleFrom_iPhone5_Desgin(120));
    }
    return CGSizeMake(kScaleFrom_iPhone5_Desgin(84), kScaleFrom_iPhone5_Desgin(60));
}



- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0f;
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

@end
