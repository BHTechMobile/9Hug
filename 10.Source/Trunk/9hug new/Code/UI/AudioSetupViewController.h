//
//  AudioSetupViewController.h
//  9hug
//
//  Created by Tommy on 8/2/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "AudioRangerSelectorView.h"
#import "PlayerView.h"
#import "MixEngine.h"
#import "VolumeView.h"

@class AudioSetupViewController;
@protocol AudioSetupViewControllerDelegate <NSObject>

-(void)audioSetupViewControllerDidCancel;
-(void)audioSetupViewController:(AudioSetupViewController*)setupViewController didMixVideoUrl:(NSURL*)mixUrl;

@end

@interface AudioSetupViewController : UIViewController<MPMediaPickerControllerDelegate,AudioRangerSelectorViewDelegate,VolumeViewDelegate>

@property(nonatomic,weak)id<AudioSetupViewControllerDelegate>delegate;

@property(nonatomic,strong) MPMediaItem* audioItem;
@property(nonatomic,strong) NSURL* capturePath;
@property (weak, nonatomic) IBOutlet UIView *groupView;

@property(nonatomic, strong) AudioRangerSelectorView* rangeSelectorView;
@property(nonatomic, strong) PlayerView* videoPlayer;
@property(nonatomic, strong) NSURL* exportUrl;
@property(nonatomic, strong) VolumeView* audioVolume;
@property(nonatomic, strong) VolumeView* videoVolume;

@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (weak, nonatomic) IBOutlet UILabel *songNamelabel;
@property (weak, nonatomic) IBOutlet UIButton *mixButtonTapped;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

- (IBAction)doneButtonTapped:(id)sender;
- (IBAction)addMusicButtonTapped:(id)sender;
- (IBAction)mixButtonTapped:(id)sender;
- (IBAction)cancelButtonTapped:(id)sender;
@end
