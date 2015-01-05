//
//  GameModeViewController.m
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 13/05/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import "MatchModeViewController.h"
#import "MatchViewController.h"
#import "MultiplayerOptionsViewController.h"
#import "UIFont+MusicQuiz.h"
#import "UIColor+MusicQuiz.h"
#import "MusicQuizModeTypes.h"

@interface MatchModeViewController ()

@end

@implementation MatchModeViewController

#pragma mark - Init Methods (Class Constructur)

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
    
    // Hide the Navigation Bar
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self setBackButton];
    
    [self.lblGameMode setFont:[UIFont musicQuizFontBoldWithSize:25]];
    self.lblGameMode.textColor = [UIColor musicQuizGray];
    
    self.TitleMode.titleLabel.font = [UIFont musicQuizFontRegularWithSize:23];
    self.TitleMode.tintColor = [UIColor musicQuizRed];
    
    self.ArtistMode.titleLabel.font = [UIFont musicQuizFontRegularWithSize:23];
    self.ArtistMode.tintColor = [UIColor musicQuizRed];
    
    self.ArtistAndTitleMode.titleLabel.font = [UIFont musicQuizFontRegularWithSize:23];
    self.ArtistAndTitleMode.tintColor = [UIColor musicQuizRed];
}

- (void)setBackButton
{
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"btn_back2"] forState:UIControlStateNormal];
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

#pragma mark - IBAction

- (IBAction)launchTitleMode:(id)sender
{
    
    if ([self.gameMode isEqualToString:@"SinglePlayer"]) {
        
        MatchViewController *matchVC = [[MatchViewController alloc] initWithQuizMode:musicQuizModeTitle];
        [self.navigationController pushViewController:matchVC animated:YES];
        
    } else if ([self.gameMode isEqualToString:@"Multiplayer"]) {
        
        MultiplayerOptionsViewController *multiplayerOptionsVC = [[MultiplayerOptionsViewController alloc] initWithNibName:@"MultiplayerOptionsViewController" bundle:nil];
        multiplayerOptionsVC.quizMode = musicQuizModeTitle;
        [self.navigationController pushViewController:multiplayerOptionsVC animated:YES];

    }
}

- (IBAction)lauchArtistMode:(id)sender
{
    if ([self.gameMode isEqualToString:@"SinglePlayer"]) {
        
        MatchViewController *matchVC = [[MatchViewController alloc] initWithQuizMode:musicQuizModeArtist];
        [self.navigationController pushViewController:matchVC animated:YES];
        
    } else if ([self.gameMode isEqualToString:@"Multiplayer"]) {
        
        MultiplayerOptionsViewController *multiplayerOptionsVC = [[MultiplayerOptionsViewController alloc] initWithNibName:@"MultiplayerOptionsViewController" bundle:nil];
        multiplayerOptionsVC.quizMode = musicQuizModeArtist;
        [self.navigationController pushViewController:multiplayerOptionsVC animated:YES];
    }
}

- (IBAction)launchArtistAndTitleMode:(id)sender
{
    if ([self.gameMode isEqualToString:@"SinglePlayer"]) {
        
        MatchViewController *matchVC = [[MatchViewController alloc] initWithQuizMode:musicQuizModeArtistTitle];
        [self.navigationController pushViewController:matchVC animated:YES];
    
    } else if ([self.gameMode isEqualToString:@"Multiplayer"]) {
        
        MultiplayerOptionsViewController *multiplayerOptionsVC = [[MultiplayerOptionsViewController alloc] initWithNibName:@"MultiplayerOptionsViewController" bundle:nil];
        multiplayerOptionsVC.quizMode = musicQuizModeArtistTitle;
        [self.navigationController pushViewController:multiplayerOptionsVC animated:YES];
    }
}
@end
