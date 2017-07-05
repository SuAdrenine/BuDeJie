//
//  XBYTopic.m
//  BuDeJie
//
//  Created by xby on 2017/7/5.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "XBYTopic.h"
#import "XBYComment.h"
#import <MJExtension.h>
#import "XBYUser.h"

@implementation XBYTopic

static NSDateFormatter *fmt_;
static NSCalendar *calendar_;

/**
 在第一次使用Topic类的时候调用一次
 */
+(void)initialize {
    fmt_ = [[NSDateFormatter alloc] init];
    calendar_ = [NSCalendar calendar];
}

-(NSString *)create_time {
    //获取发帖日期
    fmt_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createAdtDate = [fmt_ dateFromString:_create_time];
    
    if ([createAdtDate isThisYear]) {   //今年
        if ([createAdtDate isToday]) {  //今天
            //手机当前时间
            NSDate *nowDate = [NSDate date];
            NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            
            NSDateComponents *cmps = [calendar_ components:unit fromDate:createAdtDate toDate:nowDate options:0];
            
            if (cmps.hour >= 1) {   //时间间隔>=1小时
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            } else if(cmps.minute >=1) {    //1小时>时间间隔 >=1分钟
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            } else {    //1分钟>分钟
                return @"刚刚";
            }
        } else if(createAdtDate.isYesterday) {  //昨天
            fmt_.dateFormat = @"昨天 HH:mm:ss";
            return [fmt_ stringFromDate:createAdtDate];
        } else {    //其他
            fmt_.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt_ stringFromDate:createAdtDate];
        }
    } else {    //非今年
        return _create_time;
    }
}

-(CGFloat)cellHeight {
    //如果有值，返回，这样就不用每次都去计算每个cell的高度
    if(_cellHeight) return _cellHeight;
    
    //头像+上下间距
    _cellHeight = 56;
    //文字
    CGFloat textWidth = XBYkScreenWidth - 2*Margin;
    CGSize limitSize = CGSizeMake(textWidth, MAXFLOAT);
    CGSize textSize = [self.text boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    CGFloat textHeight = textSize.height + Margin;
    _cellHeight += textHeight;
    self.is_big = NO;   //记录是否需要隐藏点击查看大图
    //图片(视频，音频)
    if (self.type != TopicTypeWord) {
        CGFloat imageHeight = textWidth * self.height / self.width;
        if (imageHeight > XBYkScreenHeight) {
            imageHeight = 300;
            self.is_big = YES;
        }
        
        self.contentF = CGRectMake(Margin, _cellHeight, textWidth, imageHeight);
        _cellHeight += imageHeight + Margin;
    }
    //最热评论
    if (_top_cmt.count) {
        XBYComment *comment = self.top_cmt.firstObject;
        NSString *username = comment.user.username; //用户名
        NSString *content = comment.content;    //评论内容
        NSString *commentText = [NSString stringWithFormat:@"%@ : %@",username, content];
        _cellHeight += 18;
        
        CGSize commentSize = [commentText boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        CGFloat commentHeight = commentSize.height + Margin;
        _cellHeight += commentHeight;
    }
    
    _cellHeight += 35 +5 + XBYMargin;
    
    return _cellHeight;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

+(NSDictionary *)mj_objectClassInArray {
    return @{@"top_cmt":[XBYComment class]};
}

@end
