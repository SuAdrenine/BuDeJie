//
//  XBYSeeBigPictureViewController.m
//  BuDeJie
//
//  Created by xby on 2017/7/5.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "XBYSeeBigPictureViewController.h"
#import "XBYTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import <Photos/Photos.h>
#import <Masonry.h>

@interface XBYSeeBigPictureViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation XBYSeeBigPictureViewController

static NSString * const XBYAssetCollectionName = @"BuDeJie";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.saveBtn];
    
//    [self.backBtn sizeToFit];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(15);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
//    [self.saveBtn sizeToFit];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-15);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(60, 24));
    }];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    //插入到第一个
    [self.view insertSubview:scrollView atIndex:0];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_topicModel.image0]];
    [scrollView addSubview:imageView];
    imageView.XBY_W = scrollView.XBY_W;
    imageView.XBY_H = self.topicModel.height * imageView.XBY_W / self.topicModel.width;
    imageView.XBY_X = 0;
    //如果图片尺寸超出全屏
    if (imageView.XBY_H >= scrollView.XBY_H) {
        imageView.XBY_Y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.XBY_H);
    } else {    //图片大小不超全屏，让他居中
        imageView.XBY_centerY = scrollView.XBY_H * 0.5;
    }
    
    self.imageView = imageView;
    
    //缩放比例
    CGFloat scale = self.topicModel.width / imageView.XBY_W;
    if (scale > 1.0) {
        scrollView.maximumZoomScale =scale;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate
/**
 返回一个scrollView的子控件进行缩放

 @param scrollView <#scrollView description#>
 @return <#return value description#>
 */
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

/**
 按钮点击事件

 @param button <#button description#>
 */
-(void)clickAction:(UIButton *)button {
    NSInteger tag = [button tag];
    switch (tag) {
        case 1001: {
            [self back];
        }
            break;
        case 1002: {
            [self save];
        }
            break;
        default:
            break;
    }
}

/**
 返回
 */
-(void)back {
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 保存图片
 */
-(void)save {
    /*
     PHAuthorizationStatusNotDetermined,     用户还没有做出选择
     PHAuthorizationStatusDenied,            用户拒绝当前应用访问相册(用户当初点击了"不允许")
     PHAuthorizationStatusAuthorized         用户允许当前应用访问相册(用户当初点击了"好")
     PHAuthorizationStatusRestricted,        因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
     */
    
    //判断授权状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted) {    //因为家长控制，导致应用无法获取相册（跟用户的选择没有关系）
        [SVProgressHUD showErrorWithStatus:@"因为系统原因，无法访问相册"];
    } else if(status == PHAuthorizationStatusDenied) {  //用户拒绝当前应用访问相册（用户点击了“不允许”）
        XBYLog(@"提醒用户去[设置-隐私-照片-xxx]打开访问开关");
    } else if(status == PHAuthorizationStatusAuthorized) {  //用户允许当前应用访问相册(用户点击了"好")
        [self saveImage];
    } else if(status == PHAuthorizationStatusNotDetermined) {   // 用户还没有做出选择
        //弹框请求用户授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                //用户点击了好
                [self saveImage];
            }
        }];
    }
}

/**
 保存图片
 */
-(void)saveImage {
    // PHAsset : 一个资源，比如一张图片/一段视频
    // PHAssetCollection : 一个相簿
    // PHAsset的标识，利用这个标识可以找到对应的PHAsset对象(图片对象)
    __block NSString *assetLocalIdentifier = nil;
    
    // 如果相对“相册”进行修改（增删改），那么修改代码必须放在[PHPhotoLibrary sharedPhotoLibrary]的performChanges方法的block中
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //1、保存图片A到“相机胶卷”中
        //创建图片的请求
        assetLocalIdentifier = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success == NO) {
            [self showError:@"图片保存失败!"];
            return ;
        }
        
        //2、获得相簿
        PHAssetCollection *createdAssetCollection = [self createdAssetCollection];
        if (createdAssetCollection == nil) {
            [self showError:@"创建相簿失败！"];
            return ;
        }
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            //3 添加“相机胶卷”中的图片A到“相簿”D中
            //获得图片
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil].lastObject;
            
            //添加图片到相簿中的请求
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];
            
            //添加图片到相簿
            [request addAssets:@[asset]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success == NO) {
                [self showError:@"保存图片失败！"];
            } else {
                [self showSuccess:@"保存图片成功！"];
            }
        }];
        
    }];
}

/**
 活的相簿

 @return <#return value description#>
 */
-(PHAssetCollection *)createdAssetCollection {
    //从已存在的相簿中查找这个应用对应的相簿
    PHFetchResult <PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:XBYAssetCollectionName]) {
            return assetCollection;
        }
    }
    
    //没有找到对应的相簿，得创建新的相簿
    //错误信息
    NSError *error = nil;
    // PHAssetCollection的标识，利用这个标识可以找到对应的PHAssetCollection的对象（相簿对象）
    __block NSString *assetCollectionLocalIdentifier = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        //创建相簿的请求
        assetCollectionLocalIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:XBYAssetCollectionName].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    //如果有错误信息
    if(error) return nil;
    
    //获得刚创建的相簿
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionLocalIdentifier] options:nil].lastObject;
}

- (void)showSuccess:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:text];
    });
}

- (void)showError:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showErrorWithStatus:text];
    });
}

ButtonGetterWithCode(backBtn, [UIColor whiteColor], [UIFont systemFontOfSize:13], [UIImage imageNamed:@"show_image_back_icon"], 0,_backBtn.tag = 1001;
                     [_backBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];)
ButtonGetterWithCode(saveBtn, [UIColor whiteColor], [UIFont systemFontOfSize:13], nil, 0, _saveBtn.tag = 1002;
                     [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
                     [_saveBtn setBackgroundColor:ColorFromRGB(XBYGray)];
                     [_saveBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside])

@end
