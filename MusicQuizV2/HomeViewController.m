//
//  HomeViewController.m
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 18/05/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import "HomeViewController.h"
#import "GameModeViewController.h"

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)beginGame:(id)sender
{
    GameModeViewController *gameVC = [[GameModeViewController alloc] initWithNibName:@"GameModeViewController" bundle:nil];
    [self.navigationController pushViewController:gameVC animated:YES];
}
@end
