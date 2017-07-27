//
//  Config.h
//  ZhiFeiUser
//
//  Created by 307A on 2016/12/22.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#ifndef Config_h
#define Config_h

// Vendor Keys

// Macro
#define WS(weakself) __weak __typeof(&*self) weakself = self
#define SCREEN_WIDTH (([UIScreen mainScreen].bounds.size.width < [UIScreen mainScreen].bounds.size.height)?[UIScreen mainScreen].bounds.size.width:[UIScreen mainScreen].bounds.size.height)
#define SCREEN_HEIGHT (([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height)?[UIScreen mainScreen].bounds.size.width:[UIScreen mainScreen].bounds.size.height)

//Notification

// Color
static NSString * const kKDColorPrimaryGreen = @"#66BAB7";               // navigation bar blue
static NSString * const kKDColorButtonRed = @"#fe0202";                 // red color (warning)
static NSString * const kKDColorTextRed = @"#fe0202";                   // red color (selected)
static NSString * const kKDColorTextGrayLight = @"#666666";             // gray color

static NSString * const kKDColorTextGray = @"#999999";                  // gray color
static NSString * const kKDColorBackgroundGrayLight = @"#f7f7f7";       // background light grey
static NSString * const kKDColorBackgroundGray = @"#edecec";            // background normal grey
static NSString * const kKDColorSeperatorGray = @"#d8d8d8";             // seperator gray
static NSString * const kKDColorBorderGray = @"#e6e6e6";                // border grey

static NSString * const kKDColorAccentOrange = @"#ffc107";               // accent orange


// Dimens
static const float kKDDimensOffsetEdge = 25.;                           // padding left/right
static const float kKDDimensOffsetTop = 30.;                            // padding left/right
static const float kKDDimensSpacingDefault = 10.;                       // space
static const float kKDDimensSpacingMedium = 15.;                        // cell space
static const float kKDDimensSpacingCell = 20.;                          // cell space
static const float kKDDimensSizeItem = 38.;                             // spinner or button height
static const float kKDDimensSizeInputView = 35.;                        // text field height
static const float kKDDimensCornerRadius = 5.;                          // corner radius
static const float kKDDimensSizeBottomView = 64.;                       // bottom view height
static const float kKDDimensSizeBottomButton = 54.;                     // bottom view height
static const float kKDDimensSizeButton = 44.;                           // bottom view height
static const float kKDDimensCellHeight = 54.;                           // cell height
static const float kKDDimensFloatButtonSize = 54.;                      // float button size

// Font Size
static const float kKDFontSizeMax = 25.;
static const float kKDFontSizeNavTitle = 20.;
static const float kKDFontSizePrimaryTitle = 18.;
static const float kKDFontSizeSecondaryTitle = 16.;
static const float kKDFontSizeThirdlyTitle = 14.;
static const float kKDFontSizeContent = 12.;


#endif /* Config_h */
