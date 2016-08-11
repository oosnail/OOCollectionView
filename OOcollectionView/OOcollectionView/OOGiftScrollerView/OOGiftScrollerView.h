//
//  OOGiftScrollerView.h
//  OOcollectionView
//
//  Created by ztc on 16/8/11.
//  Copyright © 2016年 ZTC. All rights reserved.
//

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScaleFrom_iPhone5_Desgin(_X_) (_X_ * (kScreenWidth/320))


#import <UIKit/UIKit.h>
#import "OOCollectionView.h"
@class OOGiftScrollerView;

@protocol OOGiftScrollerViewDelegate<NSObject, UIScrollViewDelegate>

@required
- (NSArray* ) titlesInGiftView:(OOGiftScrollerView *)giftview;   //一共多少选择
- (NSInteger)giftView:(OOGiftScrollerView *)giftview numberOfRowsInSection:(NSInteger)section;
@optional

- (void)giftViewSend:(OOGiftScrollerView *)giftview NSIndexPath:(NSIndexPath *)indexPath;;

@end

@interface OOGiftScrollerView : UIView
- (void)reload;
@property (nonatomic, weak) id <OOGiftScrollerViewDelegate> giftScrollerViewdelegate;


@end
