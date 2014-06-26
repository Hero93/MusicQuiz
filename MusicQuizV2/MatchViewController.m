//
//  MatchViewController.m
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 07/05/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import "MatchViewController.h"
#import "EndMatchViewController.h"
#import "UIFont+MusicQuiz.h"

@interface MatchViewController () {
    MusicQuiz *quiz;
    NSMutableArray *answ; // This array contains the current answer of a single question
    int quizType;
    UIColor *redInterface;
}

@end

@implementation MatchViewController

# pragma mark - Init methods (Class Constructor)
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (instancetype)initWithQuizMode:(int)gameMode
{
    self = [super initWithNibName:@"MatchViewController" bundle:nil];
    if (self) {
        quizType = gameMode;
        self.title = @"Match";
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    redInterface = [UIColor colorWithRed:1 green:0.231 blue:0.188 alpha:1];
    quiz = nil;
    
    answ = [[NSMutableArray alloc] init];
        
    quiz = [[MusicQuiz alloc] initWithType:quizType Score:10 QuestionDuration:15 NumberOfQuestion:4];
    quiz.delegate = self;
    
    // ---- LABELS ----
    // Timer Label
    self.lblTimer.text = [NSString stringWithFormat:@"%d", quiz.questionDuration];
    [self.lblTimer setFont:[UIFont lg_musicQuizFontRegularWithSize:41]];
    [self.lblTimer setTextColor:redInterface];
    
    // Match Status Label
    self.lblMbatchStatus.text = @"";
    
    // Round Label
    [self.lblRound setFont:[UIFont lg_musicQuizFontBoldWithSize:28]];
    
    // Question Label
    self.lblQuestion.text = [quiz.questions[0] text];
    [self.lblQuestion setFont:[UIFont lg_musicQuizFontRegularWithSize:21]];
    [self.lblQuestion setTextColor:[UIColor whiteColor]];
    
    // Risposta Label
    [self.lblRisposta setFont:[UIFont lg_musicQuizFontRegularWithSize:18]];
    [self.lblRisposta setTextColor:redInterface];
    
    // ---- BUTTONS ----
    
    [self setValue:[UIFont lg_musicQuizFontRegularWithSize:23] forKeyPath:@"btnAnswers.font"];
    
    for (UIButton *btn in self.btnAnswers) {
        btn.tintColor =  redInterface;
    }

    [quiz startQuiz];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction
- (IBAction)replayMatch:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)showAnswer:(id)sender
{
    // A tag is set with every answer button
    // tag 0: Question 1
    // tag 1: Question 2
    // tag 2: Question 3
    // tag 3: Question 4
    int questionIndex = (int)[sender tag];
    [quiz checkAnswer:answ[questionIndex]];
}

#pragma mark - Music Quiz Deleate Methods
-(void)updateTimer
{
    self.lblTimer.text = [NSString stringWithFormat:@"%d", quiz.timeTick];
}

-(void)correctAnsw
{
    self.lblRisposta.textColor = [UIColor greenColor];
    self.lblRisposta.text = @"CORRETTA !";
}

-(void)wrongAnsw
{
    self.lblRisposta.textColor = [UIColor redColor];
    self.lblRisposta.text = @"SBAGLIATA :(";
}

-(void)matchFinished:(int)numOfAnswers WithScore:(int)totalScore
{
    self.lblMbatchStatus.text = [NSString stringWithFormat:@"You answered %d questions", numOfAnswers];
    
    EndMatchViewController *endMatchVC = [[EndMatchViewController alloc] initWithNibName:@"EndMatchViewController" bundle:nil];
    endMatchVC.matchScore = totalScore;
    [self.navigationController pushViewController:endMatchVC animated:YES];
}

-(void)playingRound:(int)round WithSongs:(NSArray *)songs
{
    self.lblRound.text = [NSString stringWithFormat:@"ROUND %d", round];

    answ = [songs copy];

    // Setting the text of the buttons to the current answers
    for (int i=0; i<4; i++) {
        [self.btnAnswers[i] setTitle:songs[i] forState:UIControlStateNormal];
    }
}

@end
