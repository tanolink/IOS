//
//  ZNAppUtil.h
//  Zouni
//
//  Created by Aokuny on 14-9-16.
//  Copyright (c) 2015年 Zouni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JGProgressHUD+Add.h"
#import "NSDictionary+Uitls.h"
#import "UIColor+AppColor.h"
#import "ZNClientInfo.h"
#import "UIView+Addtions.h"
#import "UIImage-Helpers.h"
//#import <ShareSDK/ShareSDK.h>
#import "UIViewController+DismissKeyboard.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BaseTableView.h"
#import "MJRefresh.h"
#import <CoreData+MagicalRecord.h>
#import <JSONModel/JSONModelLib.h>
#import <AFNetworking/AFNetworking.h>
#import "NSDate+Category.h"
#import "NSDateFormatter+Category.h"
#import "Masonry.h"


#import <IQKeyboardManager/IQKeyboardManager.h>

#import "ZNApi.h"
#define JRSystemVersionGreaterOrEqualThan(version) ([[[UIDevice currentDevice] systemVersion] floatValue] >= version)
#define kLoginBtnCorner 2.f
#define kLoginBtnHeight 44.f
#define CELLDICTIONARYBUILT(a,b) [NSDictionary dictionaryWithObjectsAndKeys:a,@"k",b,@"v",nil]
#define CELLDICTIONARYBUILTV(a,b,c) [NSDictionary dictionaryWithObjectsAndKeys:a,@"k",b,@"v1",c,@"v2",nil]

//设备的宽度
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

/*腾讯微博*/
#define TencentWeiboAppKey     @"1103074867"
#define TencentWeiboAppKeySecret  @"0mV0MmY64ZK9zZSV"
#define TencentWeiboREDIRECTURI             @"http://www.baidu.com"

/*QQ空间,QQ*/
#define QQHLSDKAppKey @"1103074867"
#define QQHLSDKAppSecret @"0mV0MmY64ZK9zZSV"

/*微信*/
#define WXSDKAppKey @"wxe084293a2b896acf"
#define WXSDKAppSecret @"d00ed4d36263aab4aed222d82a67bb28"

/*新浪微博*/
#define SINAWEIBOAppKey @"3749353156"
#define SINAWEIBOAppSecret @"c1730b2fefc30574f444a10e016d7d72"
#define SINAWEIBOREDIRECTURI @"http://www.sina.com"

#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"
/* RGB 颜色转换 */
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(CGFloat)(r)/255.0 green:(CGFloat)(g)/255.0 blue:(CGFloat)(b)/255.0 alpha:1]
/* RGB 颜色转换 */
#define RGBCOLOR_WithAlpha(r,g,b,a) [UIColor colorWithRed:(CGFloat)(r)/255.0 green:(CGFloat)(g)/255.0 blue:(CGFloat)(b)/255.0 alpha:a]
//版本号
#define iOS_Version [[UIDevice currentDevice].systemVersion doubleValue]
//设备的高度
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
//设备的宽度
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

#define kTopNavBarMargin topNavBarMargin()


#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

void showAlertTitleMsg(NSString *title,NSString *message);
void showAlertMessage(NSString *message);
void showAlertError(NSError *err);
float topNavBarMargin();

extern NSString *const loadingHintStr;
extern NSString *const kServiceErrStr;
extern NSString *const kValidateErrStr;
extern NSString *const shareSdkAppKey;
extern NSString const *const shareSdkAppSecret;
extern NSString *const kNeedLoginErrStr;

#define kImageHeaderHeight 54


#define DEFAULT_FONT_FAMILY @"MicrosoftYaHei"

#define DEFAULT_FONT(fontSize) [UIFont fontWithName:DEFAULT_FONT_FAMILY size:fontSize]

//#define DEFAULT_FONT(fontSize) [UIFont systemFontOfSize:fontSize]

#define DEFAULT_BOLD_FONT(fontSize) [UIFont boldSystemFontOfSize:fontSize]


@interface ZNAppUtil : NSObject

+ (NSString *)validateMobile:(NSString *)string;
+ (NSString *)validateEmail:(NSString *)string;
+(NSString* )validateIdentityNo :(NSString *)identityStr;
+(NSString *)getTheDateStr:(NSString *)dateStr fromTimeType:(NSString *)fromTimeTypeStr toTimeType:(NSString *)toTimeTypeStr;
+(NSString* )validateQQNumber :(NSString *)numberString;
+(BOOL)validateDecimalStr:(NSString *)numberStr;

+(NSString *)decimalStyleString:(NSString *)valueStr ;
+(NSString *)decimalStyleString:(NSString *)valueStr withDigits:(NSUInteger )minimumFractionDigits;
+(NSString *)decimalStyleNumber:(NSNumber *)valueNum ;
+(NSString *)decimalStyleNumber:(NSNumber *)valueNum withDigits:(NSUInteger )minimumFractionDigits ;
+(NSString *) getProjectStyleValueWithKey:(NSString *)styleKey;
+(CGFloat)getHeightWithoutbBackspace:(NSString *)text font:(UIFont *)font  size:(CGSize )size;
+(CGFloat)getHeight:(NSString *)text font:(UIFont *)font  size:(CGSize )size;

+(id)loadObjFromFile:(NSString *)fileName;
+(NSString *)objToJsonStr:(id)obj;

@end
