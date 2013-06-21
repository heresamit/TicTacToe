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
    none = 0,
    user = 1,
    opponent = 2
}CellStatus;

typedef enum{
    gameStatusNotSet = 0,
    usersTurn = 1,
    opponentsTurn = 2,
    finished = 3
}GameStatus;

typedef CellStatus UserType;
/*
typedef enum{
    none = 0,
    user = 1,
    opponent = 2
} userType;
*/