//
//  TDTCellObject.m
//  TicTacToe
//
//  Created by Amit Chowdhary on 21/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTCellObject.h"


@implementation TDTCellObject


-(id) initWithStatus:(CellStatus) status withCellID:(TDTCellID *) cellID
{
    self = [super init];
    if(self)
    {
        self.cellID = cellID;
        self.status = status;
    }
    return self;
}
@end
