//
//  GameModeViewController.m
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 13/05/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import "MatchModeViewController.h"
#import "MatchViewController.h"
#import "UIFont+MusicQuiz.h"
#import "UIColor+MusicQuiz.h"

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
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self.lblGameMode setFont:[UIFont lg_musicQuizFontBoldWithSize:25]];
    self.lblGameMode.textColor = [UIColor musicQuizGray];
    
    self.TitleMode.titleLabel.font = [UIFont lg_musicQuizFontRegularWithSize:23];
    self.TitleMode.tintColor = [UIColor musicQuizRed];
    
    self.ArtistMode.titleLabel.font = [UIFont lg_musicQuizFontRegularWithSize:23];
    self.ArtistMode.tintColor = [UIColor musicQuizRed];
    
    self.ArtistAndTitleMode.titleLabel.font = [UIFont lg_musicQuizFontRegularWithSize:23];
    self.ArtistAndTitleMode.tintColor = [UIColor musicQuizRed];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)launchTitleMode:(id)sender
{
    MatchViewController *matchVC = [[MatchViewController alloc] initWithQuizMode:2];
    [self.navigationController pushViewController:matchVC animated:YES];
}

- (IBAction)lauchArtistMode:(id)sender
{
    MatchViewController *matchVC = [[MatchViewController alloc] initWithQuizMode:1];
    [self.navigationController pushViewController:matchVC animated:YES];
    
}
- (IBAction)launchArtistAndTitleMode:(id)sender
{
    MatchViewController *matchVC = [[MatchViewController alloc] initWithQuizMode:3];
    [self.navigationController pushViewController:matchVC animated:YES];
}
@end
