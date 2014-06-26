//
//  MusicQuiz.h
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 07/05/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MusicQuestion.h"

@protocol MusicQuizDelegate

/**
 *  Used to update the seconds label of the delegate class
 */
-(void) updateTimer;
/**
 *  Tells the delegate class that the user answer is right
 */
-(void) correctAnsw;
/**
 *  Tells the delegate class that the user answer is wrong
 */
-(void) wrongAnsw;
/**
 *  Tells the delegate class that the match is finished
 *
 *  @param numOfAnswers - number of question that the user answered
 *  @param totalScore   - the total score of the user
 */
-(void) matchFinished:(int) numOfAnswers WithScore:(int) totalScore;
/**
 *  Used to update the round and answers UI elements in the delegate class
 *
 *  @param round - current playing round
 *  @param songs - current answers
 */
-(void) playingRound:(int) round WithSongs:(NSArray*)songs;

@end

@interface MusicQuiz : NSObject

@property (nonatomic, strong)   NSMutableArray *questions; // of MusicQuestion
@property (nonatomic)           int type;
@property (nonatomic)           int score;
@property (nonatomic)           int questionDuration;
@property (nonatomic)           int numberOfQuestion;
@property (nonatomic)           int timeTick;
@property (nonatomic)           int totalScore;
@property (nonatomic, weak)     MPMediaItem *nowPlayingSong;
@property (nonatomic, retain)   MPMusicPlayerController *musicPlayer;
@property (nonatomic, weak)     id <MusicQuizDelegate> delegate;

-(instancetype)initWithType:(int)type Score:(int)score QuestionDuration:(int) duration NumberOfQuestion:(int)num;


-(void) startQuiz;
-(void) registerMediaPlayerNotifications;
-(void) checkAnswer:(NSString*)song;

@end
