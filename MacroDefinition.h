//
//  MacroDefinition.h
//  LearningYYDemo
//
//  Created by starz on 2017/12/6.
//  Copyright © 2017年 starz. All rights reserved.
//

#ifndef MacroDefinition_h
#define MacroDefinition_h

#endif /* MacroDefinition_h */


#define SCREEN_WIDTH                                  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT                                 ([UIScreen mainScreen].bounds.size.height)


// iPhone X
#define  IsiPhoneX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)
// Status bar height.
#define  X_StatusBarHeight      (IsiPhoneX ? 44.f : 20.f)
// Navigation bar height.
#define  X_NavigationBarHeight  44.f
// Tabbar height.
#define  X_TabbarHeight         (IsiPhoneX ? (49.f+34.f) : 49.f)
// Tabbar safe bottom margin.
#define  X_TabbarSafeBottomMargin         (IsiPhoneX ? 34.f : 0.f)
// Status bar & navigation bar height.
#define  kStatusAndNavHeight  (IsiPhoneX ? 88.f : 64.f)
