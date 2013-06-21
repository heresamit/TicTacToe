//
//  TDTCellButton.h
//  TicTacToe
//
//  Created by Amit Chowdhary on 21/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDTCellPosition.h"

@interface TDTCellButton : UIButton
@property (nonatomic,strong) TDTCellPosition* cellID;

- (id)initWithFrame:(CGRect)frame withColor:(UIColor *)color withID:(TDTCellPosition *)cellID;
@end
