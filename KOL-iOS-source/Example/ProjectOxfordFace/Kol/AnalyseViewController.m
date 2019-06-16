//
//  AnalyseViewController.m
//  KOLDemo
//
//  Created by Kelvin on 2019/6/16.
//  Copyright © 2019 angelhack. All rights reserved.
//

#import "AnalyseViewController.h"
#import "Constants.h"
#import "ProgressHUD/ProgressHUD.h"

#import "MPODetectionViewController.h"
#import "UIImage+FixOrientation.h"
#import "UIImage+Crop.h"
#import "ImageHelper.h"
#import "PersonFace.h"
#import <ProjectOxfordFace/MPOFaceServiceClient.h>
#import "MBProgressHUD.h"
#import "CommonUtil.h"
#import "MPODetectionCell.h"

@interface AnalyseViewController () <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *progress1;
@property (nonatomic, weak) UIView *progress2;
@property (nonatomic, weak) UIView *progress3;
@property (nonatomic, weak) UIView *progress4;
@property (nonatomic, weak) UIView *progress5;
@property (nonatomic, weak) UIView *progress6;
@property (nonatomic, weak) UIView *progress7;
@property (nonatomic, weak) UILabel *valueLb1;
@property (nonatomic, weak) UILabel *valueLb2;
@property (nonatomic, weak) UILabel *valueLb3;
@property (nonatomic, weak) UILabel *valueLb4;
@property (nonatomic, weak) UILabel *valueLb5;
@property (nonatomic, weak) UILabel *valueLb6;
@property (nonatomic, weak) UILabel *valueLb7;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, assign) CGFloat progressWidth;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, weak) UIImageView *imageIv;

@end

@implementation AnalyseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _titleArray = @[@"高兴", @"平静", @"惊讶", @"伤心", @"厌恶", @"愤怒", @"恐惧"];
    _progressWidth = 205;
    _selectedImage = [UIImage imageNamed:self.userModel.image];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(WIDTH, HEIGHT + 120);
    scrollView.scrollEnabled = YES;
    
    UIImageView *imageIv = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN, 0, WIDTH - 2 * MARGIN, 280)];
    [scrollView addSubview:imageIv];
    imageIv.image = [UIImage imageNamed:self.userModel.image];
    imageIv.contentMode =  UIViewContentModeScaleAspectFill;
    _imageIv = imageIv;
    
    CGFloat margin = 25;
    [self addEmotionItem:self.titleArray[0] :300 + margin * 1 :1];
    [self addEmotionItem:self.titleArray[1] :300 + margin * 2 :2];
    [self addEmotionItem:self.titleArray[2] :300 + margin * 3 :3];
    [self addEmotionItem:self.titleArray[3] :300 + margin * 4 :4];
    [self addEmotionItem:self.titleArray[4] :300 + margin * 5 :5];
    [self addEmotionItem:self.titleArray[5] :300 + margin * 6 :6];
    [self addEmotionItem:self.titleArray[6] :300 + margin * 7 :7];
    
    // detect again
    UIButton *detectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollView addSubview:detectBtn];
    detectBtn.frame = CGRectMake(WIDTH * 0.5 - 100, imageIv.bottom + margin * 9, 200, 40);
    [detectBtn setTitle:@"A new Detect..." forState:UIControlStateNormal];
    [detectBtn setBackgroundColor:[UIColor orangeColor]];
    detectBtn.layer.cornerRadius = 8;
    detectBtn.layer.masksToBounds = YES;
    [detectBtn addTarget:self action:@selector(chooseImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self detectAction];
}

- (void)chooseImage: (id)sender {
    UIActionSheet * choose_photo_sheet = [[UIActionSheet alloc]
                                          initWithTitle:@"Select Image"
                                          delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:@"Select from album", @"Take a photo",nil];
    [choose_photo_sheet showInView:self.scrollView];
}

- (void)addEmotionItem:(NSString *)title :(CGFloat)yPositon :(int)number {
    // 类型
    UILabel *typeLb = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN * 2, yPositon, 40, 15)];
    [self.scrollView addSubview:typeLb];
    typeLb.text = title;
    typeLb.font = MyFont(13);
    typeLb.textColor = UIColorFromRGB(0x828282);
    
    // 进度条背景
    UIView *progressBgView = [[UIView alloc] initWithFrame:CGRectMake(typeLb.right + MARGIN, yPositon + 4, _progressWidth, 8)];
    [self.scrollView addSubview:progressBgView];
    progressBgView.backgroundColor = UIColorFromRGB(0xc2c2c2);
    progressBgView.layer.cornerRadius = 4;
    progressBgView.layer.masksToBounds = YES;
    // 进度条
    UIView *progressView = [[UIView alloc] init];
    [self.scrollView addSubview:progressView];
    progressView.x = typeLb.right + MARGIN;
    progressView.y = yPositon + 4;
    progressView.width = 0;
    progressView.height = progressBgView.height;
    progressView.backgroundColor = [UIColor orangeColor];
    progressView.layer.cornerRadius = 4;
    progressView.layer.masksToBounds = YES;
    // 值
    UILabel *valueLb = [[UILabel alloc] initWithFrame:CGRectMake(progressBgView.right + 12, yPositon + 3, 40, 12)];
    [self.scrollView addSubview:valueLb];
    valueLb.text = @"0.0%";
    valueLb.font = MyFont(10);
    valueLb.textColor = [UIColor orangeColor];
    
    switch (number) {
        case 1:
            self.progress1 = progressView;
            self.valueLb1 = valueLb;
            break;
        case 2:
            self.progress2 = progressView;
            self.valueLb2 = valueLb;
            break;
        case 3:
            self.progress3 = progressView;
            self.valueLb3 = valueLb;
            break;
        case 4:
            self.progress4 = progressView;
            self.valueLb4 = valueLb;
            break;
        case 5:
            self.progress5 = progressView;
            self.valueLb5 = valueLb;
            break;
        case 6:
            self.progress6 = progressView;
            self.valueLb6 = valueLb;
            break;
        case 7:
            self.progress7 = progressView;
            self.valueLb7 = valueLb;
            break;
            
        default:
            break;
    }
}

- (void)detectAction {
    
    MPOFaceServiceClient *client = [[MPOFaceServiceClient alloc] initWithEndpointAndSubscriptionKey:ProjectOxfordFaceEndpoint key:ProjectOxfordFaceSubscriptionKey];
    
    NSData *data = UIImageJPEGRepresentation(self.selectedImage, 0.8);
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText = @"Detecting faces...";
    [HUD show: YES];
    
    [client detectWithData:data returnFaceId:YES returnFaceLandmarks:YES returnFaceAttributes:@[@(MPOFaceAttributeTypeGender), @(MPOFaceAttributeTypeAge), @(MPOFaceAttributeTypeHair), @(MPOFaceAttributeTypeFacialHair), @(MPOFaceAttributeTypeMakeup), @(MPOFaceAttributeTypeEmotion), @(MPOFaceAttributeTypeOcclusion), @(MPOFaceAttributeTypeExposure), @(MPOFaceAttributeTypeHeadPose), @(MPOFaceAttributeTypeAccessories)] completionBlock:^(NSArray<MPOFace *> *collection, NSError *error) {
        [HUD removeFromSuperview];
        if (error) {
            [CommonUtil showSimpleHUD:@"Detection failed!!!" forController:self.navigationController];
            return;
        }
       
        if (collection.count == 0) {
            [CommonUtil showSimpleHUD:@"No face detected." forController:self.navigationController];
        } else {
            MPOFace *face = collection[0];
            NSString *emotion = face.attributes.emotion.mostEmotion;
            double currentWidth = [face.attributes.emotion.mostEmotionValue doubleValue];
            NSLog(@"Detect result: %@", emotion);
            
            [self resetProgress];
            
            if ([@"happiness" isEqualToString:emotion]) {
                self.progress1.width = self.progressWidth * currentWidth;
                self.valueLb1.text = [NSString stringWithFormat:@"%@", face.attributes.emotion.mostEmotionValue];
            } else if ([@"neutral" isEqualToString:emotion]) {
                self.progress2.width = self.progressWidth * currentWidth;
                self.valueLb2.text = [NSString stringWithFormat:@"%@", face.attributes.emotion.mostEmotionValue];
            } else if ([@"surprise" isEqualToString:emotion]) {
                self.progress3.width = self.progressWidth * currentWidth;
                self.valueLb3.text = [NSString stringWithFormat:@"%@", face.attributes.emotion.mostEmotionValue];
            } else if ([@"sadness" isEqualToString:emotion]) {
                self.progress4.width = self.progressWidth * currentWidth;
                self.valueLb4.text = [NSString stringWithFormat:@"%@", face.attributes.emotion.mostEmotionValue];
            } else if ([@"disgust" isEqualToString:emotion]) {
                self.progress5.width = self.progressWidth * currentWidth;
                self.valueLb5.text = [NSString stringWithFormat:@"%@", face.attributes.emotion.mostEmotionValue];
            } else if ([@"anger" isEqualToString:emotion]) {
                self.progress6.width = self.progressWidth * currentWidth;
                self.valueLb6.text = [NSString stringWithFormat:@"%@", face.attributes.emotion.mostEmotionValue];
            } else if ([@"fear" isEqualToString:emotion]) {
                self.progress7.width = self.progressWidth * currentWidth;
                self.valueLb7.text = [NSString stringWithFormat:@"%@", face.attributes.emotion.mostEmotionValue];
            }
        }
    }];
}

- (void)resetProgress {
    self.progress1.width = 0;
    self.progress2.width = 0;
    self.progress3.width = 0;
    self.progress4.width = 0;
    self.progress5.width = 0;
    self.progress6.width = 0;
    self.progress7.width = 0;
    
    self.valueLb1.text = @"0.0%";
    self.valueLb2.text = @"0.0%";
    self.valueLb3.text = @"0.0%";
    self.valueLb4.text = @"0.0%";
    self.valueLb5.text = @"0.0%";
    self.valueLb6.text = @"0.0%";
    self.valueLb7.text = @"0.0%";
}

- (void)pickImage {
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    ipc.allowsEditing = YES;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)snapImage {
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    ipc.allowsEditing = YES;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self pickImage];
    } else if (buttonIndex == 1) {
        [self snapImage];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if (info[UIImagePickerControllerEditedImage])
        _selectedImage = info[UIImagePickerControllerEditedImage];
    else
        _selectedImage = info[UIImagePickerControllerOriginalImage];
    [_selectedImage fixOrientation];
    
    self.imageIv.image = _selectedImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self detectAction];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    NSDictionary *dict = [NSDictionary dictionaryWithObject:image forKey:@"UIImagePickerControllerOriginalImage"];
    [self imagePickerController:picker didFinishPickingMediaWithInfo:dict];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:nil message:@"Image written to photo album" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
    }else{
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Error writing to photo album: %@",[error localizedDescription]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
