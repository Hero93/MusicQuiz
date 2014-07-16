//
//  GameModeViewController.m
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 15/06/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import "GameModeViewController.h"
#import "MatchModeViewController.h"
#import "MultiplayerOptionsViewController.h"
#import "UIFont+MusicQuiz.h"
#import "UIColor+MusicQuiz.h"

@interface GameModeViewController ()

@end

@implementation GameModeViewController

#pragma mark - Controller Constructor Method
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
    
    [self.lblGameMode setFont:[UIFont lg_musicQuizFontBoldWithSize:25]];
    self.lblGameMode.textColor = [UIColor musicQuizGray];
    self.lblGameMode.text = @"Game Mode";
    
    self.btnSinglePlayer.titleLabel.font = [UIFont lg_musicQuizFontRegularWithSize:23];
    self.btnSinglePlayer.tintColor = [UIColor musicQuizRed];
    
    self.btnMultiPlayer.titleLabel.font = [UIFont lg_musicQuizFontRegularWithSize:23];
    self.btnMultiPlayer.tintColor = [UIColor musicQuizRed];
    
    [self setBackButton];
}

- (void)setBackButton
{
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"btnBack2.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setFrame:CGRectMake(10, 25, 19, 32)];
    
    [self.view addSubview:backButton];
}

- (void)backButtonTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)playSingleplayer:(UIButton *)sender
{
    MatchModeViewController *matchVC = [[MatchModeViewController alloc] initWithNibName:@"MatchModeViewController" bundle:nil];
    matchVC.gameMode = @"SinglePlayer";
    [self.navigationController pushViewController:matchVC animated:YES];
}

- (IBAction)playMultiplayer:(UIButton *)sender
{
    /*
    MultiplayerOptionsViewController *multiplayerOptionsVC = [[MultiplayerOptionsViewController alloc] initWithNibName:@"MultiplayerOptionsViewController" bundle:nil];
    [self.navigationController pushViewController:multiplayerOptionsVC animated:YES];
     */
    
    MatchModeViewController *matchVC = [[MatchModeViewController alloc] initWithNibName:@"MatchModeViewController" bundle:nil];
    matchVC.gameMode = @"Multiplayer";
    [self.navigationController pushViewController:matchVC animated:YES];
}

@end
