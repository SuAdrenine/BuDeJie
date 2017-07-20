//
//  XBYTopicCell.m
//  BuDeJie
//
//  Created by xby on 2017/7/5.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "XBYTopicCell.h"
#import "XBYTopic.h"
#import "XBYComment.h"
#import "XBYUser.h"
#import "XBYTopicImage.h"
#import "XBYTopicVideo.h"
#import "XBYTopicVoice.h"
#import <Masonry.h>

@interface XBYTopicCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLB;  //昵称
@property (nonatomic, strong) UILabel *timeLB;  //发布时间
@property (nonatomic, strong) UIButton *moreBtn;    //更多
@property (nonatomic, strong) UILabel *mainInfoLB;  //主信息
@property (nonatomic, strong) UIView *commentFatherView;//评论父控件
@property (nonatomic, strong) UILabel *commentTitleLB;  //评论
@property (nonatomic, strong) UILabel *commentLB;   //评论内容
@property (nonatomic, strong) UIView *toolsView;    //工具栏
@property (nonatomic, strong) UIButton *dingBtn;    //顶
@property (nonatomic, strong) UIButton *caiBtn;     //踩
@property (nonatomic, strong) UIButton *zhuanBtn;   //转
@property (nonatomic, strong) UIButton *commentBtn; //评论

@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) XBYTopicImage *topicImageView;
@property (nonatomic, strong) XBYTopicVoice *topicVoiceView;
@property (nonatomic, strong) XBYTopicVideo *topicVideoView;

@end

@implementation XBYTopicCell

-(void)setFrame:(CGRect)frame {
    frame.size.height -= XBYMargin;
    frame.origin.y += XBYMargin;
    [super setFrame:frame];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        [self setupSubViews];
        [self setupSubViewsLayout];
    }
    
    return self;
}

-(void)setupSubViews {
    [self.contentView addSubview:self.bgView];
    
    [self.bgView addSubview:self.headView];
    [self.bgView addSubview:self.mainInfoLB];
    [self.bgView addSubview:self.centerView];
    [self.bgView addSubview:self.commentFatherView];
    [self.bgView addSubview:self.toolsView];
    
    [self.headView addSubview:self.headImageView];
    [self.headView addSubview:self.nameLB];
    [self.headView addSubview:self.timeLB];
    [self.headView addSubview:self.moreBtn];

    [self.centerView addSubview:self.topicImageView];
    [self.centerView addSubview:self.topicVoiceView];
    [self.centerView addSubview:self.topicVideoView];
    
    [self.commentFatherView addSubview:self.commentTitleLB];
    [self.commentFatherView addSubview:self.commentLB];
    
    [self.toolsView addSubview:self.dingBtn];
    [self.toolsView addSubview:self.caiBtn];
    [self.toolsView addSubview:self.zhuanBtn];
    [self.toolsView addSubview:self.commentBtn];
    
    self.mainInfoLB.numberOfLines = 0;
    self.mainInfoLB.lineBreakMode = NSLineBreakByWordWrapping;
}

-(void)setupSubViewsLayout {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bgView);
        make.top.equalTo(self.bgView);
        make.height.mas_equalTo(49);
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.headView).offset(12);
        make.centerY.equalTo(self.headView);
//        make.size.mas_equalTo(CGSizeMake(45, 45));
        make.top.equalTo(self.headView).offset(2);
        make.bottom.equalTo(self.headView).offset(-2);
        make.width.mas_equalTo(self.headImageView.mas_height);
    }];
    
    [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(2);
        make.bottom.equalTo(self.headImageView.mas_centerY);
        make.right.equalTo(self.moreBtn.mas_left).offset(-5);
    }];
    
    [self.timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameLB);
        make.top.equalTo(self.nameLB.mas_bottom);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headView);
        make.right.equalTo(self.headView.mas_right).offset(-12);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    [self.mainInfoLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom).offset(12);
        make.left.right.equalTo(self.bgView);
//        make.height.mas_equalTo(20);
    }];
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bgView);
        make.top.equalTo(self.mainInfoLB.mas_bottom).offset(15);
        make.height.equalTo(@128);
    }];
    
    [self.topicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.centerView).insets(UIEdgeInsetsMake(2, 2, 2, 2));
    }];
    [self.topicVoiceView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(self.centerView).insets(UIEdgeInsetsMake(2, 2, 2, 2));
    }];

    [self.topicVideoView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(self.centerView).insets(UIEdgeInsetsMake(2, 2, 2, 2));
    }];

    [self.commentFatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerView.mas_bottom).offset(15);
        make.left.right.equalTo(self.bgView);
        make.height.mas_equalTo(68);
    }];
    
    [self.commentTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.commentFatherView);
        make.left.equalTo(self.commentFatherView).offset(5);
        make.height.equalTo(@34);
    }];
    
    [self.commentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.commentFatherView);
        make.top.equalTo(self.commentTitleLB.mas_bottom);
        make.left.right.equalTo(self.commentTitleLB);
        make.height.equalTo(@34);
    }];
    
    [self.toolsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commentFatherView.mas_bottom).offset(15);
        make.left.right.equalTo(self.bgView);
        make.height.mas_equalTo(35);
        make.bottom.equalTo(self.bgView).offset(-5);
    }];
    
    NSArray *array = @[self.dingBtn,self.caiBtn,self.zhuanBtn,self.commentBtn];
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                       withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.toolsView);
        make.top.bottom.equalTo(self.toolsView);
    }];
}

-(void)setTopicModel:(XBYTopic *)topicModel {
    _topicModel = topicModel;
    //头像
    [self.headImageView setHeader:topicModel.profile_image];
    //昵称
    self.nameLB.text = topicModel.name;
    //内容
    self.mainInfoLB.text = topicModel.text;
    //创建时间
    self.timeLB.text = topicModel.create_time;
    
    //中间内容
    if (topicModel.type == TopicTypePicture) {
        self.topicImageView.hidden = NO;
//        self.topicImageView.frame = topicModel.contentF;
        self.topicImageView.topicModel = topicModel;
        self.topicVideoView.hidden = YES;
        self.topicVoiceView.hidden = YES;
        CGFloat height = topicModel.contentF.size.height;
        [self.centerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
    } else if(topicModel.type == TopicTypeVoice) {
        self.topicVoiceView.hidden = NO;
//        self.topicVoiceView.frame = topicModel.contentF;
        self.topicVoiceView.topicModel = topicModel;
        self.topicImageView.hidden = YES;
        self.topicVideoView.hidden = YES;
        CGFloat height = topicModel.contentF.size.height;
        [self.centerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
    } else if (topicModel.type == TopicTypeVideo) {
        self.topicVideoView.hidden = NO;
//        self.topicVideoView.frame = topicModel.contentF;
        self.topicVideoView.topicModel = topicModel;
        self.topicImageView.hidden = YES;
        self.topicVoiceView.hidden = YES;
        CGFloat height = topicModel.contentF.size.height;
        [self.centerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
    } else if (topicModel.type == TopicTypeWord) {
        self.topicImageView.hidden = YES;
        self.topicVideoView.hidden = YES;
        self.topicVoiceView.hidden = YES;
        [self.centerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.0001);
        }];
    }
    
    //最新评论
    XBYComment *comment = topicModel.top_cmt.firstObject;
    if (comment) {  //有最新评论
        self.commentFatherView.hidden = NO;
        NSString *userName = comment.user.username; //用户名
        NSString *content = comment.content;    //评论内容
        self.commentLB.text = [NSString stringWithFormat:@"%@ : %@",userName, content];
    } else {    //没有最新评论
//        self.commentFatherView.hidden = YES;
        [self.commentFatherView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.0001);
        }];
        [self.toolsView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commentFatherView.mas_bottom).offset(2);
        }];
    }
    
    //工具条
    [self setTitle:topicModel.ding button:self.dingBtn placeHolder:@"顶"];
    [self setTitle:topicModel.hate button:self.caiBtn placeHolder:@"踩"];
    [self setTitle:topicModel.repost button:self.zhuanBtn placeHolder:@"转发"];
    [self setTitle:topicModel.comment button:self.commentBtn placeHolder: @"评论"];
    
//    CGSize constrainedSize = CGSizeMake(kScreenWidth, MAXFLOAT);
//    CGRect textRect = [self.mainInfoLB.text boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
//    CGFloat height = textRect.size.height;
//    CGFloat width = textRect.size.width;
//
//    [self.mainInfoLB mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.headView.mas_bottom);
//        make.left.right.equalTo(self.bgView);
//        make.height.mas_equalTo(height);
//    }];
}

//计算UILabel的高度(带有行间距的情况)
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode =NSLineBreakByCharWrapping;
    paraStyle.alignment =NSTextAlignmentLeft;
    paraStyle.lineSpacing = 0.5;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent =0.0;
    paraStyle.paragraphSpacingBefore =0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle,NSKernAttributeName:@1.5f
                         };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

- (void)setTitle:(NSString *)number button:(UIButton *)button placeHolder:(NSString *)placeHolder {
    NSInteger count = [number integerValue];
    if (count >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%ld万",count/10000] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%ld",count] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeHolder forState:UIControlStateNormal];
    }
}

-(void)moreBtnClick:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionOne = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *actionTwo = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:actionOne];
    [alertController addAction:actionTwo];
    [alertController addAction:cancel];
    
    [self.window.rootViewController presentViewController:alertController animated:YES completion:^{
        
    }];
}

-(XBYTopicImage *)topicImageView {
    if (!_topicImageView) {
        _topicImageView = [[XBYTopicImage alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_topicImageView];
    }
    
    return _topicImageView;
}

-(XBYTopicVoice *)topicVoiceView {
    if (!_topicVoiceView) {
        _topicVoiceView = [[XBYTopicVoice alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_topicVideoView];
    }
    return _topicVoiceView;
}

-(XBYTopicVideo *)topicVideoView {
    if (!_topicVideoView) {
        _topicVideoView = [[XBYTopicVideo alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_topicVideoView];
    }
    return _topicVideoView;
}

ViewGetter(bgView, [UIColor whiteColor])
ImageViewGetter(headImageView, @"")
ViewGetter(headView, [UIColor redColor])
ViewGetter(centerView, [UIColor greenColor])
LabelGetter(nameLB, NSTextAlignmentLeft, ColorFromRGB(XBYGray), [UIFont systemFontOfSize:CalcFont(13.5)])
LabelGetter(timeLB, NSTextAlignmentLeft, ColorFromRGB(XBYGray), [UIFont systemFontOfSize:CalcFont(13.5)])
ButtonGetterWithCode(moreBtn, [UIColor whiteColor], [UIFont systemFontOfSize:13.5], [UIImage imageNamed:@"cellmorebtnnormal"], 0, [_moreBtn  addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];)
LabelGetter(mainInfoLB, NSTextAlignmentLeft, ColorFromRGB(XBYBlack), [UIFont systemFontOfSize:CalcFont(15)])
ViewGetter(commentFatherView, [UIColor purpleColor])
LabelGetterWithCode(commentTitleLB, NSTextAlignmentLeft, ColorFromRGB(XBYBlack), [UIFont systemFontOfSize:CalcFont(14)],_commentTitleLB.text = @"最新评论";)
LabelGetter(commentLB, NSTextAlignmentLeft, ColorFromRGB(XBYGray), [UIFont systemFontOfSize:13.5])
ViewGetter(toolsView, [UIColor yellowColor])

-(UIButton *)dingBtn {
    if (!_dingBtn) {
        _dingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dingBtn setTitleColor:ColorFromRGB(XBYGray) forState:UIControlStateNormal];
        _dingBtn.titleLabel.font = [UIFont systemFontOfSize:CalcFont(12)];
        [_dingBtn setImage:[UIImage imageNamed:@"mainCellDing"] forState:UIControlStateNormal];
    }
    
    return _dingBtn;
}

-(UIButton *)caiBtn {
    if (!_caiBtn) {
        _caiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_caiBtn setTitleColor:ColorFromRGB(XBYGray) forState:UIControlStateNormal];
        _caiBtn.titleLabel.font = [UIFont systemFontOfSize:CalcFont(12)];
        [_caiBtn setImage:[UIImage imageNamed:@"mainCellCai"] forState:UIControlStateNormal];
    }
    
    return _caiBtn;
}
-(UIButton *)zhuanBtn {
    if (!_zhuanBtn) {
        _zhuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_zhuanBtn setTitleColor:ColorFromRGB(XBYGray) forState:UIControlStateNormal];
        _zhuanBtn.titleLabel.font = [UIFont systemFontOfSize:CalcFont(12)];
        [_zhuanBtn setImage:[UIImage imageNamed:@"mainCellShare"] forState:UIControlStateNormal];
    }
    
    return _zhuanBtn;
}
-(UIButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setTitleColor:ColorFromRGB(XBYGray) forState:UIControlStateNormal];
        _commentBtn.titleLabel.font = [UIFont systemFontOfSize:CalcFont(12)];
        [_commentBtn setImage:[UIImage imageNamed:@"mainCellComment"] forState:UIControlStateNormal];
    }
    
    return _commentBtn;
}


@end
