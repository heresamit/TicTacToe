//
//  TDTCellObject.m
//  TicTacToe
//
//  Created by Amit Chowdhary on 21/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTCell.h"


@implementation TDTCell

- (id)initWithStatus:(CellStatus)belongsTo withCellPosition:(TDTCellPosition *)cellID {
    self = [super init];
    if (self) {
        self.cellID = cellID;
        self.belongsTo = belongsTo;
    }
    return self;
}
@end
