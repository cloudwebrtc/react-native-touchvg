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
