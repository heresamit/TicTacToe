//
//  TDTCellObject.h
//  TicTacToe
//
//  Created by Amit Chowdhary on 21/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDTCellID.h"
#import "constants.h"
@interface TDTCell : NSObject
@property (nonatomic,strong) TDTCellID* cellID;
@property (nonatomic) CellStatus status;

-(id) initWithStatus:(CellStatus) status withCellID:(TDTCellID *) cellID;
@end
