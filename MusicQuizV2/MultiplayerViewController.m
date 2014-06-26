//
//  MultiplayerViewController.m
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 15/06/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import "MultiplayerViewController.h"
#import "MultiplayerOptionsViewController.h"
#import "MusicQuiz.h"
#import "AppDelegate.h"

@interface MultiplayerViewController ()

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) MusicQuiz *quiz;

@property (nonatomic) BOOL hasCreatedGame;
@property (nonatomic) BOOL isGameRunning;

@end

@implementation MultiplayerViewController

#pragma mark - Controller Constructor Method

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.lblNowPlayingSong.hidden = YES;
    self.lblSongArtist.hidden = YES;
    self.lblSongTitle.hidden = YES;
    self.lblTimer.hidden = YES;
    self.btnBack.hidden = YES;

    for (UIButton *b in self.btnAnswers) {
        b.hidden = YES;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleReceivedDataWithNotification:)
                                                 name:@"MusicQuiz_DidReceiveDataNotification"
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Notification Handling

// The message received are NSDictionaries with this form:
//
// ||          content           || content NSString description ||
// || NSString value description ||           value              ||
//

- (void)handleReceivedDataWithNotification:(NSNotification *)notification {
    
    // Get the user info dictionary that was received along with the notification.
    NSDictionary *userInfoDict = [notification userInfo];
    
    NSDictionary *receivedData = [NSKeyedUnarchiver unarchiveObjectWithData:[userInfoDict objectForKey:@"data"]];
    
    // Keep the sender's peerID and get its display name.
    MCPeerID *senderPeerID = [userInfoDict objectForKey:@"peerID"];
    NSString *senderDisplayName = senderPeerID.displayName;
    
    if ([[receivedData valueForKey:@"content"] isEqualToString:@"Message"]) {
        
        // HERE I RECEIVE A MESSAGE ABOUT A NEW GAME
        
        NSString *alertMessage = [NSString stringWithFormat:@"%@ has started a new game.", senderDisplayName];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MusicQuiz"
                                                        message:alertMessage
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Done", nil];
        
        [alert show];
        
        // Indicate that a game is in progress.
        self.isGameRunning = YES;
        
        // Disable the Labels/Buttons
        if (!self.hasCreatedGame) {
            
            self.lblTimer.hidden = NO;
            self.lblNowPlayingSong.hidden = YES;
            self.lblSongArtist.hidden = YES;
            self.lblSongTitle.hidden = YES;
            self.lblTimer.hidden = NO;
            self.btnStartGame.hidden = YES;
            self.lblWhoStart.hidden = YES;
            
            for (UIButton *b in self.btnAnswers) {
                b.hidden = NO;
            }
        }
        
    } else if ([[receivedData valueForKey:@"content"] isEqualToString:@"Answers"]) {
        
        // HERE I RECEIVE THE ANSWERS FROM THE HOST
        
        int i = 0;
        for (NSString *s in [receivedData valueForKey:@"answers"]) {
            [self.btnAnswers[i] setTitle:s forState:UIControlStateNormal];
            i++;
        }
        i=0;
        
    } else if ([[receivedData valueForKey:@"content"] isEqualToString:@"UserAnswer"]) {
        
        // HERE I RECEIVE THE ANSWER FROM THE GUEST
        
            if (self.hasCreatedGame) {
                // GAME CREATOR
                [self.quiz checkAnswer:[receivedData valueForKey:@"answer"]];
            }
        
    } else if ([[receivedData valueForKey:@"content"] isEqualToString:@"MatchFinished"]) {
        
        // HERE I RECEIVE THE FINAL SCORE  (THE MATCH IS FINISHED)
        
        // I enable the button only to the player that was the guest (the player who answered the questions) and now has to do the host.
        self.btnStartGame.hidden = NO;
        self.isGameRunning = NO;
    
    } else if ([[receivedData valueForKey:@"content"] isEqualToString:@"Timer"]) {
        
        // HERE I RECEIVE THE SECONDS LEFT OF THE CURRENT QUESTION
        
        self.lblTimer.text = [receivedData valueForKey:@"seconds"];
    }
}

#pragma mark - IBAction Buttons Match

/**
 *  This method is called by the Host (the player who hosts the song to answer) when he chooses to host the songs
 *
 *  @param sender - The UIButton that was tapped
 */
-(void)startGame:(id)sender
{
    if (!self.isGameRunning) {
        
        if (self.appDelegate.multiplayerHandler.session.connectedPeers != nil) { // If there are players connected, start the game
            
            self.quiz = [[MusicQuiz alloc] initWithType:2 Score:20 QuestionDuration:30 NumberOfQuestion:4];
            [self.quiz startQuiz];
            self.quiz.delegate = self;
            
            self.lblTimer.hidden = NO;
            self.lblNowPlayingSong.hidden = NO;
            self.lblSongArtist.hidden = NO;
            self.lblSongTitle.hidden = NO;
            self.btnStartGame.hidden = YES;
            self.lblWhoStart.hidden = YES;
            
            // Send to the other players that the game has started
            NSMutableDictionary *dictNewGame = [NSMutableDictionary dictionary];
            dictNewGame[@"content"] = @"Message";
            dictNewGame[@"message"] = @"New Game";
            
            NSError *error;
            
            [self.appDelegate.multiplayerHandler.session sendData:[NSKeyedArchiver archivedDataWithRootObject:[dictNewGame copy]]
                                                  toPeers:self.appDelegate.multiplayerHandler.session.connectedPeers
                                                 withMode:MCSessionSendDataReliable
                                                    error:&error];
            
            // If any error occurs, just log it.
            // Otherwise set the following couple of flags to YES, indicating that the current player is the creator
            // of the game and a game is in progress.
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
                
            } else{
                self.hasCreatedGame = YES;
                self.isGameRunning = YES;
            }
        }
        
        // GAME CREATER
        if (self.hasCreatedGame) {
            // The Game Creator doesn't have the button for the answers, so they are hide.
            for (UIButton *b in self.btnAnswers) {
                b.hidden = YES;
            }
        }
    }
}

/**
 *  This method is called when the Guest (the player who has to answer the questions) tap on the answer button
 *
 *  @param sender - The UIButton that was tapped
 */
-(void)sendAnswer:(UIButton *)sender
{
    
    NSMutableDictionary *dictUserAnswer = [NSMutableDictionary dictionary];
    dictUserAnswer[@"content"] = @"UserAnswer";
    dictUserAnswer[@"answer"] = sender.currentTitle;
    
    // I Send the answer of a peer to all the peers (players).
    NSError *error;
    [self.appDelegate.multiplayerHandler.session sendData:[NSKeyedArchiver archivedDataWithRootObject:dictUserAnswer]
                                          toPeers:self.appDelegate.multiplayerHandler.session.connectedPeers
                                         withMode:MCSessionSendDataReliable
                                            error:&error];
    
    // If any error occurs just log its description.
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }

}

#pragma mark - MusizQuiz Delegate Methods

-(void)correctAnsw
{
    NSLog(@"Correct Answer!");
}

-(void)playingRound:(int)round WithSongs:(NSArray *)songs
{
    self.lblSongArtist.text = [self.quiz.musicPlayer.nowPlayingItem valueForProperty:MPMediaItemPropertyArtist];
    self.lblSongTitle.text = [self.quiz.musicPlayer.nowPlayingItem valueForProperty:MPMediaItemPropertyTitle];
    //self.imgSongCover.image = [self.quiz.musicPlayer.nowPlayingItem valueForProperty:MPMediaItemPropertyArtwork];
    
    MPMediaItemArtwork *artWork = [self.quiz.musicPlayer.nowPlayingItem valueForProperty:MPMediaItemPropertyArtwork];
    if (artWork != nil) {
        self.imgSongCover.image = [artWork imageWithSize:CGSizeMake(150, 150)];
    }else{
        self.imgSongCover.image = [UIImage imageNamed:@"no-cover"];
    }
    
    // I Send to all the peers the 4 possible answers of the current question
    NSMutableDictionary *dictQuestionAnswers = [NSMutableDictionary dictionary];
    dictQuestionAnswers[@"content"] = @"Answers";
    dictQuestionAnswers[@"answers"] = songs;
    
    [self.appDelegate.multiplayerHandler.session sendData:[NSKeyedArchiver archivedDataWithRootObject:[dictQuestionAnswers copy]]
                                          toPeers:self.appDelegate.multiplayerHandler.session.connectedPeers
                                         withMode:MCSessionSendDataReliable
                                            error:nil];
}

-(void)wrongAnsw
{
    NSLog(@"Wrong Answer!");

}

-(void)matchFinished:(int)numOfAnswers WithScore:(int)totalScore
{
    NSLog(@"Match Finished!");
    self.isGameRunning = NO;
    self.quiz = nil;
    self.btnBack.hidden = NO;
    
    //self.btnStartGame.hidden = NO;
    
    NSMutableDictionary *dictMatchFinished = [NSMutableDictionary dictionary];
    dictMatchFinished[@"content"] = @"MatchFinished";
    dictMatchFinished[@"score"] = [NSString stringWithFormat:@"%d", totalScore];
    
    [self.appDelegate.multiplayerHandler.session sendData:[NSKeyedArchiver archivedDataWithRootObject:[dictMatchFinished copy]]
                                                      toPeers:self.appDelegate.multiplayerHandler.session.connectedPeers
                                                     withMode:MCSessionSendDataReliable
                                                        error:nil];
}

-(void)updateTimer
{
    self.lblTimer.text = [NSString stringWithFormat:@"%d", self.quiz.timeTick];
    
    NSMutableDictionary *dictTimer = [NSMutableDictionary dictionary];
    dictTimer[@"content"] = @"Timer";
    dictTimer[@"seconds"] = [NSString stringWithFormat:@"%d", self.quiz.timeTick];
    
    [self.appDelegate.multiplayerHandler.session sendData:[NSKeyedArchiver archivedDataWithRootObject:[dictTimer copy]]
                                                  toPeers:self.appDelegate.multiplayerHandler.session.connectedPeers
                                                 withMode:MCSessionSendDataReliable
                                                    error:nil];
}

- (IBAction)goBackToMultiplayerOptions:(id)sender
{
    NSArray *viewControllers = [[self navigationController] viewControllers];
    
    for( int i=0;i<[viewControllers count];i++){
        id obj=[viewControllers objectAtIndex:i];
        if([obj isKindOfClass:[MultiplayerOptionsViewController class]]){
            [[self navigationController] popToViewController:obj animated:YES];
            return;
        }
    }
}
@end
