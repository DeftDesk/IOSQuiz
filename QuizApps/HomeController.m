//
//  HomeController.m
//  QuizApps
//
//  Created by DeftDesk on 05/06/19.
//  Copyright © 2019 DeftDesk. All rights reserved.
//

#import "HomeController.h"
#import "HomeCell.h"

@interface HomeController (){
     NSMutableArray * hiddenCells;
     NSMutableArray * expandedCell;
     BOOL *isStatusBarHidden;

}

@end

@implementation HomeController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    hiddenCells = [[NSMutableArray alloc]init];
    expandedCell = [[NSMutableArray alloc]init];

}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
       HomeCell  *cell = (HomeCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.contentOffset.y < 0) {
        return;
    }
    if (collectionView.contentOffset.y > collectionView.contentSize.height - collectionView.frame.size.height){
        return;
        }
    
    CGFloat dampingRatio = 0.8;
    CGVector initialVelocity = CGVectorMake(0,0);
    UISpringTimingParameters *springParameters = [[UISpringTimingParameters alloc] initWithDampingRatio:dampingRatio initialVelocity:initialVelocity];
    
    
    UIViewPropertyAnimator *playerViewAnimator
    
    = [[UIViewPropertyAnimator alloc] initWithDuration:0.8 timingParameters:springParameters];
    
    
    [self.view setUserInteractionEnabled:NO];
    
    
    if (expandedCell.count == 0){
        
         HomeCell *datasetCell =   (HomeCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
            datasetCell.transform = CGAffineTransformMakeScale(0.95, 0.95);

        } completion:^(BOOL finished) {
            datasetCell.transform = CGAffineTransformMakeScale(1, 1);
            
       
           
                self.collectionView.scrollEnabled = false;
                
            [self->expandedCell addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
                
                
                HomeCell *datasetCell =   (HomeCell *)[collectionView cellForItemAtIndexPath:indexPath];
                
            
                
                
                for (UICollectionViewCell *cell in [collectionView visibleCells]) {
                    NSIndexPath *indexPathV = [collectionView indexPathForCell:cell];
                    NSLog(@"%@",indexPathV);
                    
                    if(indexPathV.row == indexPath.row){
                        
                    }
                    else{
                        
                        [self->hiddenCells addObject:[NSString stringWithFormat:@"%ld",(long)indexPathV.row]];
                    }
                    
                }
                
                CGRect frameOfcollection =  CGRectMake(0, collectionView.contentOffset.y, collectionView.frame.size.width, collectionView.frame.size.height);
                
                float  contentOffset = collectionView.contentOffset.y;
                
                
                
                CGRect frameOfcollectionHide = collectionView.frame;
                
                [playerViewAnimator addAnimations:^{
                    
                    
                    
                    [datasetCell expand:frameOfcollection];
                    
                    
                    if (self->hiddenCells.count > 0){
                        
                        for (int i = 0; i < self->hiddenCells.count; i ++) {
                            
                            NSString * strIndex = [NSString stringWithFormat:@"%@",self->hiddenCells[i]];
                            
                            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[strIndex integerValue] inSection:0];
                            
                            HomeCell *datasetCell =   (HomeCell *)[collectionView cellForItemAtIndexPath:indexPath];
                            
                            
                            [datasetCell hide:frameOfcollection and:frameOfcollectionHide and:contentOffset];
                            
                        }
                    }
                }];
                
            
            
            [playerViewAnimator addAnimations:^{
                [self setNeedsStatusBarAppearanceUpdate];
            }];
            
            
            [playerViewAnimator addCompletion:^(UIViewAnimatingPosition finalPosition) {
                [self.view setUserInteractionEnabled:YES];
                
            }];
            
            [playerViewAnimator startAnimation];

        }];
    }
    else{
        if (self->expandedCell.count > 0){
            HomeCell *datasetCell =   (HomeCell *)[collectionView cellForItemAtIndexPath:indexPath];
            
            
            [playerViewAnimator addAnimations:^{
                
                [datasetCell collapse];
                
                if (self->hiddenCells.count > 0){
                    
                    
                    for (int i = 0; i < self->hiddenCells.count; i ++) {
                        
                        NSString * strIndex = [NSString stringWithFormat:@"%@",self->hiddenCells[i]];
                        
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[strIndex integerValue] inSection:0];
                        
                        HomeCell *datasetCell =   (HomeCell *)[collectionView cellForItemAtIndexPath:indexPath];
                        
                        [datasetCell show];
                        
                    }
                    
                    
                    
                }
                
            }];
            
            [playerViewAnimator addCompletion:^(UIViewAnimatingPosition finalPosition) {
                self.collectionView.scrollEnabled = true;
                
                
                self->expandedCell = [[NSMutableArray alloc]init];
                self->hiddenCells = [[NSMutableArray alloc]init];
            }];
            
            
            [playerViewAnimator addAnimations:^{
                [self setNeedsStatusBarAppearanceUpdate];
            }];
            
            
            [playerViewAnimator addCompletion:^(UIViewAnimatingPosition finalPosition) {
                [self.view setUserInteractionEnabled:YES];
                
            }];
            
            [playerViewAnimator startAnimation];
        }
    }
    
    }



@end
