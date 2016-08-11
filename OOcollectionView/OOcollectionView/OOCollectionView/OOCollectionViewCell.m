//
//  OOCollectionViewCell.m
//  OOcollectionView
//
//  Created by ztc on 16/8/8.
//  Copyright © 2016年 ZTC. All rights reserved.
//

#import "OOCollectionViewCell.h"

@interface OOCollectionViewCell ()


@end

@implementation OOCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI {
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat _width = self.frame.size.width;
    CGFloat _height = 0;
    self.giftImage = [[UIImageView alloc]init];
    self.giftImage.bounds = CGRectMake(0, 0, 45, 45);
    self.giftImage.center = CGPointMake(_width/2.f, 45/2.f);
    [self addSubview:self.giftImage];
    _height = _height+self.giftImage.bounds.size.height +5;
    
    self.giftTitle = [[UILabel alloc]init];
    self.giftTitle.frame = CGRectMake(0, _height, _width, 15);
    self.giftTitle.font = [UIFont systemFontOfSize:11];
    self.giftTitle.textColor = [UIColor blackColor];
    self.giftTitle.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.giftTitle];
    _height = _height+self.giftTitle.bounds.size.height;
    
    self.priceLabel = [[MLEmojiLabel alloc]init];
    self.priceLabel.frame = CGRectMake(0, _height, _width, 15);
    self.priceLabel.font = [UIFont systemFontOfSize:11];
    self.priceLabel.textColor = [UIColor blackColor];
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
    self.priceLabel.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    self.priceLabel.customEmojiPlistName = @"expressionImage_custom";
    [self addSubview:self.priceLabel];
    
//    self.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}


- (void)setmodel:(NSIndexPath*)path{
    self.giftImage.image = [UIImage imageNamed:@"testImage"];
    self.giftTitle.text = [NSString stringWithFormat:@"%@%ld",@"礼物",(long)path.row];
    self.priceLabel.text = @"2000 [测试]";

}

@end
