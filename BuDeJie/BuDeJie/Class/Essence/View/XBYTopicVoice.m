//
//  XBYTopicVoice.m
//  BuDeJie
//
//  Created by xby on 2017/7/5.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "XBYTopicVoice.h"
#import "XBYTopic.h"
#import <UIImageView+WebCache.h>
#import "XBYTimeTool.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry.h>

@interface XBYTopicVoice ()

@property (nonatomic, strong) UIImageView *pictureImageView;
@property (nonatomic, strong) UILabel *playCountLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *playButton;

/**
 上一个按钮
 */
@property (nonatomic, strong) UIButton *lastPlayButton;

/**
 播放声音的播放器
 */
@property (nonatomic, strong) AVPlayer *player;

@end

@implementation XBYTopicVoice

static AVPlayer *player_;
static UIButton *lastPlayButton_;
static XBYTopic *lastTopic_;

-(instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingNone;
        [self setupSubViews];
        [self setupSubViewsLayout];
    }
    
    return self;
    
}

-(void)setupSubViews {
    [self addSubview:self.pictureImageView];
    [self addSubview:self.playCountLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.playButton];
}

-(void)setupSubViewsLayout {
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
//    [self.playButton sizeToFit];
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
//    [self.playCountLabel sizeToFit];
    [self.playCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(68, 24));
    }];
    
//    [self.timeLabel sizeToFit];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(45, 24));
    }];
}

-(void)setTopicModel:(XBYTopic *)topicModel {
    _topicModel = topicModel;
    //背景图
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.image1] placeholderImage:nil];
    //时间
    self.timeLabel.text = [XBYTimeTool getFormatTimeWithTimeInterval:topicModel.voicetime];
    //播放数量
    if (self.topicModel.playcount > 10000) {
        self.playCountLabel.text = [NSString stringWithFormat:@"%.1f万播放",self.topicModel.playcount/10000.0];
    } else {
        self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",self
                                    .topicModel.playcount];
    }
    //播放 or 暂停
    [self.playButton setImage:[UIImage imageNamed:topicModel.voicePlaying ? @"playButtonPause":@"playButtonPlay"] forState:UIControlStateNormal];
}

- (void)play:(UIButton *)playButton {
    //音频播放存在问题
    //    playButton.selected = !playButton.isSelected;
    //    lastPlayButton_.selected = !lastPlayButton_.isSelected;
    //    if (lastTopic_ != self.topicModel) {
    //        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.topicModel.voiceuri]];
    //
    //        [player_ replaceCurrentItemWithPlayerItem:playerItem];
    //        [player_ play];
    //        lastTopic_.voicePlaying = NO;
    //        self.topicModel.voicePlaying = YES;
    //
    //        [lastPlayButton_ setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
    //        [playButton setImage:[UIImage imageNamed:@"playButtonPause"] forState:UIControlStateNormal];
    //
    //    }else{
    //        if(lastTopic_.voicePlaying){
    //            [player_ pause];
    //            self.topicModel.voicePlaying = NO;
    //            [playButton setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
    //        }else{
    //            [player_ play];
    //            self.topicModel.voicePlaying = YES;
    //            [playButton setImage:[UIImage imageNamed:@"playButtonPause"] forState:UIControlStateNormal];
    //        }
    //    }
    //    lastTopic_ = self.topicModel;
    //    lastPlayButton_ = playButton;
    
}

-(UIButton *)playButton {
    if(!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
        [_playButton setBackgroundImage:[UIImage imageNamed:@"playButton"] forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _playButton;
}

ImageViewGetter(pictureImageView, @"")
LabelGetter(playCountLabel, NSTextAlignmentLeft, ColorFromRGB(XBYGray), [UIFont systemFontOfSize:CalcFont(13.5)])
LabelGetter(timeLabel, NSTextAlignmentRight, ColorFromRGB(XBYGray), [UIFont systemFontOfSize:CalcFont(13.5)])

@end
