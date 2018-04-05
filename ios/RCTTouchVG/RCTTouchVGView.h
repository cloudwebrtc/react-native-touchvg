//
//  RCTTouchVGViewManager.h
//  RCTTouchVG
//
//  Created by 维伟段 on 2018/4/3.
//  Copyright © 2018年 维伟段. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTViewManager.h>

@class TouchVGView;
@interface RCTTouchVGView : RCTViewManager
@property(nonatomic, strong)  TouchVGView  *vgview;
@end
