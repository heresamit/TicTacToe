//
//  TDTViewController.h
//  TicTacToe
//
//  Created by Amit Chowdhary on 21/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDTCellButton.h"
#import "TDTCellPosition.h"
#import "constants.h"
#import "TDTTicTacToeGameObject.h"


@interface TDTViewController : UIViewController <TicTacToeGameDisplayerProtocol>
-(void) gameWasWonByUser:(UserType) winner;
@end
