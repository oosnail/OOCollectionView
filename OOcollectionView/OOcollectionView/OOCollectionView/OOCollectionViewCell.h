//
//  OOCollectionViewCell.h
//  OOcollectionView
//
//  Created by ztc on 16/8/8.
//  Copyright © 2016年 ZTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLEmojiLabel.h"
@interface OOCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong) UIImageView *giftImage;
@property(nonatomic,strong) UILabel *giftTitle;
@property(nonatomic,strong) MLEmojiLabel *priceLabel;
- (void)setmodel:(NSIndexPath*)path;
@end
