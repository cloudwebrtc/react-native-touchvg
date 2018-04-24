//
//  RCTTouchVGViewManager.m
//  RCTTouchVG
//
//  Created by 维伟段 on 2018/4/3.
//  Copyright © 2018年 维伟段. All rights reserved.
//

#import "RCTTouchVGView.h"
#import "TouchVG/include/GiPaintViewXIB.h"
#import "TouchVG/include/GiViewHelper.h"

@interface TouchVGView : UIView <GiPaintViewDelegate>
@property(nonatomic, strong)    GiPaintViewXIB  *paintView;
@property(nonatomic, readonly)  GiViewHelper    *helper;
@property(nonatomic, strong)  UIImageView  *backgroundImage;
@end

@implementation TouchVGView {
   
}

@synthesize paintView, helper;

-(id)init
{
    if(self = [super init]){
        if (!self.paintView) {
            self.paintView = [[GiPaintViewXIB alloc]initWithFrame:self.bounds];
            self.paintView.autoresizingMask = 0xFF;
            [self.paintView addDelegate:self];
            [self.paintView.helper startUndoRecord:[NSString stringWithFormat:@"%@%@",NSTemporaryDirectory(), @"undo"]];
            [self addSubview:self.paintView];
            
            self.backgroundImage= [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,480)];
            [self.backgroundImage setImage:[UIImage imageNamed:@"login.jpg"]];
            
            [self addSubview:self.backgroundImage];
            [self sendSubviewToBack:self.backgroundImage];
            [self bringSubviewToFront:self.paintView];
        }
    }
    return self;
}

- (GiViewHelper *)helper {
    return self.paintView.helper;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.paintView.frame = self.bounds;
    self.backgroundImage.frame = self.bounds;
    [self sendSubviewToBack:self.backgroundImage];
    [self bringSubviewToFront:self.paintView];
}

-(void)setBkImage:(UIImage *)image
{
    [self.backgroundImage setImage:image];
    [self layoutSubviews];
}

@end

@implementation RCTTouchVGView {
    
}

@synthesize vgview;

RCT_EXPORT_MODULE()

RCT_CUSTOM_VIEW_PROPERTY(command, NSString, TouchVGView)
{
    NSString *cmd = (NSString *)json;
    NSLog(@"TouchVGView.command( %@ )", cmd);
    view.helper.command = cmd;
}

RCT_CUSTOM_VIEW_PROPERTY(lineWidth, NSString, TouchVGView)
{
    NSString *cmd = (NSString *)json;
    view.helper.lineWidth = [cmd floatValue];
}

RCT_CUSTOM_VIEW_PROPERTY(strokeWidth, NSString, TouchVGView)
{
    NSString *cmd = (NSString *)json;
    view.helper.strokeWidth = [cmd floatValue];
}

RCT_REMAP_METHOD(snapshot,
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject){
    UIImage *img = [self.vgview.helper snapshot];
    NSMutableDictionary *response = [[NSMutableDictionary alloc] init];
    NSData *data = UIImageJPEGRepresentation(img, 0);
    response[@"base64"] = [data base64EncodedStringWithOptions:0];
    resolve(response);
}

RCT_REMAP_METHOD(setBackgroundImage,
                 withImage:(NSString *)base64_image)
{
    NSData *decodedImageData   = [[NSData alloc] initWithBase64Encoding:base64_image];
    UIImage *decodedImage      = [UIImage imageWithData:decodedImageData];
    [self.vgview setBkImage:decodedImage];
}

RCT_REMAP_METHOD(setLineColor,
                 withRed:(nonnull NSNumber *)r
                 green:(nonnull NSNumber *)g
                 blue:(nonnull NSNumber *)b
                 alpha:(nonnull NSNumber *)a )
{
    self.vgview.helper.lineColor = [UIColor colorWithRed:[r floatValue] / 255.0f
                                                   green:[g floatValue] / 255.0f
                                                    blue:[b floatValue] / 255.0f
                                                   alpha:[a floatValue] / 255.0f];
}

RCT_EXPORT_METHOD(canUndo){
    NSLog(@"TouchVGView.canUndo()");
    [self.vgview.helper canUndo];
}

RCT_EXPORT_METHOD(canRedo){
    NSLog(@"TouchVGView.canRedo()");
    [self.vgview.helper canRedo];
}

RCT_EXPORT_METHOD(redo){
    NSLog(@"TouchVGView.redo() %p", self);
    [self.vgview.helper redo];
}

RCT_EXPORT_METHOD(undo){
    NSLog(@"TouchVGView.undo() %p", self);
    [self.vgview.helper undo];
}

RCT_EXPORT_METHOD(eraseView){
    NSLog(@"TouchVGView.eraseView() %p", self);
    [self.vgview.helper eraseView];
}

- (instancetype)init
{
    if (self = [super init]) {
        NSLog(@"TouchVGView.init(): initialized %p", self);
    }
    return self;
}

- (UIView *)view {
    TouchVGView *v =  [[TouchVGView alloc] init];
    self.vgview = v;
    return v;
}

@end
