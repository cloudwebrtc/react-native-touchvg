import React, { Component } from 'react';
import { requireNativeComponent, NativeModules } from 'react-native';
import PropTypes from 'prop-types';

var RCTTouchVGView = requireNativeComponent('RCTTouchVGView', null);

class TouchVGView extends Component {

    constructor(props) {
        super(props);
        this.state = {}
    }

    /**
     * 撤销
     */
    undo() {
        NativeModules.TouchVGView.undo();
    }

    /**
     * 重做
     */
    redo() {
        NativeModules.TouchVGView.redo();
    }

    /**
     * 检查是否可以撤销
     */
    canUndo() {
        return NativeModules.TouchVGView.canUndo();
    }

    /**
     * 检查是否可以重做
     */
    canRedo() {
        return NativeModules.TouchVGView.canRedo();
    }

    /**
     * 清空画布
     */
    eraseView(){
        NativeModules.TouchVGView.eraseView();
    }

    /**
     * 设置背景图片
     */
    setBackground(filename) {
        NativeModules.TouchVGView.setBackground(filename);
    }

    render() {
        return <RCTTouchVGView {...this.props} />;
    }
}
/**
 * 常用命令:
 * 1: select 选中笔迹， 2: erase 擦除控件，3: rect  矩形，4: square 正方形
 * 5: ellipse 圆或椭圆，6: circle2p，7: circle3p，8: diamond，9: line 直线
 * 10: rayline，11: beeline，2: dot 画点，13: polygon，14: quadrangle
 * 15: lines 直线，16: freelines，17: splines 自由画线，18: spline_mouse
 * 19: triangle 三角形，20: parallel，21: grid，22: arc3p，23: arc_cse
 * 24: arc_tan，25: sector，26: compass
 */
TouchVGView.propTypes = {
    command: PropTypes.string, /** 命令 */
    lineWidth: PropTypes.number,/** 线宽 */
    lineColor: PropTypes.number, /** 颜色 */
    strokeWidth: PropTypes.number, /** 线宽 */
};

export default TouchVGView;