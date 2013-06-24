//
//  TDTCellObject.m
//  TicTacToe
//
//  Created by Amit Chowdhary on 21/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTCell.h"


@implementation TDTCell

- (id)initWithStatus:(Player)player withCellPosition:(TDTCellPosition *)cellPosition {
    self = [super init];
    if (self) {
        self.cellPosition = cellPosition;
        self.player = player;
    }
    return self;
}
@end
