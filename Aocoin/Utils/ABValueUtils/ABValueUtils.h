//
//  ValueUtils.h
//  IBSDemo
//
//  Created by Xing on 14-7-11.
//  Copyright (c) 2014年 ryshine.com北京瑞翔科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ABValueUtils : NSObject
+(BOOL)isEmpty:(id)idValue;

+(BOOL)boolValue:(NSDictionary*)dict forKey:(id)key;

+(float)floatValue:(NSDictionary*)dict forKey:(id)key;

+(NSInteger)intValue:(NSDictionary*)dict forKey:(id)key;

+(NSString*)stringValue:(NSDictionary*)dict forKey:(id)key;

+(NSArray*)arrayValue:(NSDictionary*)dict forKey:(id)key;

+(id)noneNullValue:(NSDictionary*)dict forKey:(id)key;

+(NSDictionary*)dictionaryValue:(NSDictionary*)dict forKey:(id)key;

+(BOOL)stringEquals:(NSString*)str1 to:(NSString*)str2;

+(BOOL)caseEquals:(NSString*)str1 to:(NSString*)str2;

+(NSString*)refineUrl:(NSString*)url;

+(BOOL)isURLString:(NSString*)text;

+(BOOL)startWith:(NSString*)prefix forString:(NSString*)text;

+(BOOL)endWith:(NSString*)suffix forString:(NSString*)text;

+(NSDate *)stringToDate:(NSString *)string withFormat:(NSString*)fmt;

+(NSString*)dateToString:(NSDate*)date withFormat:(NSString*)fmt;

+(NSString*)idToString:(id)obj;

+(BOOL)booleanToBool:(id)bobj;

+(NSString*)dictionaryToString:(NSDictionary*)dictionary;

+(NSString*)arrayToString:(NSArray*)array;

+ (NSString *)getTimestamp:(NSString*)mStr;

+(NSString *)getNowTimeTimestamp;

+(NSString*)getNowTimeLongTimestamp;

+(NSString*)getStringByDate:(NSString*)string;

//每隔3位整数由逗号“,”分隔的字符串 添加前缀
+(NSString*)AB_SeparateNumberAddPrefixText:(NSString*)numberString;

// 每隔3位整数由逗号“,”分隔的字符串
+(NSString*)AB_SeparateNumberText:(NSString *)numberString;

//每隔3位整数由逗号“,”分隔的字符串 小数点后边字号变小
+(NSMutableAttributedString*)AB_SeparateNumberAttributedString:(NSString*)numberString;

//判断密码格式
+(BOOL)verifyPasswordFormat:(NSString*)password;

//币的精度处理 除 小数
+(NSDecimalNumber*)balanceByPrecision:(NSString*)balance precision:(NSString*)precision scale:(NSInteger)scale;

//币的精度处理 除
+(NSDecimalNumber*)balanceByPrecision:(NSString*)balance precision:(NSString*)precision;

//币的精度处理 乘
+(NSDecimalNumber*)multiplyingPrecision:(NSString*)amount precision:(NSString*)precision;

//比较大小
+(NSComparisonResult)compareDecimalNumberA:(NSString*)A B:(NSString*)B;

//减法 小数点
+(NSDecimalNumber*)decimalNumberBySubtractingA:(NSString*)A B:(NSString*)B scale:(short)scale;

//减法
+(NSDecimalNumber*)decimalNumberBySubtractingA:(NSString*)A B:(NSString*)B;

//加法 小数点
+(NSDecimalNumber*)decimalNumberByAddingA:(NSString*)A B:(NSString*)B scale:(short)scale;

//加法
+(NSDecimalNumber*)decimalNumberByAddingA:(NSString*)A B:(NSString*)B;

//乘法
+(NSDecimalNumber*)decimalNumberByMultiplyingA:(NSString*)A B:(NSString*)B;

//乘法 小数点
+(NSDecimalNumber*)decimalNumberByMultiplyingA:(NSString*)A B:(NSString*)B scale:(short)scale;

//乘法 自定义handler
+(NSDecimalNumber*)decimalNumberByMultiplyingA:(NSString*)A
                                             B:(NSString*)B
                                       handler:(NSDecimalNumberHandler*)handler;

//除法
+(NSDecimalNumber*)decimalNumberByDividingA:(NSString*)A B:(NSString*)B scale:(short)scale;
//字符串补齐
+(NSString*)characterStringMainString:(NSString*)MainString
                              AddDigit:(int)AddDigit
                             AddString:(NSString*)AddString;

+(BOOL)isURL:(NSString*)urlString;


+(NSMutableAttributedString*)stringSetColorAndFontWithString:(NSString*)string
                                                       color:(UIColor*)color
                                                        font:(UIFont*)font
                                                       range:(NSRange)range;

//文本颜色
+(NSMutableAttributedString*)setAttributedStringTextWithString:(NSString*)string andRange:(NSRange)range andColor:(UIColor*)color;

//行间距
+(NSMutableAttributedString*)attributedStringWithString:(NSString*)string LineSpacing:(CGFloat)lineSpacing;

//文本字体
+(NSMutableAttributedString*)setAttributedStringWithString:(NSString*)string andRange:(NSRange)range fontSize:(CGFloat)fontSize;
//////文本宽
////+(CGFloat)getWidthByString:(NSString*)string  width:(CGFloat)width height:(CGFloat)height fontSize:(CGFloat)fontSize;
//////转成属性字符串
////+(NSMutableAttributedString*)getAttributedString:(NSString*)string andFont:(UIFont*)font andLineSpacing:(CGFloat)lineSpacing;
////
//////计算属性字符串的高
+(CGFloat)getStringHeightWithString:(NSString*)string andWidth:(CGFloat)width andFontSize:(CGFloat)fontSize andLineSpacing:(CGFloat)lineSpacing;
//下划线
+(NSMutableAttributedString*)attributedStringStyleSingle:(NSString*)string;
////
//处理html格式的文本
+(NSAttributedString*)htmlAttributedString:(NSString*)htmlString fontSize:(CGFloat)fontSize lineSpacing:(CGFloat)lineSpacing color:(UIColor*)color;

// 随机生成字符串(由大小写字母、数字组成)
+ (NSString *)randomString:(int)len;

+(NSDictionary *) parameterWithURL:(NSString *) urlStr;

+(BOOL)isHexString:(NSString*)string;

+ (NSString *)errorValue:(double)value;

+ (NSArray *)cgimagesWithGif:(NSString *)gifNameInBoundle;
@end
