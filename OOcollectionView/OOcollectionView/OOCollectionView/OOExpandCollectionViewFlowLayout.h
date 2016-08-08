//
//  OOExpandCollectionViewFlowLayout.h
//  OOcollectionView
//
//  Created by ztc on 16/8/8.
//  Copyright © 2016年 ZTC. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  OOExpandCollectionViewFlowLayoutDelegate;

@interface OOExpandCollectionViewFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, weak) id <OOExpandCollectionViewFlowLayoutDelegate> delegate;




@end

@protocol OOExpandCollectionViewFlowLayoutDelegate <NSObject>

@required
- (NSIndexPath *)selectedIndexPath;
- (NSIndexPath *)previousSelectedIndexPath;

@end
