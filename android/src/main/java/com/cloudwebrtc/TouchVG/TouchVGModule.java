package com.cloudwebrtc.TouchVG;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import rhcad.touchvg.IViewHelper;
import rhcad.touchvg.view.internal.ResourceUtil;

/**
 * Created by weiweiduan on 2018/4/4.
 */

public class TouchVGModule extends ReactContextBaseJavaModule {
    static final String TAG = TouchVGModule.class.getCanonicalName();
    IViewHelper helper;

    public TouchVGModule(ReactApplicationContext reactContext, IViewHelper helper) {
        super(reactContext);
        ResourceUtil.setContextImages(reactContext);
        this.helper = helper;
    }

    @Override
    public String getName() {
        return "TouchVGView";
    }


    @ReactMethod
    public boolean canUndo() {
        return  this.helper.canUndo();
    }

    @ReactMethod
    public boolean canRedo() {
        return  this.helper.canRedo();
    }

    @ReactMethod
    public void undo() {
        this.helper.undo();
    }

    @ReactMethod
    public void redo() {
        this.helper.redo();
    }

    @ReactMethod
    public void eraseView() {
        this.helper.eraseView();
    }
}
