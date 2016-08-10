//
//  sendGiftView.m
//  OOcollectionView
//
//  Created by ztc on 16/8/11.
//  Copyright © 2016年 ZTC. All rights reserved.
//

#import "sendGiftView.h"

@implementation sendGiftView
//@property (nonatomic,strong)UIImageView* giftImageView;
//@property (nonatomic,strong)UILabel* giftPriceLabel;
//- (void)setModel:(NSIndexPath*)path;


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self UIInit];
    }
    return self;
}

- (void)UIInit{
    CGFloat _width = self.bounds.size.width;
    CGFloat _height = self.bounds.size.height;
    
    self.backgroundColor = [UIColor redColor];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 15;
    self.clipsToBounds = NO;
    
    //image
    self.giftImageView = [[UIImageView alloc]init];
    self.giftImageView.bounds = CGRectMake(0, 0, 60, 60);
    self.giftImageView.center = CGPointMake(_width/2.f, _height/6);
    [self addSubview:self.giftImageView];
    
    CGFloat _y = self.giftImageView.frame.origin.y + self.giftImageView.frame.size.width+2;
    
     self.giftPriceLabel = [[UILabel alloc]init];
    self.giftPriceLabel.bounds = CGRectMake(0, 0, _width, 15);
    self.giftPriceLabel.center = CGPointMake(_width/2.f, _y+15/2.f);
    self.giftPriceLabel.font = [UIFont systemFontOfSize:14];
    self.giftPriceLabel.textColor = [UIColor whiteColor];
    self.giftPriceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.giftPriceLabel];
    
    UILabel *sendLable = [[UILabel alloc]init];
    sendLable.bounds = CGRectMake(0, 0, _width, _height/3.f);
    sendLable.center = CGPointMake(_width/2.f, 5*_height/6.f);
    sendLable.font = [UIFont systemFontOfSize:14];
    sendLable.textColor = [UIColor whiteColor];
    sendLable.textAlignment = NSTextAlignmentCenter;
    sendLable.backgroundColor = [UIColor blueColor];
    
    //只对下半部分圆角
    {
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:sendLable.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){15.0f, 15.0f}].CGPath;
        sendLable.layer.mask = maskLayer;
    }

    
    [sendLable setText:@"赠送"];
    [self addSubview:sendLable];
}

- (void)setModel:(NSIndexPath*)path{
    self.giftImageView.image = [UIImage imageNamed:@"testImage"];
    [self.giftPriceLabel setText:@"10"];

}

@end
