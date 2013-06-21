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
-(id) initWithStatus:(GameStatus) status withDelegate:(id) delegate
{
    self = [super init];
    if(self)
    {
        self.status = status;
        self.delegate = delegate;
        [self setUpCellArray];
    }
    return self;
}
-(void) setUpCellArray
{
    NSMutableArray *tempCellArray = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i<3; i++)
    {
        NSMutableArray *rowArray = [[NSMutableArray alloc] init];
        for (NSInteger j=0; j<3; j++)
            [rowArray addObject:[[TDTCell alloc]initWithStatus:unoccupied withCellID:[[TDTCellPosition alloc] initWithRow:i withColumn:j]]];
        [tempCellArray addObject:rowArray];
    }
    self.cellArray = [[NSArray alloc] initWithArray:tempCellArray];
}


-(BOOL) gameIsDrawn
{
    for(int i=0;i<3;i++)
        for (int j=0;j<3;j++)
            if ([self.cellArray[i][j] status] == unoccupied)
                return NO;
    
    return YES;
}
-(void) cellTappedAtPosition:(TDTCellPosition *) position byPlayer:(UserType) player
{
    TDTCell *temp = self.cellArray[position.row][position.column];
    temp.status = player;
    UserType winner = [self gameWasWonByUser];
    if(winner!=unoccupied)
    {
        self.status = finished;
        if(winner == belongsToOpponent)
            [self.delegate opponentTappedCellAtPosition:position];
        [self.delegate gameWasWonByUser:winner];
    }
    else
    {
        if([self gameIsDrawn])
        {
            self.status = finished;
            [self.delegate gameWasDrawn];
            return;
        }
        if(player == belongsToUser)
        {
            [self.delegate notifyOpponentOfTapAtPosition:position];
            self.status = opponentsTurn;
        }
        else if(player == belongsToOpponent)
        {
            [self.delegate opponentTappedCellAtPosition:position];
            self.status = usersTurn;
        }
    }
}

-(UserType) gameWasWonByUser
{
    if(([self.cellArray[0][0] status] != unoccupied) && (([self.cellArray[0][0] status] == [self.cellArray[1][1] status]) ? ([self.cellArray[2][2] status] == [self.cellArray[1][1] status]) : NO))
        return [self.cellArray[0][0] status];
    if(([self.cellArray[0][2] status] != unoccupied) && (([self.cellArray[0][2] status] == [self.cellArray[1][1] status]) ? ([self.cellArray[2][0] status] == [self.cellArray[1][1] status]) : NO))
        return [self.cellArray[1][1] status];
    
    for(int i=0;i<3;i++)
        if(([self.cellArray[i][0] status] != unoccupied) && (([self.cellArray[i][0] status] == [self.cellArray[i][1] status]) ? ([self.cellArray[i][1] status] == [self.cellArray[i][2] status]) : NO))
           return [self.cellArray[i][0] status];
        else if(([self.cellArray[0][i] status] != unoccupied) &&(([self.cellArray[0][i] status] == [self.cellArray[1][i] status]) ? ([self.cellArray[1][i] status] == [self.cellArray[2][i] status]) : NO))
           return [self.cellArray[0][i] status];

    return unoccupied;
}
@end
