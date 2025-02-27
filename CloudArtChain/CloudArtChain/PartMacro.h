//
//  PartMacro.h
//  CloudArtChain
//
//  Created by 朱彬 on 2020/8/24.
//  Copyright © 2020 朱彬. All rights reserved.
//

#ifndef PartMacro_h
#define PartMacro_h

#define PRINT_LOG  1  //控制打印

//定义开发环境
#define KF 0 //开发环境
#define OL 1  //线上环境
#define ENV KF  //选取环境

//状态栏高度
#define KStatus_Bar_Height [[UIApplication sharedApplication] statusBarFrame].size.height
//全屏宽
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
//全屏高
#define kScreenHeight ([[UIScreen mainScreen] bounds].size.height)
//状态栏+导航栏高度
#define KStatusBar_Navigation_Height ((KStatus_Bar_Height) + 44.0f)
//导航栏高度
#define KNavigation_Height (44.0f)
//TABBAR高度
#define KTabBar_Height ([[UIApplication sharedApplication] statusBarFrame].size.height > 20.0f ? 83.0f : 49.0f)
//如果有响应事件的话  需要加上34（安全区域高度）
#define KTouch_Responder_Height ([[UIApplication sharedApplication] statusBarFrame].size.height > 20.0f ? 34.0f : 0.0f)

//宽系数
#define KwidthScale(length) ([UIScreen mainScreen].bounds.size.width / 375.0f * length)

//关键窗口
#define KMainWindow [UIApplication sharedApplication].keyWindow

#define KToastDismissDelayTimeInterval 1.5f

#endif /* PartMacro_h */
