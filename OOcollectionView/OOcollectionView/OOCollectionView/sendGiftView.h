//
//  sendGiftView.h
//  OOcollectionView
//
//  Created by ztc on 16/8/11.
//  Copyright © 2016年 ZTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sendGiftView : UIView
@property (nonatomic,strong)UIImageView* giftImageView;
@property (nonatomic,strong)UILabel* giftPriceLabel;
- (void)setModel:(NSIndexPath*)path;

@end
