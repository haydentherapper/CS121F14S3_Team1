//
//  BGKVCutsceneViewController.h
//  SecurityGame
//
//  Created by Josh Kutsko on 12/1/14.
//  Copyright (c) 2014 BGKV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGKVCutsceneViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextView* hackerTextField;
@property (weak, nonatomic) IBOutlet UIButton* continueButton;
@property (weak, nonatomic) IBOutlet UIButton* playLevelButton;
@property (weak, nonatomic) IBOutlet UITextView* bossTextField;
@property (weak, nonatomic) IBOutlet UIImageView* bossImage;
@property (weak, nonatomic) IBOutlet UIImageView* hackerImage;
@property (nonatomic, assign) NSNumber* levelProperty;


- (instancetype)initWithLevel:(NSUInteger)level;

@end
