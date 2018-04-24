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

    setLineColor(r,g,b, a){
        NativeModules.TouchVGView.setLineColor(r,g,b,a);
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

    snapshot(){
        return new Promise((pResolve, pReject) => {
            NativeModules.TouchVGView.snapshot().then((response) =>{
                //console.log("img: " + JSON.stringify(response));
                pResolve(response);
            });
        });
    }

    render() {
        return <RCTTouchVGView {...this.props} />;
    }
}
/**
常用命令:
select: 选择
erase: 橡皮擦
rect: 矩形
square: 正方形
ellipse: 椭圆
circle2p: 圆
circle3p: 三点画圆
diamond: 菱形
line: 线段
rayline: 射线
beeline: 无穷直线
dot: 点
polygon: 多边形
quadrangle: 四边形
lines: 折线
splines: 随手画曲线
spline_mouse: 样条曲线
triangle: 三角形
parallel: 平行四边形
grid: 网格
arc3p: 三点圆弧
arc_cse: 圆心圆弧
arc_tan: 切线圆弧
 */
TouchVGView.propTypes = {
    command: PropTypes.string, /** 命令 */
    lineWidth: PropTypes.number,/** 线宽 */
    strokeWidth: PropTypes.number, /** 线宽 */
    backgroundImage: PropTypes.string,
};

export default TouchVGView;