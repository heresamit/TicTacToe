//
//  TDTViewController.m
//  TicTacToe
//
//  Created by Amit Chowdhary on 21/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTViewController.h"

@interface TDTViewController ()
@property (nonatomic,strong) UILabel* infoLabel;
@property (nonatomic,strong) UIActivityIndicatorView* spinner;
@property (nonatomic,strong) UIView* containerView;
@property (nonatomic,strong) TDTTicTacToeGameObject* gameObj;
@property (nonatomic,strong) NSArray *buttonArray;
@property (nonatomic,strong) NSArray *colorArray;
@property (nonatomic,weak) UIColor* userColor;
@property (nonatomic,weak) UIColor* opponentColor;
@end

@implementation TDTViewController

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initializator];
    }
    return self;
}

-(void) initializator
{
    
    self.gameObj = [[TDTTicTacToeGameObject alloc] initWithStatus:gameStatusNotSet withDelegate:self];
    [self fillButtonArray];
    
    NSInteger containerSide = CONTAINER_SIDE;
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(30, 120, containerSide, containerSide)];
    [self displayButtonArrayInContainerView:self.containerView];
    self.containerView.backgroundColor = [UIColor blackColor];
    
    
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.containerView.frame.origin.x, self.containerView.frame.origin.y - 70, containerSide, 20)];
    self.infoLabel.text = @"   Setting up your game...";
    self.infoLabel.textColor = [UIColor lightGrayColor];
    self.infoLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
    self.infoLabel.textAlignment = NSTextAlignmentCenter;
    
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.containerView.center.x - SPINNER_SIDE/2, self.containerView.frame.origin.y - 38, SPINNER_SIDE, SPINNER_SIDE)];
    self.spinner.color = [UIColor lightGrayColor];
    
    [self setUserAndOpponentColors];
    
}

-(void) setUserAndOpponentColors
{
    self.colorArray = [[NSArray alloc] initWithObjects:[UIColor colorWithRed:57.0f/255.0f green:1 blue:0 alpha:1],//Bright Green
                                                       [UIColor colorWithRed:1 green:0 blue:32.0f/255.0f alpha:1],//Bright Red
                                                       [UIColor colorWithRed:170.0f/255.0f green:0 blue:1 alpha:1],//Violet
                                                       [UIColor colorWithRed:0 green:80.0f/255.0f blue:239.0f/255.0f alpha:1],//cobalt
                                                       [UIColor colorWithRed:1 green:105.0f/255.0f blue:0 alpha:1],//Orange                   
                       nil];
    NSInteger userColorIndex = arc4random() % self.colorArray.count;
    self.userColor = self.colorArray[userColorIndex];
    
    while (1) {
        NSInteger opponentColorIndex = arc4random() % self.colorArray.count;
        if(opponentColorIndex == userColorIndex)
            continue;
        else
        {
            self.opponentColor = self.colorArray[opponentColorIndex];
            break;
        }
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.containerView];
    [self.view addSubview:self.infoLabel];
    [self.view addSubview:self.spinner];
    [self.spinner startAnimating];
    [self performSelector:@selector(gameStartedWithStatus:) withObject:nil afterDelay:1.5];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) gameStartedWithStatus:(GameStatus) status
{
    status = usersTurn;//REMOVE THIS LINE
    if(status!=gameStatusNotSet)
    {
        self.gameObj.status = status;
        if(status == usersTurn)
        {
            self.infoLabel.text = @"Your Turn";
            [self setInteractionEnabledOrNotOnButtons:YES];
            [self.spinner stopAnimating];
            self.gameObj.status = usersTurn;
        }
        else
        {
            self.infoLabel.text = @"Waiting for opponent to start";
            self.gameObj.status = opponentsTurn;
        }
    }
}

-(void) setInteractionEnabledOrNotOnButtons:(BOOL) enabled
{
    for(int i=0;i<3;i++)
        for(int j=0;j<3;j++)
            if([self.gameObj.cellArray[i][j] status] == unoccupied)
                [self.buttonArray[i][j] setUserInteractionEnabled:enabled];
}

-(void) fillButtonArray
{
    NSMutableArray *tempCellArray = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i<3; i++)
    {
        NSMutableArray *rowArray = [[NSMutableArray alloc] init];
        for (NSInteger j=0; j<3; j++)
        {
            CGRect cellRect = CGRectMake(LINE_THICKNESS + j * (LINE_THICKNESS + CELL_SIDE), LINE_THICKNESS + i *(LINE_THICKNESS + CELL_SIDE), CELL_SIDE, CELL_SIDE);
            TDTCellButton *temp = [[TDTCellButton alloc] initWithFrame:cellRect withColor:UNSELECTED_CELL_COLOR withID:[self.gameObj.cellArray[i][j] cellID]];
            [temp addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [rowArray addObject:temp];
        }
        [tempCellArray addObject:rowArray];
        
    }
    self.buttonArray = [[NSArray alloc] initWithArray:tempCellArray];
}

-(void) buttonPressed:(TDTCellButton *) sender
{
    NSLog(@"%@",sender);
    sender.UserInteractionEnabled = NO;
    sender.backgroundColor = self.userColor;
    self.containerView.userInteractionEnabled = NO;
    self.infoLabel.text = @"Waiting for opponent";
    [self.spinner startAnimating];
    [self.gameObj cellTappedAtPosition:sender.cellID byPlayer:belongsToUser];
}

-(void) displayButtonArrayInContainerView:(UIView *)container
{
    for (NSInteger i=0; i<3; i++)
        for (NSInteger j=0; j<3; j++)
            [container addSubview:self.buttonArray[i][j]];
}

-(void) wrapUpGame
{
    self.gameObj = nil;
    self.containerView.userInteractionEnabled = NO;
}
//****************************************************************************************************

-(void) gameWasWonByUser:(UserType)winner
{
    NSString *victoryText = (winner == belongsToUser? @"Congrats You Won!" : @"You Lost!!");
    self.infoLabel.text = victoryText;
    [self.spinner stopAnimating];
    [self wrapUpGame];
}

-(void) opponentTappedCellAtPosition:(TDTCellPosition *)position
{
    [self.buttonArray[position.row][position.column] setBackgroundColor:self.opponentColor];
    self.containerView.userInteractionEnabled = YES;
    [self.spinner stopAnimating];
    self.infoLabel.text = @"Your Turn";
    [self.buttonArray[position.row][position.column] setUserInteractionEnabled:NO];
}

-(void) gameWasDrawn
{
    self.infoLabel.text = @"Game Drawn";
    [self.spinner stopAnimating];
    [self wrapUpGame];
}
@end
