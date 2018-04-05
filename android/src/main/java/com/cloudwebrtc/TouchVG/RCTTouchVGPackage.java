package com.cloudwebrtc.TouchVG;

import com.facebook.react.ReactPackage;
import com.facebook.react.bridge.JavaScriptModule;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.uimanager.ViewManager;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import rhcad.touchvg.IViewHelper;
import rhcad.touchvg.ViewFactory;

/**
 * Created by weiweiduan on 2018/4/4.
 */

public class RCTTouchVGPackage implements ReactPackage {
    IViewHelper helper;
    TouchVGModule nativeModule;
    RCTTouchVGView nativeViewManager;


    public  RCTTouchVGPackage(){
        helper = ViewFactory.createHelper();
    }

    @Override
    public List<NativeModule> createNativeModules(ReactApplicationContext reactContext) {
        List<NativeModule> modules = new ArrayList<>();
        nativeModule = new TouchVGModule(reactContext, helper);
        modules.add(nativeModule);
        return modules;
    }

    // Deprecated RN 0.47
    public List<Class<? extends JavaScriptModule>> createJSModules() {
        return Collections.emptyList();
    }

    @Override
    public List<ViewManager> createViewManagers(ReactApplicationContext reactContext) {
        nativeViewManager = new RCTTouchVGView(helper);
        return Arrays.<ViewManager>asList(nativeViewManager);
    }
}
