//
//  BGKVMusicPlayer.m
//  SecurityGame
//
//  Created by Hayden Blauzvern on 10/22/14.
//  Copyright (c) 2014 BGKV. All rights reserved.
//

#import "BGKVMusicPlayer.h"

@interface BGKVMusicPlayer () {
    BOOL _isPlaying;
    float _volume;
    BOOL _isMuted;
}
@end

@implementation BGKVMusicPlayer

+ (BGKVMusicPlayer*) sharedInstance
{
    // http://www.raywenderlich.com/46988/ios-design-patterns
    static BGKVMusicPlayer* _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[BGKVMusicPlayer alloc] init];
    });
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        // From StackOverflow on how to play music
        NSURL *musicFile = [[NSBundle mainBundle] URLForResource:@"spy_music"
                                                       withExtension:@"mp3"];
        self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile
                                                                          error:nil];
        self.backgroundMusic.numberOfLoops = -1;
        _isPlaying = false;
        
        // Set volume from user defaults
        _volume = 1 - [[NSUserDefaults standardUserDefaults] floatForKey:@"volumeLevel"];
        _isMuted = [[NSUserDefaults standardUserDefaults] boolForKey:@"muteMusic"];
    }
    
    return self;
}

- (void) play
{
    if (!_isPlaying) {
        [self.backgroundMusic play];
        [self.backgroundMusic setVolume:_volume];
        if (_isMuted) {
            [self mute];
        } else {
            [self unmute];
        }
        _isPlaying = true;
    }
}

- (void) setVolume:(float) vol
{
    _volume = vol;
    [self.backgroundMusic setVolume:vol];
}

- (void) mute
{
    [self.backgroundMusic setVolume:0];
}

- (void) unmute
{
    [self.backgroundMusic setVolume:_volume];
}

@end
