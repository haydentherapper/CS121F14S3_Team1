//
//  BGKVCutsceneViewController.m
//  SecurityGame
//
//  Created by Josh Kutsko on 12/1/14.
//  Copyright (c) 2014 BGKV. All rights reserved.
//

#import "BGKVCutsceneViewController.h"
#import "BGKVCutsceneModel.h"
#import "BGKVLevelContainer.h"
#import "UIViewController+Unwind.h"

@interface BGKVCutsceneViewController ()

@end

@implementation BGKVCutsceneViewController {
    NSArray *_dialogue;
    NSUInteger _dialogueIndex;
}

- (instancetype)initWithLevel:(NSInteger)level
{
    self = [super init];
    if (self) {
        _dialogue = [BGKVCutsceneModel dialogueForLevel:level];
        if (!_dialogue) {
            return nil;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateDialogue];
}

- (IBAction)continueButton:(id)sender
{
    _dialogueIndex++;
    [self updateDialogue];
}

- (IBAction)goToNextLevel
{
    [self unwind:@selector(returnToLevelContainer:)];
}

- (void)updateDialogue
{
    BOOL talkerIsHacker = (_dialogueIndex % 2 == 0);
    
    self.hackerTextField.text = talkerIsHacker ? _dialogue[_dialogueIndex] : @"";
    self.hackerImage.hidden = !talkerIsHacker;
    self.hackerTextField.hidden = !talkerIsHacker;
    
    self.bossTextField.text = talkerIsHacker ? @"" : _dialogue[_dialogueIndex];
    self.bossImage.hidden = talkerIsHacker;
    self.bossTextField.hidden = talkerIsHacker;
    
    if (_dialogueIndex == [_dialogue count]-1) {
        self.continueButton.hidden = YES;
        self.playLevelButton.hidden = NO;
    }
}



@end