//
//  MusicQuestion.h
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 07/05/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MusicQuestion : NSObject

// TODO: Transform the "type" propery from int to enum (MQModeArtist, MQModeTitle, MQModeTitleArtist)

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSArray *answers;
@property (nonatomic)         int correctAnswer;
@property (nonatomic)         int score;

-(instancetype)initWithScore:(int)score type:(int)type correctAnswer:(int)correctA;

@end
