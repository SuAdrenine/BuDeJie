//
//  XBYTopicVideo.m
//  BuDeJie
//
//  Created by xby on 2017/7/5.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "XBYTopicVideo.h"
#import <UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "XBYTopic.h"
#import "XBYTimeTool.h"
#import <Masonry.h>

@interface XBYTopicVideo ()

@property (nonatomic, strong) UIImageView *pictureImaView;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UILabel *playcountLB;
@property (nonatomic, strong) UILabel *timeLB;

@end

@implementation XBYTopicVideo

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingNone;
        
        [self setupSubViews];
        [self setupSubViewsLayout];
    }
    
    return self;
}

-(void)setupSubViews {
    [self addSubview:self.pictureImaView];
    [self addSubview:self.playcountLB];
    [self addSubview:self.timeLB];
    [self addSubview:self.playBtn];
}

-(void)setupSubViewsLayout {
    [self.pictureImaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
//    [self.playBtn sizeToFit];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
//    [self.playcountLB sizeToFit];
    [self.playcountLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(45, 24));
    }];
    
//    [self.timeLB sizeToFit];
    [self.timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(45, 24));
    }];
}

-(void)setTopicModel:(XBYTopic *)topicModel {
    _topicModel = topicModel;
    
    [self.pictureImaView sd_setImageWithURL:[NSURL URLWithString:topicModel.image1] placeholderImage:nil];
    self.timeLB.text = [XBYTimeTool getFormatTimeWithTimeInterval:topicModel.videotime];
    self.playcountLB.text = [NSString stringWithFormat:@"%zd播放",topicModel.playcount];
}

-(void)play:(UIButton *)button {
    //iOS9之前的做法
    //    MPMoviePlayerViewController *movieVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:self.topicModel.videouri]];
    //    [[UIApplication sharedApplication].keyWindow.rootViewController presentMoviePlayerViewControllerAnimated:movieVC];
}

-(UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"video-play"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _playBtn;
}

ImageViewGetter(pictureImaView, @"")
LabelGetter(playcountLB, NSTextAlignmentLeft, ColorFromRGB(XBYGray), [UIFont systemFontOfSize:CalcFont(13.5)])
LabelGetter(timeLB, NSTextAlignmentRight, ColorFromRGB(XBYGray), [UIFont systemFontOfSize:CalcFont(13.5)])
@end
