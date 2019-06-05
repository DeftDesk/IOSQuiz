//
//  HomeCell.m
//  QuizApps
//
//  Created by DeftDesk on 05/06/19.
//  Copyright © 2019 DeftDesk. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

{
    CGRect initialFrame;
    CGFloat initialCornerRadius;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 10;
    self.contentView.layer.masksToBounds = true;
    
    self.layer.masksToBounds = false;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.layer.shadowRadius = self.contentView.layer.cornerRadius;
    
    
}

-(void)hide:(CGRect)collectionCell and:(CGRect)frameOfSelectedCell and:(float)contentOffset{
    
    initialFrame = self.frame;
    CGFloat newY;
    if (self.frame.origin.y < frameOfSelectedCell.origin.y) {
        float offset = frameOfSelectedCell.origin.y - self.frame.origin.y;
        newY = contentOffset - offset;
    }else {
        float offset = self.frame.origin.y - frameOfSelectedCell.origin.y;
        newY = contentOffset + collectionCell.size.height + offset;
    }
    
    CGRect newFrame = self.frame;
    newFrame.origin.y = newY; // add 100 to y's current value
    self.frame = newFrame;
    
    [self layoutIfNeeded];
  
}


-(void)show{
    
    if (initialFrame.size.width == 0){
        self.frame =  self.frame;
    }
    else{
        self.frame = initialFrame;
    }
    
    self.frame = initialFrame;
    initialFrame = CGRectMake(0, 0, 0,0);
    [self layoutIfNeeded];
}

-(void)expand:(CGRect)frame;

{
    initialFrame = self.frame;
    initialCornerRadius = self.contentView.layer.cornerRadius;
    self.contentView.layer.cornerRadius = 0;
    
    self.frame = frame;
    
    [self layoutIfNeeded];


}

-(void)collapse

{
    if (initialCornerRadius == 0.0){
        self.contentView.layer.cornerRadius = self.contentView.layer.cornerRadius;
        self.frame = self.frame;

    }
    else{
        self.contentView.layer.cornerRadius = initialCornerRadius;
        self.frame = initialFrame;
    }
   
    self.contentView.layer.cornerRadius = initialCornerRadius;
    self.frame = initialFrame;
    
    initialFrame = CGRectMake(0, 0, 0,0);
    initialCornerRadius = 0.0;
    [self layoutIfNeeded];
    
}

@end

