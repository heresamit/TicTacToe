//
//  TDTTicTacToeGameObject.m
//  TicTacToe
//
//  Created by Amit Chowdhary on 21/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTTicTacToeGameObject.h"
#import "TDTCell.h"

@interface TDTTicTacToeGameObject ()

@property (nonatomic,weak) id delegate;

@end

@implementation TDTTicTacToeGameObject

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
            TDTCell *cellToAdd = [[TDTCell alloc] initWithStatus:none withCellPosition:position];
            [rowArray addObject:cellToAdd];
        }
        [tempCellArray addObject:rowArray];
    }
    self.cellArray = [[NSArray alloc] initWithArray:tempCellArray];
}

- (BOOL)gameIsDrawn {
    for (int i=0;i<3;i++) {
        for (int j=0;j<3;j++) {
            if ([self.cellArray[i][j] status] == none) {
                return NO;
            }
        }
    }
    return YES;
}

- (void)cellTappedAtPosition:(TDTCellPosition *) position byPlayer:(UserType) player {
    TDTCell *cellAtTappedPosition = self.cellArray[position.row][position.column];
    cellAtTappedPosition.belongsTo = player;
    UserType winner = [self gameWasWonByUser];
    if (winner!=none) {
        self.status = finished;
        if (winner == opponent)
            [self.delegate opponentTappedCellAtPosition:position];
        [self.delegate gameWasWonByUser:winner];
    }
    else {
        if ([self gameIsDrawn]) {
            self.status = finished;
            [self.delegate gameWasDrawn];
            return;
        }
        if (player == user) {
            [self.delegate notifyOpponentOfTapAtPosition:position];
            self.status = opponentsTurn;
        }
        else if (player == opponent) {
            [self.delegate opponentTappedCellAtPosition:position];
            self.status = usersTurn;
        }
    }
}

- (UserType)gameWasWonByUser {
    if (([self.cellArray[0][0] status] != none) && (([self.cellArray[0][0] status] == [self.cellArray[1][1] status]) ? ([self.cellArray[2][2] status] == [self.cellArray[1][1] status]) : NO))
        return [self.cellArray[0][0] status];
    if (([self.cellArray[0][2] status] != none) && (([self.cellArray[0][2] status] == [self.cellArray[1][1] status]) ? ([self.cellArray[2][0] status] == [self.cellArray[1][1] status]) : NO))
        return [self.cellArray[1][1] status];

    for (int i=0;i<3;i++)
        if (([self.cellArray[i][0] status] != none) && (([self.cellArray[i][0] status] == [self.cellArray[i][1] status]) ? ([self.cellArray[i][1] status] == [self.cellArray[i][2] status]) : NO))
           return [self.cellArray[i][0] status];
        else if (([self.cellArray[0][i] status] != none) &&(([self.cellArray[0][i] status] == [self.cellArray[1][i] status]) ? ([self.cellArray[1][i] status] == [self.cellArray[2][i] status]) : NO))
           return [self.cellArray[0][i] status];

    return none;
}
@end
