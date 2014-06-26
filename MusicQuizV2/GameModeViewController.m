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
    [self.navigationController pushViewController:matchVC animated:YES];
}

- (IBAction)playMultiplayer:(UIButton *)sender
{
    
    MultiplayerOptionsViewController *multiplayerOptionsVC = [[MultiplayerOptionsViewController alloc] initWithNibName:@"MultiplayerOptionsViewController" bundle:nil];
    [self.navigationController pushViewController:multiplayerOptionsVC animated:YES];
}

@end
