//
//  CommonMacro.h
//  BuDeJie
//
//  Created by xby on 2017/6/21.
//  Copyright © 2017年 xby. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h

#ifdef DEBUG
#define XBYLog(...) NSLog(__VA_ARGS__)
#else
#define XBYLog(...)
#endif

#define XBYLogFunc XBYLog(@"%s",__func__);

/* 颜色 */
#define XBYARGBColor(a, r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define XBYColor(r, g, b) XBYARGBColor(255, (r), (g), (b))

#define XBYRandomColor XBYColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define XBYrayColor(v) XBYColor((v), (v), (v))
#define XBYCommonBgColor XBYrayColor(206)

/* View宽高 */
#define XBYSelfViewWidth self.view.bounds.size.width
#define XBYSelfViewHeight self.view.bounds.size.height

/* 屏幕有关 */
#define XBYkScreenWidth [UIScreen mainScreen].bounds.size.width
#define XBYkScreenHeight [UIScreen mainScreen].bounds.size.height

#define iPone6   ([UIScreen mainScreen].bounds.size.height == 667)
#define iPone6P   ([UIScreen mainScreen].bounds.size.height == 736)
#define iPone5   ([UIScreen mainScreen].bounds.size.height == 568)
#define iPone4  ([UIScreen mainScreen].bounds.size.height == 480)


#define XBYWrite(responseObject,filename) [responseObject writeToFile:[NSString stringWithFormat:@"/Users/XBY/Desktop/%@.plist",filename] atomically:YES];

#define LogController

#define ColorFromRGB(rgbValue) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00) >> 8))/255.0 blue:((float)((rgbValue) & 0xFF))/255.0 alpha:1.0]

#define XBYBlue 0x3285ff
#define XBYBlack 0x000000
#define XBYWhite 0xffffff
#define XBYYellow 0xffb43d
#define XBYOrange 0xfe771b
#define XBYGreen 0x29ca98
#define XBYLineColor 0xdadada

//亮白
#define XBYWhiteGray 0xf3f4f7
//亮灰
#define XBYHighlightGray 0xeeeeee
//浅灰
#define XBYLightGray 0x9a9a9a
//灰
#define XBYGray 0x5c5c5c
//深灰
#define XBYDeepGray 0x101010

#define LabelGetter(property,textAlignmentt,textColorr,fontt) LabelGetterWithCode(property,textAlignmentt,textColorr,fontt,{})

#define LabelGetterWithCode(property,textAlignmentt,textColorr,fontt,execCode) - (UILabel *)property {\
if (!_##property) {\
_##property = [UILabel new];\
if (textAlignmentt) { _##property.textAlignment = textAlignmentt;}\
_##property.textColor = textColorr;\
if (fontt) _##property.font = fontt;\
execCode;\
}\
return _##property;\
}

#define ImageViewGetter(property, imageName) - (UIImageView *)property {\
if (!_##property) {\
_##property = [UIImageView new];\
if (imageName.length) _##property.image = [UIImage imageNamed:imageName];\
}\
return _##property;\
}

#define ViewGetter(property, backgroundColorr) - (UIView *)property {\
if (!_##property) {\
_##property = [UIView new];\
_##property.backgroundColor = backgroundColorr;\
}\
return _##property;\
}

#define ButtonGetterWithCode(property, titleColor, fontt, backgroundImage, cornerRadiuss, execCode)  - (UIButton *)property {\
if (!_##property) {\
_##property = [UIButton buttonWithType:UIButtonTypeCustom];\
if(titleColor){[_##property setTitleColor:titleColor forState:UIControlStateNormal];}\
if(fontt){_##property.titleLabel.font = fontt;}\
if (backgroundImage) { [_##property setBackgroundImage:backgroundImage forState:UIControlStateNormal];}\
if (cornerRadiuss!=0) {_##property.layer.cornerRadius = cornerRadiuss;_##property.layer.masksToBounds = YES;}\
execCode;\
}\
return _##property;\
}

#define ButtonGetter(property, titleColor, fontt, backgroundImage, cornerRadiuss) ButtonGetterWithCode(property, titleColor, fontt, backgroundImage, cornerRadiuss, {})

#define ButtonWithImageGetter(property, imageName,execCode) - (UIButton *)property {\
if (!_##property) {\
_##property = [UIButton buttonWithType:UIButtonTypeCustom];\
if (imageName.length) [_##property setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];\
execCode;\
}\
return _##property;\
}

#define ButtonWithBackgroundColor(property, titleColor, backgroundColorr, fontt,  cornerRadiuss)  - (UIButton *)property {\
if (!_##property) {\
_##property = [UIButton buttonWithType:UIButtonTypeCustom];\
if(titleColor){[_##property setTitleColor:titleColor forState:UIControlStateNormal];}\
if(backgroundColorr){_##property.backgroundColor = backgroundColorr;}\
if(fontt){_##property.titleLabel.font = fontt;}\
if (cornerRadiuss!=0) {_##property.layer.cornerRadius = cornerRadiuss;_##property.layer.masksToBounds = YES;}\
}\
return _##property;\
}

#define PropertyGetter(property, propertyType) - (propertyType *)property {\
if (!_##property) {\
_##property = [propertyType new];\
}\
return _##property;\
}


#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenMaxHeight (MAX(kScreenWidth, kScreenHeight))
#define kScreenMinHeight (MIN(kScreenWidth, kScreenHeight))

#define kIsIpad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kIsIphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIsRetina ([[UIScreen mainScreen] scale] >= 2.0)

#define kIsIphone4OrLess (kIsIphone && kScreenMaxHeight < 568.0)
#define kIsIphone5 (kIsIphone && kScreenMaxHeight >= 568.0)
#define kIsIphone6 (kIsIphone && kScreenMaxHeight >= 667.0)
#define kIsIphone6p (kIsIphone && kScreenMaxHeight >= 736.0)

#define Height(height6p,Height6,Height5or4) (kIsIphone6p?height6p:\
(kIsIphone6?Height6:(kIsIphone5||kIsIphone4OrLess)?Height5or4:kIsIphone6p))
#define HeightAll(height6p,Height6,Height5,height4) (kIsIphone6p?height6p:\
(kIsIphone6?Height6:(kIsIphone5?Height5:(kIsIphone4OrLess?height4:height6p))))

#define CalcHeight(height) Height(height*1.1,height,height*0.9)
#define CalcFont(size) Height((size + 0.5),size,(size>=16?size-1:size-0.6))

#endif /* CommonMacro_h */
