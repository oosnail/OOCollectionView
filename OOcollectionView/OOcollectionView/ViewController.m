//
//  ViewController.m
//  OOcollectionView
//
//  Created by ztc on 16/8/8.
//  Copyright © 2016年 ZTC. All rights reserved.
//


#import "ViewController.h"
#import "OOGiftScrollerView.h"
@interface ViewController ()<OOGiftScrollerViewDelegate>
@property (nonatomic, strong) OOCollectionView *mCollectionView;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) NSInteger previousSelectedIndex;
@property (nonatomic, strong) UIScrollView * giftScrollView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self UIInit];
}

- (void)UIInit{
    OOGiftScrollerView *giftview = [[OOGiftScrollerView alloc]initWithFrame:CGRectMake(0, 200, kScreenWidth, 165)];
    giftview.giftScrollerViewdelegate = self;
    [self.view addSubview:giftview];
//    [giftview reload];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - OOGiftScrollerViewDelegate
- (NSArray* ) titlesInGiftView:(OOGiftScrollerView *)giftview{
    return @[@"测试1",@"测试2",@"测试3"];
}


- (NSInteger)giftView:(OOGiftScrollerView *)giftview numberOfRowsInSection:(NSInteger)section{
    return 10;
}


@end
