//
//  TDTCellID.h
//  TicTacToe
//
//  Created by Amit Chowdhary on 21/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDTCellID : NSObject
@property (nonatomic) NSInteger row;
@property (nonatomic) NSInteger column;

-(id) initWithRow:(NSInteger) row withColumn:(NSInteger) column;
@end
