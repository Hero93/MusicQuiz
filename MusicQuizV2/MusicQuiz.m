//
//  MusicQuiz.m
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 07/05/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import "MusicQuiz.h"

@implementation MusicQuiz {
    NSTimer *nextSongTimer;
    NSTimer *secondsTimer;
    MPMediaItem *currentItem;
    NSMutableArray *chosenSongsIndexes;
    int currentRound;
    int countAnsweredQuestion;                          // Used to check the number of answered question
    BOOL hasAnswerTheQuestion;                          // Flag used to check if the user answers the question
}
@synthesize questions;

int tmpFlag = 0;

#pragma mark - Initializers

-(instancetype)initWithType:(enum musicQuizMode)type CorrectAnswerScore:(int)cas IncorrectAnswerScore:(int)ias QuestionDuration:(int)duration NumberOfQuestion:(int)num
{
    
    self = [super init];
    
    if (self) {
        
        _musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
        [_musicPlayer setRepeatMode:MPMusicRepeatModeNone];
        [_musicPlayer setShuffleMode:MPMusicShuffleModeOff];
        _type = type;
        _incorrectAnswerScore = ias;
        _correctAnswerScore = cas;
        _questionDuration = duration;
        _numberOfQuestions = num;
        _timeTick = duration;
                
        self.questions = [[NSMutableArray alloc] init];
        
        for (int i=0; i<num; i++) {
            // I create n instances of "MusicQuestion"
            MusicQuestion *q = [[MusicQuestion alloc] initWithType:type correctAnswer:arc4random()%4 numberOfAnswers:4];
            [self.questions addObject:q];
        }
        
        [self registerMediaPlayerNotifications];
    }
    
    return self;
}

#pragma mark - Match Methods
/**
 *  This method begins the match
 */
-(void) startQuiz
{
        // Song chosen for the playing queue (the correctAnswer property of MusicQuestion tells you the chosen song)
        NSMutableArray *chosenSongs = [[NSMutableArray alloc] init];
        
        for (int i=0; i<self.numberOfQuestions; i++) {
            int tmp = [self.questions[i] correctAnswer];
            [chosenSongs addObject:[self.questions[i] answers][tmp]];
            //NSLog(@"Chosen Song: %@", [chosenSongs[i] valueForProperty:MPMediaItemPropertyTitle]);
        }
    
        // I create a songs queue of type "MPMediaItemCollection" with the MPMediaItem inside the "chosenSongs" array
        MPMediaItemCollection *songsQueue = [[MPMediaItemCollection alloc] initWithItems:chosenSongs];
        [_musicPlayer setQueueWithItemCollection:songsQueue];
        [_musicPlayer play];
    
        // This timer is called every second (it's used for the seconds label)
        secondsTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tick) userInfo:nil repeats:YES];
        // This timer is called after the end of the time associate with the song
        nextSongTimer = [NSTimer scheduledTimerWithTimeInterval:self.questionDuration target:self selector:@selector(next) userInfo:nil repeats:YES];
    
        hasAnswerTheQuestion = NO;
        currentRound = 1;
        countAnsweredQuestion = 0;
}

/**
 *  This method it's used to get an array of NSStrings with the TITLE of the MPMediaItem in the questions array
 *
 *  @param index - the index associated with the question number (e.g Question  number 1's index is 0)
 *
 *  @return - an NSArray of NSString cantaining the TITLE of the MPMediaItem in the question array
 */
-(NSMutableArray *)getQuestionTitlesInStringAtIndex:(int) index
{
    NSMutableArray *answInString = [[NSMutableArray alloc] init];
    
    if (self.questions) {
        
        for (int i=0; i<4; i++) {
            NSString *songTitle = [[self.questions[index] answers][i] valueForProperty:MPMediaItemPropertyTitle];
            [answInString addObject:songTitle];
        }
    }
    
    return answInString;
}

/**
 *  This method it's used to get an array of NSString with the ARTIST of the MPMediaItem in the questions array
 *
 *  @param index - the index associated with the question number
 *
 *  @return an NSArray of NSString cantaining the ARTIST of the MPMediaItem in the question array
 */
-(NSMutableArray *)getQuestionArtistInStringAtIndex:(int) index
{
    NSMutableArray *answInString = [[NSMutableArray alloc] init];
    
    if (self.questions) {
        
        // It has to be
        for (int i=0; i<4; i++) {
            NSString *songTitle = [[self.questions[index] answers][i] valueForProperty:MPMediaItemPropertyArtist];
            [answInString addObject:songTitle];
        }
    }
    
    return answInString;
}

/**
 *  Checks if the answer of the user is right or wrong
 *
 *  @param song - song to check
 */
-(void) checkAnswer:(NSString*)song
{
    // The user have answered the question
    hasAnswerTheQuestion = YES;
    
    switch (self.type)
    {
        // ARTIST
        case 1:
        {
            countAnsweredQuestion ++;
            if ([song  isEqualToString:[currentItem valueForProperty:MPMediaItemPropertyArtist]]) {
                
                [self answerBeforeTheEndTime];
                
                [self.delegate correctAnsw];
                self.totalScore = self.totalScore + 10;
            }
            else{
                [self answerBeforeTheEndTime];
                
                // Send to the delegate class the correct answer
                NSString *correctAnswer = [currentItem valueForProperty:MPMediaItemPropertyArtist];
                
                //[self.delegate wrongAnsw];
                [self.delegate wrongAnswerWithCorrectAnswer:correctAnswer];
                self.totalScore = self.totalScore - 1;
            }
            
        } break;
            
        // TITLE
        case 2:
            
        {
            countAnsweredQuestion ++;
            if ([song  isEqualToString:[currentItem valueForProperty:MPMediaItemPropertyTitle]]) {
                [self answerBeforeTheEndTime];
                
                [self.delegate correctAnsw];
                self.totalScore = self.totalScore + 10;
            }
            else{
                
                [self answerBeforeTheEndTime];
                
                // Send to the delegate class the correct answer
                NSString *correctAnswer = [currentItem valueForProperty:MPMediaItemPropertyTitle];
                
                [self.delegate wrongAnswerWithCorrectAnswer:correctAnswer];
                self.totalScore = self.totalScore - 1;
            }
        } break;
            
        // ARTIST & TITLE
        case 3:
        {
            int questionIndex = currentRound - 1;
            
            if (tmpFlag != 1) {
                if ([song isEqualToString:[currentItem valueForProperty:MPMediaItemPropertyArtist]]) {
                    
                    // If the user answers the artist correctly, it has to answer for the title too
                    // I send to the delegate class the titles of the songs
                    [self.delegate playingRound:currentRound WithSongs:[self getQuestionTitlesInStringAtIndex:questionIndex]];
                    // now that i sent the titles to the delegate class, I don't have to return in this area of code
                    // so I set "tmpFlag" to 1 and when the user answers the title I check the answer in another area of code,
                    // not here anymore. So I'm here only the user has to answer the correct artist of the song
                    tmpFlag = 1;
                }
            } else if ([song isEqualToString:[currentItem valueForProperty:MPMediaItemPropertyTitle]]) {
                // If I'm in here, the user has answers the artist correctly. So here I check the title
                countAnsweredQuestion ++;
                [self.delegate correctAnsw];
                [self answerBeforeTheEndTime];
                tmpFlag = 0;
                self.totalScore = self.totalScore + 10;
            } else {
                countAnsweredQuestion ++;
                
                // Send to the delegate class the correct answer
                NSString *correctAnswer = [currentItem valueForProperty:MPMediaItemPropertyTitle];
                
                [self.delegate wrongAnswerWithCorrectAnswer:correctAnswer];
                [self answerBeforeTheEndTime];
                tmpFlag = 0;
                self.totalScore = self.totalScore - 1;
            }
            
        } break;
        
        default:
            break;
    }
}

-(void) resetSecondsVariable
{
    self.timeTick = self.questionDuration;
}

-(void) answerBeforeTheEndTime
{
    [nextSongTimer invalidate];
    nextSongTimer = [NSTimer scheduledTimerWithTimeInterval:self.questionDuration target:self selector:@selector(next) userInfo:nil repeats:YES];
    [self next];
}


#pragma mark - Timer's Function
/**
 *  This method is called by the timer every second (It's used as a clock with only the seconds)
 */
-(void)tick
{
    self.timeTick--;
    [self.delegate updateTimer];
}

/**
 *  This method is called by the timer that manages the end of time of the question (questionDuration property)
 */
-(void)next
{
    if (!hasAnswerTheQuestion) {
        if (self.type == 1) {
            [self.delegate noAnswerWithCorrectAnswer:[currentItem valueForProperty:MPMediaItemPropertyArtist]];
        } else if (self.type == 2) {
            [self.delegate noAnswerWithCorrectAnswer:[currentItem valueForProperty:MPMediaItemPropertyTitle]];
        } else {
            [self.delegate noAnswerWithCorrectAnswer:[currentItem valueForProperty:MPMediaItemPropertyArtist]];
        }
    }
    
    hasAnswerTheQuestion = NO;
    currentRound ++;
    [self resetSecondsVariable];
    [self.musicPlayer skipToNextItem];
}

#pragma mark - Notification Music Player
// Here we register 3 observers for the media player notifications
-(void)registerMediaPlayerNotifications
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    // Use this to update the current media item information
    [notificationCenter addObserver:self selector:@selector(handle_NowPlayingItemChanged:) name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification object:self.musicPlayer];
    // Use this to know when the song is "playing", "paused" or "stopped"
    [notificationCenter addObserver:self selector:@selector(handle_PlaybackStateChanged:) name:MPMusicPlayerControllerPlaybackStateDidChangeNotification object:self.musicPlayer];
    
    [self.musicPlayer beginGeneratingPlaybackNotifications];
}

-(void) handle_NowPlayingItemChanged: (id) notification
{
    int questionIndex = currentRound - 1; // The question index starts from 0 while the round starts from 1
    currentItem = [self.musicPlayer nowPlayingItem];
    
    // I do this if clause 'cause the index for the "self.questions" array doesn't have to be greater
    // than the numberOfQuestion (because the array index starts from 0 while the rounds variable starts
    // from 1).
    
    if (questionIndex < self.numberOfQuestions) {
        if (self.type == 1) {
            // Artist
            [self.delegate playingRound:currentRound WithSongs:[self getQuestionArtistInStringAtIndex:questionIndex]];
        } else if (self.type == 2) {
            // Title
            [self.delegate playingRound:currentRound WithSongs:[self getQuestionTitlesInStringAtIndex:questionIndex]];
        } else if (self.type == 3) {
            // Artist & Title
            // Sarebbe carino una volta cliccato sull'artista inserire solo titoli di canzoni relativi all'artista
            // tanto da rendere difficile la scelta da parte del giocatore.
            [self.delegate playingRound:currentRound WithSongs:[self getQuestionArtistInStringAtIndex:questionIndex]];
        }
    }
}

// Here we check the state of the MusicPlayer
-(void) handle_PlaybackStateChanged: (id) notification
{
    MPMusicPlaybackState playbackstate = [self.musicPlayer playbackState];
    
    if (playbackstate == MPMusicPlaybackStatePaused) {
        // Song has been paused
    } else if (playbackstate == MPMusicPlaybackStatePlaying) {
        // Song is being playing
    } else if (playbackstate == MPMusicPlaybackStateStopped) {
        // The Song Queue is finished !
        [self.musicPlayer stop]; // Stop the musicPlayer
        
        [secondsTimer invalidate];
        secondsTimer = nil;
        
        // I have to turn off the timer because when I finished the match, the timer keeps sending msgs
        // and so the class remains allocated and sends msg to the Music Player (that is Singletone).
        [nextSongTimer invalidate];
        nextSongTimer = nil;
        
        [self.delegate matchFinished:countAnsweredQuestion WithScore:self.totalScore];
        
        //[self resetSecondsVariable];
    }
}

#pragma mark - Dealloc Method

-(void)dealloc {
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter removeObserver:self name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification object:self.musicPlayer];
    [notificationCenter removeObserver:self name:MPMusicPlayerControllerPlaybackStateDidChangeNotification object:self.musicPlayer];
    
    [self.musicPlayer endGeneratingPlaybackNotifications];
    
}

@end
