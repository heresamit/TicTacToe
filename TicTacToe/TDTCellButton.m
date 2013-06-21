//
//  TDTCellButton.m
//  TicTacToe
//
//  Created by Amit Chowdhary on 21/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTCellButton.h"

@implementation TDTCellButton

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id) initWithFrame:(CGRect)frame withColor:(UIColor *)color withPosition:(TDTCellPosition *)cellID {
    self = [super initWithFrame:frame];
    if (self) {
        self.cellPosition = cellID;
        self.backgroundColor = color;
        self.userInteractionEnabled = NO;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
