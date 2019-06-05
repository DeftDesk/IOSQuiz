//
//  HomeCell.h
//  QuizApps
//
//  Created by DeftDesk on 05/06/19.
//  Copyright © 2019 DeftDesk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeCell : UICollectionViewCell
-(void)collapse;
-(void)show;
-(void)hide:(CGRect)collectionCell and:(CGRect)frameOfSelectedCell and:(float)contentOffset;
-(void)expand:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
