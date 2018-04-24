package com.cloudwebrtc.TouchVG;

import android.graphics.Bitmap;
import android.util.Base64;
import java.io.ByteArrayOutputStream;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.WritableMap;

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
    public void snapshot(Promise promise) {
        Bitmap image = this.helper.snapshot(false);
        ByteArrayOutputStream imageStream = new ByteArrayOutputStream();
        image.compress(Bitmap.CompressFormat.JPEG, 100, imageStream);
        WritableMap response = Arguments.createMap();
        response.putString("base64", Base64.encodeToString(imageStream.toByteArray(), Base64.DEFAULT));
        promise.resolve(response);
    }

    @ReactMethod
    public void redo() {
        this.helper.redo();
    }

    @ReactMethod
    public void eraseView() {
        this.helper.eraseView();
    }

    @ReactMethod
    public void setLineColor(int r, int g, int b, int a) {
        this.helper.setLineColor(r,g,b,a);
    }
}
