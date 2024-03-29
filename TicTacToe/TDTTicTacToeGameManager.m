//
//  TDTTicTacToeGameObject.m
//  TicTacToe
//
//  Created by Amit Chowdhary on 21/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTTicTacToeGameManager.h"
#import "TDTCell.h"

@interface TDTTicTacToeGameManager ()

@property (nonatomic, weak) id        delegate;
@property (nonatomic)       Player    winnerOfGame;

@end

@implementation TDTTicTacToeGameManager

- (id)initWithStatus:(GameStatus)status withDelegate:(id)delegate
{
    self = [super init];
    if (self) {
        self.status = status;
        self.delegate = delegate;
        [self setUpCellArray];
    }
    return self;
}

- (void)setUpCellArray {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i<3; i++) {
        NSMutableArray *rowArray = [[NSMutableArray alloc] init];
        for (NSInteger j=0; j<3; j++) {
            TDTCellPosition *position = [[TDTCellPosition alloc] initWithRow:i withColumn:j];
            TDTCell *cellToAdd = [[TDTCell alloc] initWithPlayer:TDTPlayerNone withCellPosition:position];
            [rowArray addObject:cellToAdd];
        }
        [results addObject:rowArray];
    }
    self.cellArray = [[NSArray alloc] initWithArray:results];
}

- (BOOL)gameIsDrawn {
    for (int i=0;i<3;i++) {
        for (int j=0;j<3;j++) {
            if ([self.cellArray[i][j] player] == TDTPlayerNone) {
                return NO;
            }
        }
    }
    return YES;
}

- (void)cellTappedAtPosition:(TDTCellPosition *)position byPlayer:(Player)player {
    TDTCell *cellAtTappedPosition = self.cellArray[position.row][position.column];
    cellAtTappedPosition.player = player;
    Player winner = [self winner];
    if (winner!=TDTPlayerNone) {
        self.status = TDTGameStatusFinished;
        if (winner == TDTPlayerOpponent)
            [self.delegate opponentTappedCellAtPosition:position];
        [self.delegate gameWasWonByUser:winner];
    }
    else {
        if ([self gameIsDrawn]) {
            self.status = TDTGameStatusFinished;
            [self.delegate gameWasDrawn];
            return;
        }
        if (player == TDTPlayerUser) {
            [self.delegate notifyOpponentOfTapAtPosition:position];
            self.status = TDTGameStatusOpponentsTurn;
        }
        else if (player == TDTPlayerOpponent) {
            [self.delegate opponentTappedCellAtPosition:position];
            self.status = TDTGameStatusUsersTurn;
        }
    }
}

- (Player)whoOwnsLeftDiagonal {
    for (int i=1; i<3; i++) {
        if([self.cellArray[i][i] player] != [self.cellArray[i-1][i-1] player]) {
            return TDTPlayerNone;
        }
    }
    return [self.cellArray[0][0] player];
}

- (Player)whoOwnsRightDiagonal {
    int i,j;
    for(i = 0,j = 2; i <= 1; i++,j--) {
        if ([self.cellArray[i][j] player] != [self.cellArray[i+1][j-1] player]) {
            return TDTPlayerNone;
        }
    }
    return [self.cellArray[0][2] player];
}

- (Player)whichPlayerWonByCompletingDiagonals {
    if ([self whoOwnsLeftDiagonal] != TDTPlayerNone) {
        return [self whoOwnsLeftDiagonal];
    }
    else if ([self whoOwnsRightDiagonal] != TDTPlayerNone) {
        return [self whoOwnsRightDiagonal];
    }
    else {
        return TDTPlayerNone;
    }
    
}

- (Player)findWinnerOfRowOrCol:(int)i usingBlockToGetCell:(TDTCell *(^)(int i, int j))block {
    BOOL isComplete = NO;
    for (int j=1; j<3; j++) {
        if ([block(i,j) player] != [block(i,j-1) player]) {
            isComplete = NO;
            break;
        }
        else {
            isComplete = YES;
        }
    }
    if (isComplete) {
        return [block(i,0) player];
    }
    return TDTPlayerNone;
}

- (Player)whichPlayerWinsByCompletingRowOrColumn {
    TDTCell *(^blockToTraverseRow)(int i, int j) = ^(int i, int j){return self.cellArray[i][j];};
    TDTCell *(^blockToTraverseCol)(int i, int j) = ^(int i, int j){return self.cellArray[j][i];};
    
    for (int i=0; i<3; i++) {
        Player rowWinner = [self findWinnerOfRowOrCol:i usingBlockToGetCell:blockToTraverseRow];
        if (rowWinner != TDTPlayerNone) {
            return rowWinner;
        }
        else {
            Player colWinner = [self findWinnerOfRowOrCol:i usingBlockToGetCell:blockToTraverseCol];
            if (colWinner != TDTPlayerNone) {
                return colWinner;
            }
        }
    }
    return TDTPlayerNone;
}

- (Player)winner {
    Player winner = [self whichPlayerWonByCompletingDiagonals];
    if (winner == TDTPlayerNone) {
        return [self whichPlayerWinsByCompletingRowOrColumn];
    }
    return winner;
}

@end
