//
//  TDTCellID.m
//  TicTacToe
//
//  Created by Amit Chowdhary on 21/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTCellPosition.h"

@implementation TDTCellPosition
- (id)initWithRow:(NSInteger)row withColumn:(NSInteger)column {
    self = [super init];
    if (self) {
        self.row = row;
        self.column = column;
    }
    return self;
}
@end
