//
//  TDTCellObject.h
//  TicTacToe
//
//  Created by Amit Chowdhary on 21/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDTCellPosition.h"
#import "constants.h"

@interface TDTCell : NSObject

@property (nonatomic, strong) TDTCellPosition* cellPosition;
@property (nonatomic)         Player           player;

- (id)initWithPlayer:(Player)player withCellPosition:(TDTCellPosition *)cellID;

@end
