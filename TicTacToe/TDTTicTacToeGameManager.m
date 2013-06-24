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
@property (nonatomic)       UserType  winnerOfGame;

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
    NSMutableArray *tempCellArray = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i<3; i++) {
        NSMutableArray *rowArray = [[NSMutableArray alloc] init];
        for (NSInteger j=0; j<3; j++) {
            TDTCellPosition *position = [[TDTCellPosition alloc] initWithRow:i withColumn:j];
            TDTCell *cellToAdd = [[TDTCell alloc] initWithStatus:TDTUserTypeNone withCellPosition:position];
            [rowArray addObject:cellToAdd];
        }
        [tempCellArray addObject:rowArray];
    }
    self.cellArray = [[NSArray alloc] initWithArray:tempCellArray];
}

- (BOOL)gameIsDrawn {
    for (int i=0;i<3;i++) {
        for (int j=0;j<3;j++) {
            if ([self.cellArray[i][j] belongsTo] == TDTUserTypeNone) {
                return NO;
            }
        }
    }
    return YES;
}

- (void)cellTappedAtPosition:(TDTCellPosition *) position byPlayer:(UserType) player {
    TDTCell *cellAtTappedPosition = self.cellArray[position.row][position.column];
    cellAtTappedPosition.belongsTo = player;
    UserType winner = [self winnerType];
    if (winner!=TDTUserTypeNone) {
        self.status = TDTGameStatusFinished;
        if (winner == TDTUserTypeOpponent)
            [self.delegate opponentTappedCellAtPosition:position];
        [self.delegate gameWasWonByUser:winner];
    }
    else {
        if ([self gameIsDrawn]) {
            self.status = TDTGameStatusFinished;
            [self.delegate gameWasDrawn];
            return;
        }
        if (player == TDTUserTypeUser) {
            [self.delegate notifyOpponentOfTapAtPosition:position];
            self.status = TDTGameStatusOpponentsTurn;
        }
        else if (player == TDTUserTypeOpponent) {
            [self.delegate opponentTappedCellAtPosition:position];
            self.status = TDTGameStatusUsersTurn;
        }
    }
}

- (UserType)whoOwnsLeftDiagonal {
    for (int i=1; i<3; i++) {
        if([self.cellArray[i][i] belongsTo] != [self.cellArray[i-1][i-1] belongsTo]) {
            return TDTUserTypeNone;
        }
    }
    return [self.cellArray[0][0] belongsTo];
}

- (UserType)whoOwnsRightDiagonal {
    int i,j;
    for(i = 0,j = 2; i <= 1; i++,j--) {
        if ([self.cellArray[i][j] belongsTo] != [self.cellArray[i+1][j-1] belongsTo]) {
            return TDTUserTypeNone;
        }
    }
    return [self.cellArray[0][2] belongsTo];
}

- (UserType)whichPlayerWonByCompletingDiagonals {
    if ([self whoOwnsLeftDiagonal] != TDTUserTypeNone) {
        return [self whoOwnsLeftDiagonal];
    }
    else if ([self whoOwnsRightDiagonal] != TDTUserTypeNone) {
        return [self whoOwnsRightDiagonal];
    }
    else {
        return TDTUserTypeNone;
    }
    
}

- (UserType)findWinnerOfRowOrCol:(int)i usingBlockToGetCell:(TDTCell *(^)(int i, int j))block {
    BOOL isComplete = NO;
    for (int j=1; j<3; j++) {
        if ([block(i,j) belongsTo] != [block(i,j-1) belongsTo]) {
            isComplete = NO;
            break;
        }
        else {
            isComplete = YES;
        }
    }
    if (isComplete) {
        return [block(i,0) belongsTo];
    }
    return TDTUserTypeNone;
}

- (UserType)whichPlayerWinsByCompletingRowOrColumn {
    TDTCell *(^blockToTraverseRow)(int i, int j) = ^(int i, int j){return self.cellArray[i][j];};
    TDTCell *(^blockToTraverseCol)(int i, int j) = ^(int i, int j){return self.cellArray[j][i];};
    
    for (int i=0; i<3; i++) {
        UserType rowWinner = [self findWinnerOfRowOrCol:i usingBlockToGetCell:blockToTraverseRow];
        if (rowWinner != TDTUserTypeNone) {
            return rowWinner;
        }
        else {
            UserType colWinner = [self findWinnerOfRowOrCol:i usingBlockToGetCell:blockToTraverseCol];
            if (colWinner != TDTUserTypeNone) {
                return colWinner;
            }
        }
    }
    return TDTUserTypeNone;
}

- (UserType)winnerType {
    UserType winnerType = [self whichPlayerWonByCompletingDiagonals];
    if (winnerType == TDTUserTypeNone) {
        return [self whichPlayerWinsByCompletingRowOrColumn];
    }
    return winnerType;
}

@end
