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
#import "UIColor+MusicQuiz.h"

@interface MatchViewController () {
    MusicQuiz *quiz;
    NSMutableArray *answ; // This array contains the current answer of a single question
    int quizType;
    int currentRound;
    int numberOfQuestionStoredValue;
    int questionDurationStoredValue;
    int currentAnswer;
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
    
    quiz = nil;
    
    currentRound = 0;
    
    answ = [[NSMutableArray alloc] init];
    
    // I take the values set in the option section
    numberOfQuestionStoredValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"OptionNumberOfQuestion"];
    questionDurationStoredValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"OptionQuestionDuration"];
    
    if (numberOfQuestionStoredValue && questionDurationStoredValue) {
        quiz = [[MusicQuiz alloc] initWithType:quizType CorrectAnswerScore:10 IncorrectAnswerScore:1 QuestionDuration:questionDurationStoredValue NumberOfQuestion:numberOfQuestionStoredValue];
        quiz.delegate = self;
    }
    
    // ---- LABELS ----
    // Timer Label
    self.lblTimer.text = [NSString stringWithFormat:@"%d", quiz.questionDuration];
    [self.lblTimer setFont:[UIFont lg_musicQuizFontRegularWithSize:41]];
    [self.lblTimer setTextColor:[UIColor musicQuizRed]];
    
    // Match Status Label
    //self.lblMbatchStatus.text = @"";
    
    // Round Label
    [self.lblRound setFont:[UIFont lg_musicQuizFontBoldWithSize:28]];
    [self.lblRound setTextColor:[UIColor whiteColor]];
    
    // Question Label
    self.lblQuestion.text = [quiz.questions[0] text];
    [self.lblQuestion setFont:[UIFont lg_musicQuizFontRegularWithSize:28]];
    [self.lblQuestion setTextColor:[UIColor whiteColor]];
    
    // Risposta Label
    [self.lblRisposta setFont:[UIFont lg_musicQuizFontRegularWithSize:18]];
    [self.lblRisposta setTextColor:[UIColor musicQuizRed]];
    [self.lblRisposta setHidden:YES];
    
    // Score Label
    [self.lblScore setFont:[UIFont lg_musicQuizFontBoldWithSize:28]];
    [self.lblScore setTextColor:[UIColor blackColor]];
    
    // ---- BUTTONS ----
    
    [self setValue:[UIFont lg_musicQuizFontRegularWithSize:23] forKeyPath:@"btnAnswers.font"];
    
    for (UIButton *btn in self.btnAnswers) {
        btn.tintColor =  [UIColor musicQuizRed];
    }
    
    // ---- IMG VIEW ----

    [self.imgFace setImage:[UIImage imageNamed:@"faceNeutral"]];
    
    for (int i=0; i<numberOfQuestionStoredValue; i++) {
        [self.imgStatus[i] setImage:[UIImage imageNamed:@"btnUnanswered.png"]];
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
    currentAnswer = (int)[sender tag];
    [quiz checkAnswer:answ[currentAnswer]];
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
    [self.imgFace setImage:[UIImage imageNamed:@"faceHappy"]];
    
    // I put a green dot (right answer) for the current question
    for (int i=0; i<10; i++) {
        
        if ([self.imgStatus[i] tag] == currentRound) {
            [self.imgStatus[i] setImage:[UIImage imageNamed:@"btnRightAnswer"]];
        }
    }
    
    // If the user is correct the color of the UIButton is changed to green
    UIButton * btnCorrectAnsert = self.btnAnswers[currentAnswer];
    btnCorrectAnsert.tintColor = [UIColor greenColor];
    

    
}

-(void)wrongAnswerWithCorrectAnswer:(NSString *)correctAnswer
{
    self.lblRisposta.textColor = [UIColor redColor];
    self.lblRisposta.text = @"SBAGLIATA :(";
    [self.imgFace setImage:[UIImage imageNamed:@"faceSad"]];
    
    // I put a red dot (wrong answer) for the current question
    for (int i=0; i<10; i++) {
        
        if ([self.imgStatus[i] tag] == currentRound) {
            [self.imgStatus[i] setImage:[UIImage imageNamed:@"btnWrong"]];
        }
    }
    
    // I color the text of the UIButton of the correct Answer in green
    for (UIButton *btn in self.btnAnswers) {
        if ([btn.titleLabel.text isEqualToString:correctAnswer]) {
            btn.tintColor = [UIColor greenColor];
        }
    }
}

-(void)noAnswerWithCorrectAnswer:(NSString *)correctAnswer
{
    // I put a red dot (wrong answer) for the current question
    for (int i=0; i<10; i++) {
        
        if ([self.imgStatus[i] tag] == currentRound) {
            [self.imgStatus[i] setImage:[UIImage imageNamed:@"btnWrong"]];
        }
    }
    
    // I color the text of the UIButton of the correct Answer in green
    for (UIButton *btn in self.btnAnswers) {
        if ([btn.titleLabel.text isEqualToString:correctAnswer]) {
            btn.tintColor = [UIColor greenColor];
        }
    }
}

-(void)matchFinished:(int)numOfAnswers WithScore:(int)totalScore
{
    //self.lblMbatchStatus.text = [NSString stringWithFormat:@"You answered %d questions", numOfAnswers];
    
    EndMatchViewController *endMatchVC = [[EndMatchViewController alloc] initWithNibName:@"EndMatchViewController" bundle:nil];
    endMatchVC.matchScore = totalScore;
    [self.navigationController pushViewController:endMatchVC animated:YES];
}

-(void)playingRound:(int)round WithSongs:(NSArray *)songs
{
    self.lblRound.text = [NSString stringWithFormat:@"ROUND %d", round];
    
    for (UIButton *btn in self.btnAnswers) {
        btn.tintColor =  [UIColor musicQuizRed];
    }
    
    currentRound = round;

    answ = [songs copy];

    // Setting the text of the buttons to the current answers
    for (int i=0; i<4; i++) {
        [self.btnAnswers[i] setTitle:songs[i] forState:UIControlStateNormal];
    }
    
    [self.lblScore setText:[NSString stringWithFormat:@"%d", quiz.totalScore]];
    [self.imgFace setImage:[UIImage imageNamed:@"faceNeutral"]];
}

@end
