package com.cloudwebrtc.TouchVG;

/**
 * Created by weiweiduan on 2018/4/4.
 */

import com.facebook.react.uimanager.annotations.ReactProp;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;

import rhcad.touchvg.IViewHelper;

public class RCTTouchVGView extends SimpleViewManager<TouchVGView> {
    private static final String REACT_CLASS = "RCTTouchVGView";
    TouchVGView vgview;
    IViewHelper helper;

    RCTTouchVGView(IViewHelper helper){
        this.helper = helper;
    }


    @Override
    public String getName() {
        return REACT_CLASS;
    }

    @Override
    public TouchVGView createViewInstance(ThemedReactContext context) {
        vgview = new TouchVGView(context, helper);
        return vgview;
    }

    @ReactProp(name = "command")
    public void setCommand(TouchVGView view, String cmd) {
        view.helper().setCommand(cmd);
    }

    @ReactProp(name = "lineWidth")
    public void setLineWidth(TouchVGView view, int w) {
        view.helper().setLineWidth(w);
    }

    @ReactProp(name = "strokeWidth")
    public void setStrokeWidth(TouchVGView view, int w) {
        view.helper().setStrokeWidth(w);
    }

    @ReactProp(name = "lineColor")
    public void setLineColor(TouchVGView view, int c) {
        view.helper().setLineColor(c);
    }
}