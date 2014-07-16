//
//  OptionsViewController.m
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 15/07/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import "OptionsViewController.h"
#import "UIFont+MusicQuiz.h"
#import "UIColor+MusicQuiz.h"

@interface OptionsViewController ()
@end

@implementation OptionsViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Options"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    int numberOfQuestionStoredValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"OptionNumberOfQuestion"];
    int questionDurationStoredValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"OptionQuestionDuration"];
    
    if (numberOfQuestionStoredValue) {
        [self.lblNumberOfQuestions setText:[NSString stringWithFormat:@"%d Questions", numberOfQuestionStoredValue]];
        [self.sliderNumberOfQuestions setValue:numberOfQuestionStoredValue];
    } else {
        [self.lblNumberOfQuestions setText:[NSString stringWithFormat:@"%d Questions", (int)self.sliderNumberOfQuestions.value]];
    }
    
    if (questionDurationStoredValue) {
        [self.lblQuestionDuration setText:[NSString stringWithFormat:@"%d Seconds", questionDurationStoredValue]];
        [self.sliderQuestionDuration setValue:questionDurationStoredValue];
    } else {
        [self.lblQuestionDuration setText:[NSString stringWithFormat:@"%d Seconds", (int)self.sliderQuestionDuration.value]];
    }
    
    [self.lblQuestionDuration setFont:[UIFont lg_musicQuizFontRegularWithSize:18]];
    self.lblQuestionDuration.textColor = [UIColor musicQuizRed];
    [self.lblNumberOfQuestions setFont:[UIFont lg_musicQuizFontRegularWithSize:18]];
    self.lblNumberOfQuestions.textColor = [UIColor musicQuizRed];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)numberOfQuestionChanged:(UISlider *)sender
{
    [self.lblNumberOfQuestions setText:[NSString stringWithFormat:@"%d Questions", (int)sender.value]];
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:(int)sender.value] forKey:@"OptionNumberOfQuestion"];
}

- (IBAction)questionDurationChanged:(UISlider *)sender
{
    [self.lblQuestionDuration setText:[NSString stringWithFormat:@"%d Seconds", (int)sender.value]];
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:(int)sender.value] forKey:@"OptionQuestionDuration"];
}
@end
