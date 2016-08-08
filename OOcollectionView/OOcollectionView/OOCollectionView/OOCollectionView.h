//
//  OOCollectionView.h
//  OOcollectionView
//
//  Created by ztc on 16/8/8.
//  Copyright © 2016年 ZTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OOCollectionViewCell.h"
#import "DaiExpandCollectionViewFlowLayout.h"
#import "OOExpandCollectionViewFlowLayout.h"
@interface OOCollectionView : UICollectionView

- (void)expandAtIndex:(NSInteger)index animated:(BOOL)animated;

@end
