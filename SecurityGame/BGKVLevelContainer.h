//
//  BGKVLevelContainer.h
//  SecurityGame
//
//  Created by Guest User on 11/9/14.
//  Copyright (c) 2014 BGKV. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BGKVLevelViewController;
@class BGKVLevelViewControllerCache;

@interface BGKVLevelContainer : UIViewController

@property (nonatomic) NSString *initialSegueName;
@property (nonatomic) BGKVLevelViewControllerCache *cache;
@property (nonatomic, weak, readonly) BGKVLevelContainer *levelContainer;

@property (nonatomic, weak) BGKVLevelViewController *currentLevelVC;

@property (nonatomic, weak) IBOutlet UIView *levelView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *menuButton;
/*
@property (nonatomic, weak) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *inventoryButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *leftButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *rightButton;
 */

- (void)showLevelViewController:(BGKVLevelViewController *)newVC;

- (IBAction)menuButtonAction:(UIBarButtonItem *)sender;

@end