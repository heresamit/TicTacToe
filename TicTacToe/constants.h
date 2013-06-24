//
//  constants.h
//  TicTacToe
//
//  Created by Amit Chowdhary on 21/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#define UNSELECTED_CELL_COLOR [UIColor colorWithRed:80.0f/256.0f green:80.0f/256.0f blue:80.0f/256.0f alpha:1]
#define LINE_THICKNESS 5.0f
#define CELL_SIDE 80.0f
#define CONTAINER_SIDE ((3 * CELL_SIDE ) + (4 * LINE_THICKNESS))
#define SPINNER_SIDE 20.0f

typedef enum{
    TDTUserTypeNone = 0,
    TDTUserTypeUser = 1,
    TDTUserTypeOpponent = 2
}Player;

typedef enum{
    TDTGameStatusNotSet = 0,
    TDTGameStatusUsersTurn = 1,
    TDTGameStatusOpponentsTurn = 2,
    TDTGameStatusFinished = 3
}GameStatus;

