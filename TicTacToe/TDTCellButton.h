//
//  TDTCellButton.h
//  TicTacToe
//
//  Created by Amit Chowdhary on 21/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDTCellID.h"

@interface TDTCellButton : UIButton
@property (nonatomic,strong) TDTCellID* cellID;

- (id)initWithFrame:(CGRect)frame withColor:(UIColor *)color withID:(TDTCellID *)cellID;
@end
