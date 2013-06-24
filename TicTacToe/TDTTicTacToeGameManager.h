//
//  TDTTicTacToeGameObject.h
//  TicTacToe
//
//  Created by Amit Chowdhary on 21/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDTCellPosition.h"
#import "constants.h"

@protocol TicTacToeGameDisplayerProtocol

-(void) gameWasWonByUser:(Player)winner;
-(void) opponentTappedCellAtPosition:(TDTCellPosition *)position;
-(void) gameWasDrawn;
-(void) gameStartedWithStatus:(GameStatus)status;
-(void) notifyOpponentOfTapAtPosition: (TDTCellPosition *)position;

@end

@interface TDTTicTacToeGameManager : NSObject

@property (nonatomic, strong) NSArray*   cellArray;
@property (nonatomic)         GameStatus status;

- (id)initWithStatus:(GameStatus)status withDelegate:(id)delegate;
- (void)cellTappedAtPosition:(TDTCellPosition *)position byPlayer:(Player)player;

@end
