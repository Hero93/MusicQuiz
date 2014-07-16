//
//  EndMatchViewController.m
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 18/05/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import "EndMatchViewController.h"
#import "MatchModeViewController.h"
#import "HomeViewController.h"
#import "GameModeViewController.h"
#import "UIFont+MusicQuiz.h"

@interface EndMatchViewController ()

@end

@implementation EndMatchViewController

#pragma mark - Init Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // ---- BUTTONS ----
    
    // Replay Button
    self.btnReplay.titleLabel.font = [UIFont lg_musicQuizFontBoldWithSize:28];
    // BackToMenu Button
    self.btnBackToHomeMenu.titleLabel.font = [UIFont lg_musicQuizFontRegularWithSize:17];

    // ---- LABELS ----

    // Total Score Label
    self.lblTotalScore.text = [NSString stringWithFormat:@"You Scored %d Points", self.matchScore];
    [self.lblTotalScore setFont:[UIFont lg_musicQuizFontBoldWithSize:25]];
    
    // Hey Player Label
    self.lblHeyPlayer.text = [NSString stringWithFormat:@"Hey, %@ !", [[NSUserDefaults standardUserDefaults] stringForKey:@"UserName"]];
    [self.lblHeyPlayer setFont:[UIFont lg_musicQuizFontBoldWithSize:28]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction

- (IBAction)replayMatch:(id)sender
{
    NSArray *viewControllers = [[self navigationController] viewControllers];
    for( int i=0;i<[viewControllers count];i++){
        id obj=[viewControllers objectAtIndex:i];
        if([obj isKindOfClass:[MatchModeViewController class]]){
            [[self navigationController] popToViewController:obj animated:YES];
            return;
        }
    }
}

- (IBAction)backToHomeMenu:(id)sender
{
    NSArray *viewControllers = [[self navigationController] viewControllers];
    for( int i=0;i<[viewControllers count];i++){
        id obj=[viewControllers objectAtIndex:i];
        if([obj isKindOfClass:[HomeViewController class]]){
            [[self navigationController] popToViewController:obj animated:YES];
            return;
        }
    }
}
@end
