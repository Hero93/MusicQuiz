//
//  FirstTimeViewController.m
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 25/05/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import "FirstTimeViewController.h"
#import "HomeViewController.h"
#import "UIFont+MusicQuiz.h"
#import "UIColor+MusicQuiz.h"

@interface FirstTimeViewController ()

@end

@implementation FirstTimeViewController

#pragma mark - Initializers (Constructors)

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
    
    self.txtName.delegate = self;
    
    // ---- LABELS ----
    // Hi Label
    [self.lblHi setFont:[UIFont lg_musicQuizFontRegularWithSize:28]];
    self.lblHi.textColor = [UIColor musicQuizGray];
    self.lblHi.text = @"Hi !";
    
    [self.txtName setFont:[UIFont lg_musicQuizFontBoldWithSize:28]];
    self.txtName.placeholder = @"Write here your name";
    self.txtName.textColor = [UIColor musicQuizRed];
    
    self.btnReady.titleLabel.font = [UIFont lg_musicQuizFontRegularWithSize:23];
    self.btnReady.tintColor = [UIColor musicQuizRed];
    
    [self.btnReady setEnabled:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)takeMeToTheGameMode:(id)sender
{
    // Saving the User Name
    [[NSUserDefaults standardUserDefaults] setValue:self.txtName.text forKey:@"UserName"];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasSeenTutorial"];
    
    HomeViewController *homeVC = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:homeVC animated:YES];
}

#pragma mark - UITextField Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.btnReady setEnabled:YES];
}


@end
