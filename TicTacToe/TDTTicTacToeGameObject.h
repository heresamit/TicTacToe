//
//  TDTTicTacToeGameObject.h
//  TicTacToe
//
//  Created by Amit Chowdhary on 21/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDTCellID.h"
#import "constants.h"

@protocol TicTacToeGameDisplayerProtocol

-(void) gameWasWonByUser:(UserType) winner;
-(void) opponentTappedCellAtPosition:(TDTCellID *) position;
-(void) gameWasDrawn;
-(void) gameStartedWithStatus:(GameStatus) status;

@end

@interface TDTTicTacToeGameObject : NSObject
@property (nonatomic,strong) NSArray* cellArray;
@property (nonatomic) GameStatus status;

-(id) initWithStatus:(GameStatus) status withDelegate:(id) delegate;
-(void) cellTappedAtPosition:(TDTCellID *) position byPlayer:(UserType) player;

@end
