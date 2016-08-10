//
//  OOCollectionViewCell.m
//  OOcollectionView
//
//  Created by ztc on 16/8/8.
//  Copyright © 2016年 ZTC. All rights reserved.
//

#import "OOCollectionViewCell.h"

@implementation OOCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI {
    self.image = [[UIImageView alloc]init];
    self.image.bounds = CGRectMake(0, 0, 50, 50);
    self.image.center = CGPointMake(50, 50);
    [self addSubview:self.image];
    
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}

@end
