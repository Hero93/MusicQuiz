//
//  HomeViewController.m
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 18/05/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import "HomeViewController.h"
#import "GameModeViewController.h"
#import "OptionsViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //NSLog(@"Il tuo nome è %@", [[NSUserDefaults standardUserDefaults] stringForKey:@"UserName"]);
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)beginGame:(id)sender
{
    GameModeViewController *gameVC = [[GameModeViewController alloc] initWithNibName:@"GameModeViewController" bundle:nil];
    [self.navigationController pushViewController:gameVC animated:YES];
}

-(void)lauchOptions:(id)sender
{
    OptionsViewController *optionsVC = [[OptionsViewController alloc] initWithNibName:@"OptionsViewController" bundle:nil];
    [self.navigationController pushViewController:optionsVC animated:YES];
}
@end
