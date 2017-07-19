//
//  XBYTopicImage.m
//  BuDeJie
//
//  Created by xby on 2017/7/5.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "XBYTopicImage.h"
#import <UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>
#import "XBYTopic.h"
#import "XBYSeeBigPictureViewController.h"

@interface XBYTopicImage()

@property (nonatomic, strong) UIImageView *picture;
@property (nonatomic, strong) UIImageView *isgifImage;
@property (nonatomic, strong) DALabeledCircularProgressView *progressView;
@property (nonatomic, strong) UIButton *seeBigImageBtn;

@end

@implementation XBYTopicImage

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingNone;
        //进度条的一些设置
        self.progressView.roundedCorners = 5;
        self.progressView.progressLabel.textColor = [UIColor grayColor];
        self.progressView.trackTintColor = [UIColor grayColor];
        
        //给图片添加手势查看大图
        self.picture.userInteractionEnabled = YES;
        [self.picture addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
    }
    
    return self;
}

-(void)setTopicModel:(XBYTopic *)topicModel {
    _topicModel = topicModel;
    [self.picture sd_setImageWithURL:[NSURL URLWithString:topicModel.image0]  placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        
        self.progressView.progress = progress;
        self.progressView.hidden = NO;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.progressView.hidden = YES;
    }];

    //动态图
    self.isgifImage.hidden = !topicModel.is_gif;
    
    // 查看大图
    if (topicModel.is_big) {
        self.picture.contentMode = UIViewContentModeTop;
        self.picture.clipsToBounds = YES;
        self.seeBigImageBtn.hidden = NO;
    }else {
        self.picture.contentMode = UIViewContentModeScaleAspectFill;
        self.picture.clipsToBounds = NO;
        self.seeBigImageBtn.hidden = YES;
    }
    
}


//点击查看大图按钮
-(void)clickAction:(UIButton *)button {
    [self seeBigPicture];
}

//点击图片查看大图
-(void)seeBigPicture {
    XBYSeeBigPictureViewController *seeBigPictureVC = [[XBYSeeBigPictureViewController alloc] init];
    seeBigPictureVC.topicModel = self.topicModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBigPictureVC animated:YES completion:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
