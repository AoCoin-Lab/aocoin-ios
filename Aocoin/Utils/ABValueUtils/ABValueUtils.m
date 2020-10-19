//
//  ValueUtils.m
//  IBSDemo
//
//  Created by Xing on 14-7-11.
//  Copyright (c) 2014年 ryshine.com北京瑞翔科技. All rights reserved.
//

#import "ABValueUtils.h"
//#define kDEFAULT_DATE_TIME_FORMAT (@"yyyy-MM-dd'T'HH:mm:ss'Z'")

@implementation ABValueUtils
+(BOOL)isEmpty:(id)idValue
{
    if (idValue == nil ||
        [idValue isEqual:[NSNull null]]||
        [idValue isKindOfClass:[NSNull class]]) {
        return YES;
    }else if ([[idValue class] isSubclassOfClass:[NSString class]]) {
        NSString *value = (NSString *)idValue;
        if (value.length == 0) {
            return YES;
        }
        if ([value isEqualToString:@"(null)"]) {
            return YES;
        }
    }else if ([[idValue class] isSubclassOfClass:[NSArray class]]){
        NSArray *value = (NSArray*)idValue;
        if (value.count == 0) {
            return YES;
        }
    }else if ([[idValue class] isSubclassOfClass:[NSDictionary class]]){
        NSDictionary *value = (NSDictionary*)idValue;
        if (value.count == 0) {
            return YES;
        }
    }
    return NO;
}

+(NSString*)idToString:(id)obj
{
    if ( obj == nil ) {
        return nil;
    }
    
    if ( [obj isKindOfClass:[NSNull class]]) {
        return nil;
    }

    if ( [obj isKindOfClass:[NSString class]]) {
 
        return (NSString*)obj;
 
    }else if ( [obj isKindOfClass:[NSArray class]] ){
 
        NSMutableString* ntf = [NSMutableString string];
 
        for (id t in obj ) {
 
            [ntf appendString:[self idToString:t]];
 
            [ntf appendString:@","];
 
        }
 
        return ntf;
 
    }else {
 
        if( CFGetTypeID((__bridge CFTypeRef)(obj)) == CFBooleanGetTypeID() ){
 
            return [NSString stringWithFormat:@"%@", (CFBooleanGetValue((CFBooleanRef)obj) == true ? @"true" : @"false") ];
 
        }
 
        if ( sizeof(obj) == sizeof(BOOL) ) {
 
//            return (BOOL)obj == YES ? @"true" : @"false";
 
        }
         if( [obj respondsToSelector:@selector(stringValue)] ){
            return [obj stringValue];
        }
        return [obj description];
    }
}



+(BOOL)boolValue:(NSDictionary*)dict forKey:(id)key
{
    id bl = [dict objectForKey:key];
    if ( bl == nil || [bl isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if ( [bl isKindOfClass:[NSString class]]) {
        NSString* cstr = [bl lowercaseString];

        if ( [cstr isEqualToString:@"yes"] || [cstr isEqualToString:@"true"]) {

            return YES;

        }

        return [cstr boolValue];

    }

    if ( CFBooleanGetValue((CFBooleanRef)bl) ) {

        return YES;

    }

    return NO;

}

+(float)floatValue:(NSDictionary*)dict forKey:(id)key{

    id bl = [dict objectForKey:key];

    if ( bl == nil || [bl isKindOfClass:[NSNull class]]) {

        return 0.0f;
 
    }

    return [bl floatValue];

}



+(NSInteger)intValue:(NSDictionary*)dict forKey:(id)key

{

    id bl = [dict objectForKey:key];

    if ( bl == nil || [bl isKindOfClass:[NSNull class]]) {

        return 0.0f;

    }
    
    return [bl integerValue];

}



+(NSString*)stringValue:(NSDictionary*)dict forKey:(id)key

{

    id bl = [dict objectForKey:key];

    if ( bl == nil || [bl isKindOfClass:[NSNull class]]) {

        return nil;

    }

    return [self idToString:bl];
}



+(NSArray*)arrayValue:(NSDictionary*)dict forKey:(id)key

{

    id bl = [dict objectForKey:key];

    if ( bl == nil || [bl isKindOfClass:[NSNull class]]) {

        return nil;

    }

    if ( [bl isKindOfClass:[NSArray class]]) {

        return (NSArray*)bl;

    }

    return nil;

}



+(NSDictionary*)dictionaryValue:(NSDictionary*)dict forKey:(id)key
{

    id bl = [dict objectForKey:key];

    if ( bl == nil || [bl isKindOfClass:[NSNull class]]) {

        return nil;

    }

    return (NSDictionary*)bl;

}



+(id)noneNullValue:(NSDictionary*)dict forKey:(id)key

{

    id bl = [dict objectForKey:key];

    if ( bl == nil || [bl isKindOfClass:[NSNull class]]) {

        return nil;

    }

    return bl;

}



+(BOOL)stringEquals:(NSString*)str1 to:(NSString*)str2

{
    
    if ( str1 == nil || str2 == nil ) {
        
        return NO;
        
    }
    
    return [str1 compare:str2 options:NSCaseInsensitiveSearch] == NSOrderedSame;
    
}



+(BOOL)caseEquals:(NSString*)str1 to:(NSString*)str2

{
    
    return (str1 == nil || str2 == nil) ? NO : [str1 isEqualToString:str2];
    
}



+(BOOL)startWith:(NSString*)prefix forString:(NSString*)text;

{
    
    if ( text != nil && prefix != nil ){
        
        if ( [prefix length] > [text length] ) {
            
            return NO;
            
        }
        
        
        
        NSString* prestr = [text substringToIndex:[prefix length]];
        
        if ( [self stringEquals:prestr to:prefix] ) {
            
            return YES;
            
        }
        
        
        
    }
    
    return NO;
    
}



+(BOOL)endWith:(NSString*)suffix forString:(NSString*)text

{
    
    if ( text != nil && suffix != nil ){
        
        if ( [suffix length] > [text length] ) {
            
            return NO;
            
        }
        
        NSInteger len = [text length] - [suffix length];
        
        NSString* sufstr = [text substringFromIndex:len];
        
        if ( [self caseEquals:sufstr to:suffix] ) {
            
            return YES;
            
        }
        
        
        
    }
    
    return NO;
    
}



+(BOOL)isURLString:(NSString*)text

{
    
    if ( [text length] > 6 ) {
        
        NSString* prefix = [text substringToIndex:6];
        
        if ( [self stringEquals:prefix to:@"http:/"] || [self stringEquals:prefix to:@"https:"] ) {
            
            return YES;
            
        } else if ( [self stringEquals:prefix to:@"local:" ] ){
            
            return YES;
            
        }
        
    }
    
    if ( [self startWith:@"/" forString:text] ){
        
        return YES;
        
    }
    
    return NO;
    
}



+(NSString*)refineUrl:(NSString*)url

{
    
    return url;
    
}



+(BOOL)booleanToBool:(id)bobj

{
    
    if ( bobj == nil ) {
        
        return NO;
        
    }
    
    if ( [bobj isKindOfClass:[NSString class]] ) {
        
        return [bobj caseInsensitiveCompare:@"yes"] == 0 || [bobj caseInsensitiveCompare:@"true"] == 0;
        
    }else if ( [bobj respondsToSelector:@selector(boolValue)] ){
        
        return [bobj boolValue];
        
    }else {
        
        return CFBooleanGetValue((CFBooleanRef)bobj);
        
    }
    
    
    
    return NO;
    
}



+(NSDate *)stringToDate:(NSString *)string withFormat:(NSString*)fmt{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    
    //#define kDEFAULT_DATE_TIME_FORMAT (@"yyyy-MM-dd'T'HH:mm:ss'Z'")
    
    NSString* format = fmt == nil ? @"yyyy-MM-dd'T'HH:mm:ss'Z'" : fmt;
    
    [formatter setDateFormat:format];
    
    NSDate *date = [formatter dateFromString:string];
    
//    [formatter release];
    
    return date;
    
}



+(NSString*) dateToString:(NSDate*)date withFormat:(NSString*)fmt

{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    
    //#define kDEFAULT_DATE_TIME_FORMAT (@"yyyy-MM-dd'T'HH:mm:ss'Z'")
    
    NSString* format = fmt == nil ? @"yyyy-MM-dd'T'HH:mm:ss'Z'" : fmt;
    
    [formatter setDateFormat:format];
    
    NSString* dateStr = [formatter stringFromDate:date];
    
//    [formatter release];
    
    return dateStr;
    
}

+ (NSString *)getTimestamp:(NSString*)mStr{
    
    NSTimeInterval interval =[mStr doubleValue] / 1000.0;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    
    NSString *dateString = [formatter stringFromDate: date];
    
    return dateString;
}


+(NSString*)getStringByDate:(NSString*)string{
    
    NSTimeInterval time=[string doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

//获取当前时间戳有两种方法(以秒为单位)
+(NSString *)getNowTimeTimestamp{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    //设置时区,这个对于时间的处理有时很重要

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];

    [formatter setTimeZone:timeZone];

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];

    return timeSp;

}

//获取当前时间戳有两种方法(以毫秒为单位)
+(NSString *)getNowTimeLongTimestamp{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    //设置时区,这个对于时间的处理有时很重要

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];

    [formatter setTimeZone:timeZone];

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];

    return timeSp;

}


+(NSString*)dictionaryToString:(NSDictionary*)dictionary{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&parseError];
    NSString *ret = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return ret;
}

+(NSString*)arrayToString:(NSArray*)array{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:0 error:&parseError];
    NSString *ret = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return ret;
}

+(NSMutableAttributedString*)AB_PageTitleText:(NSString*)text{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text attributes: @{NSFontAttributeName: [UIFont fontWithName:PingFangSC_Semibold size: F_24],NSForegroundColorAttributeName: [UIColor whiteColor]}];
    return string;
}

//币的精度处理 除
+(NSDecimalNumber*)balanceByPrecision:(NSString*)balance precision:(NSString*)precision{
    if ([ABValueUtils isEmpty:balance]) {
        return [NSDecimalNumber decimalNumberWithString:@"0"];
    }
    NSInteger p = [precision integerValue];
    NSDecimalNumber* b = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",balance]];
    NSDecimalNumber* r = [[NSDecimalNumber decimalNumberWithString:@"10"]decimalNumberByRaisingToPower:p];
    NSDecimalNumber* result = [b decimalNumberByDividingBy:r withBehavior:[ABValueUtils decimalNumberHandlerWithScale:4]];
    if ([ABValueUtils isEmpty:result.stringValue]) {
        return [NSDecimalNumber decimalNumberWithString:@"0"];
    }
    return result;
}

//币的精度处理 除
+(NSDecimalNumber*)balanceByPrecision:(NSString*)balance precision:(NSString*)precision scale:(NSInteger)scale{
    if ([ABValueUtils isEmpty:balance]) {
        return [NSDecimalNumber decimalNumberWithString:@"0"];
    }
    NSInteger p = [precision integerValue];
    NSDecimalNumber* b = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",balance]];
    NSDecimalNumber* r = [[NSDecimalNumber decimalNumberWithString:@"10"]decimalNumberByRaisingToPower:p];
    NSDecimalNumber* result = [b decimalNumberByDividingBy:r withBehavior:[ABValueUtils decimalNumberHandlerWithScale:scale]];
    if ([ABValueUtils isEmpty:result.stringValue]) {
        return [NSDecimalNumber decimalNumberWithString:@"0"];
    }
    return result;
}

//币的精度处理 乘
+(NSDecimalNumber*)multiplyingPrecision:(NSString*)amount precision:(NSString*)precision{
    NSInteger p = [precision integerValue];
    NSDecimalNumber* b = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",amount]];
    NSDecimalNumber* r = [[NSDecimalNumber decimalNumberWithString:@"10"]decimalNumberByRaisingToPower:p];
    NSDecimalNumber* result = [b decimalNumberByMultiplyingBy:r withBehavior:[ABValueUtils decimalNumberHandlerWithScale:6]];
    return result;
}


//返回一个 NSDecimalNumberHandler
+(NSDecimalNumberHandler*)decimalNumberHandlerWithScale:(short)scale{
    return  [NSDecimalNumberHandler
             decimalNumberHandlerWithRoundingMode:NSRoundDown
             scale:scale
             raiseOnExactness:NO
             raiseOnOverflow:NO
             raiseOnUnderflow:NO
             raiseOnDivideByZero:YES];
}


//比较大小
+(NSComparisonResult)compareDecimalNumberA:(NSString*)A B:(NSString*)B{
    NSDecimalNumber* a = [NSDecimalNumber decimalNumberWithString:A];
    NSDecimalNumber* b = [NSDecimalNumber decimalNumberWithString:B];
    return [a compare:b];
}

//减法 小数点
+(NSDecimalNumber*)decimalNumberBySubtractingA:(NSString*)A B:(NSString*)B scale:(short)scale{
    NSDecimalNumber* a = [NSDecimalNumber decimalNumberWithString:A];
    NSDecimalNumber* b = [NSDecimalNumber decimalNumberWithString:B];
    return [a decimalNumberBySubtracting:b withBehavior:[ABValueUtils decimalNumberHandlerWithScale:scale]];
}

//减法
+(NSDecimalNumber*)decimalNumberBySubtractingA:(NSString*)A B:(NSString*)B{
    NSDecimalNumber* a = [NSDecimalNumber decimalNumberWithString:A];
    NSDecimalNumber* b = [NSDecimalNumber decimalNumberWithString:B];
    return [a decimalNumberBySubtracting:b withBehavior:[ABValueUtils decimalNumberHandlerWithScale:6]];
}
//加法 小数点
+(NSDecimalNumber*)decimalNumberByAddingA:(NSString*)A B:(NSString*)B scale:(short)scale{
    NSDecimalNumber* a = [NSDecimalNumber decimalNumberWithString:A];
    NSDecimalNumber* b = [NSDecimalNumber decimalNumberWithString:B];
    return [a decimalNumberByAdding:b withBehavior:[ABValueUtils decimalNumberHandlerWithScale:scale]];
}

//加法
+(NSDecimalNumber*)decimalNumberByAddingA:(NSString*)A B:(NSString*)B{
    NSDecimalNumber* a = [NSDecimalNumber decimalNumberWithString:A];
    NSDecimalNumber* b = [NSDecimalNumber decimalNumberWithString:B];
    return [a decimalNumberByAdding:b withBehavior:[ABValueUtils decimalNumberHandlerWithScale:6]];
}

//乘法
+(NSDecimalNumber*)decimalNumberByMultiplyingA:(NSString*)A B:(NSString*)B{
    if ([A doubleValue] == 0 || [B doubleValue] == 0) {
        return [NSDecimalNumber zero];
    }
    NSDecimalNumber* a = [NSDecimalNumber decimalNumberWithString:A];
    NSDecimalNumber* b = [NSDecimalNumber decimalNumberWithString:B];
    return [a decimalNumberByMultiplyingBy:b withBehavior:[ABValueUtils decimalNumberHandlerWithScale:6]];
}

//乘法 小数点
+(NSDecimalNumber*)decimalNumberByMultiplyingA:(NSString*)A B:(NSString*)B scale:(short)scale{
    if ([A doubleValue] == 0 || [B doubleValue] == 0) {
        return [NSDecimalNumber zero];
    }
    NSDecimalNumber* a = [NSDecimalNumber decimalNumberWithString:A];
    NSDecimalNumber* b = [NSDecimalNumber decimalNumberWithString:B];
    return [a decimalNumberByMultiplyingBy:b withBehavior:[ABValueUtils decimalNumberHandlerWithScale:scale]];
}

//乘法 自定义handler
+(NSDecimalNumber*)decimalNumberByMultiplyingA:(NSString*)A
                                             B:(NSString*)B
                                       handler:(NSDecimalNumberHandler*)handler{
    if ([A doubleValue] == 0 || [B doubleValue] == 0) {
        return [NSDecimalNumber zero];
    }
    NSDecimalNumber* a = [NSDecimalNumber decimalNumberWithString:A];
    NSDecimalNumber* b = [NSDecimalNumber decimalNumberWithString:B];
    return [a decimalNumberByMultiplyingBy:b withBehavior:handler];
}

//除法
+(NSDecimalNumber*)decimalNumberByDividingA:(NSString*)A B:(NSString*)B scale:(short)scale{
    if ([B doubleValue] == 0) {
        return [NSDecimalNumber zero];
    }
    NSDecimalNumber* a = [NSDecimalNumber decimalNumberWithString:A];
    NSDecimalNumber* b = [NSDecimalNumber decimalNumberWithString:B];
    return [a decimalNumberByDividingBy:b withBehavior:[ABValueUtils decimalNumberHandlerWithScale:scale]];
}

//每隔3位整数由逗号“,”分隔的字符串 添加前缀
+(NSString*)AB_SeparateNumberAddPrefixText:(NSString*)numberString{
    // 前缀
    NSString *prefix = @"≈$ ";
    NSString* newNumberString = [self separateNumber:numberString];
    newNumberString = [NSString stringWithFormat:@"%@%@",prefix,newNumberString];
    return newNumberString;
}

// 每隔3位整数由逗号“,”分隔的字符串
+(NSString*)AB_SeparateNumberText:(NSString *)numberString{
    NSString* newNumberString = [self separateNumber:numberString];
    return newNumberString;
}

//每隔3位整数由逗号“,”分隔的字符串 小数点后边字号变小
+(NSMutableAttributedString*)AB_SeparateNumberAttributedString:(NSString*)numberString{
    NSString* newNumberString = [self separateNumber:numberString];
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc]initWithString:newNumberString];
    if ([numberString containsString:@"."]) {
        NSArray *comArray = [numberString componentsSeparatedByString:@"."];
        NSString*radixPoint = [comArray lastObject];
        NSRange range =[newNumberString rangeOfString:radixPoint];
        [attString addAttribute:NSFontAttributeName value:[UIFont fontWithName:PingFangSC_Regular size: F_20] range:range];
    }
    return attString;
}

+(NSString*)separateNumber:(NSString*)numberString{
    // 分隔符
    NSString *pide = @",";
    NSString *integer = @"";
    NSString *radixPoint = @"";
    BOOL contains = NO;
    if ([numberString containsString:@"."]) {
        contains = YES;
        // 若传入浮点数，则需要将小数点后的数字分离出来
        NSArray *comArray = [numberString componentsSeparatedByString:@"."];
        integer = [comArray firstObject];
        radixPoint = [comArray lastObject];
    } else {
        integer = numberString;
    }
    // 将整数按各个字符为一组拆分成数组
    NSMutableArray *integerArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < integer.length; i ++) {
        NSString *subString = [integer substringWithRange:NSMakeRange(i, 1)];
        [integerArray addObject:subString];
    }
    // 将整数数组倒序每隔3个字符添加一个逗号“,”
    NSString *newNumberString = @"";
    for (NSInteger i = 0 ; i < integerArray.count ; i ++) {
        NSString *getString = @"";
        NSInteger index = (integerArray.count-1) - i;
        if (integerArray.count > index) {
            getString = [integerArray objectAtIndex:index];
        }
        BOOL result = YES;
        if (index == 0 && integerArray.count%3 == 0) {
            result = NO;
        }
        if ((i+1)%3 == 0 && result) {
            newNumberString = [NSString stringWithFormat:@"%@%@%@",pide,getString,newNumberString];
        } else {
            newNumberString = [NSString stringWithFormat:@"%@%@",getString,newNumberString];
        }
    }
    if (contains) {
        newNumberString = [NSString stringWithFormat:@"%@.%@",newNumberString,radixPoint];
    }
    return newNumberString;
}

//判断密码格式
+(BOOL)verifyPasswordFormat:(NSString*)password{
    //大小写字母+数字+长度>8  //@"/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/"
    NSString *regex = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$";
    // 创建谓词对象并设定条件表达式
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    // 字符串判断，然后BOOL值
    BOOL b = [predicate evaluateWithObject:password];
    return b;
}

+(NSMutableAttributedString*)stringSetColorAndFontWithString:(NSString*)string
                                                       color:(UIColor*)color
                                                        font:(UIFont*)font
                                                       range:(NSRange)range{
    NSMutableAttributedString* mFromString = [[NSMutableAttributedString alloc]initWithString:string];
    [mFromString addAttribute:NSForegroundColorAttributeName
                                 value:color
                                 range:range];
    [mFromString addAttribute:NSFontAttributeName
                        value:font
                        range:range];
    return mFromString;
}



//文本颜色
+(NSMutableAttributedString*)setAttributedStringTextWithString:(NSString*)string andRange:(NSRange)range andColor:(UIColor*)color{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:color
                             range:range];
    return attributedString;
}
//文本字体
+(NSMutableAttributedString*)setAttributedStringWithString:(NSString*)string andRange:(NSRange)range fontSize:(CGFloat)fontSize{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttribute:NSFontAttributeName
                             value:[UIFont systemFontOfSize:fontSize]
                             range:range];
    return attributedString;
}
//文本宽
+(CGFloat)getWidthByString:(NSString*)string  width:(CGFloat)width height:(CGFloat)height fontSize:(CGFloat)fontSize{
    
    CGRect frame = [string boundingRectWithSize:CGSizeMake(width, height)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}
                                        context:nil];
    return frame.size.width;
}
//转成属性字符串
+(NSMutableAttributedString*)getAttributedString:(NSString*)string andFont:(UIFont*)font andLineSpacing:(CGFloat)lineSpacing{
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    [att addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [att length])];
    [att addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [att length])];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [att length])];
    
    return att;
}

//计算属性字符串的高
+(CGFloat)getStringHeightWithString:(NSString*)string andWidth:(CGFloat)width andFontSize:(CGFloat)fontSize andLineSpacing:(CGFloat)lineSpacing{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    CGRect frame = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle} context:nil];
    return frame.size.height;
}

//行间距
+(NSMutableAttributedString*)attributedStringWithString:(NSString*)string LineSpacing:(CGFloat)lineSpacing{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    return attributedString;
}

// 下划线
+(NSMutableAttributedString*)attributedStringStyleSingle:(NSString*)string{
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:string attributes:attribtDic];
    return attribtStr;
}

//处理html格式的文本  ：停服 ，强制升级  强制消息  在使用
+(NSAttributedString*)htmlAttributedString:(NSString*)htmlString fontSize:(CGFloat)fontSize lineSpacing:(CGFloat)lineSpacing color:(UIColor*)color{
    
    NSMutableAttributedString *attributedString =[[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    //设置富文本字的颜色
    [attributedString addAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(0, attributedString.length)];
    //设置富文本字的大小
    [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} range:NSMakeRange(0, attributedString.length)];
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributedString length])];
    return attributedString;
}



//字符串补齐
+(NSString*)characterStringMainString:(NSString*)MainString
                             AddDigit:(int)AddDigit
                            AddString:(NSString*)AddString{
    
    NSString* ret = [[NSString alloc]init];
    
    ret = MainString;
    
    for(int y =0;y < (AddDigit - MainString.length) ;y++ ){
        
        ret = [NSString stringWithFormat:@"%@%@",AddString,ret];
        
    }
    return ret;
}

+(BOOL)isURL:(NSString*)urlString{
    if ([ABValueUtils isEmpty:urlString]) {
        return NO;
    }
    if ([urlString hasPrefix:@"http://"]||
        [urlString hasPrefix:@"https://"]) {
        return YES;
    }
    return NO;
}

//随机生成字符串(由大小写字母、数字组成)
+ (NSString *)randomString:(int)len;{
    
    char ch[len];
    for (int index=0; index < len; index++) {
        int num = arc4random_uniform(75)+48;
        if (num>57 && num<65) { num = num%57+48; }
        else if (num>90 && num<97) { num = num%90+65; }
        ch[index] = num;
    }
    
    return [[NSString alloc] initWithBytes:ch length:len encoding:NSUTF8StringEncoding];
}

/*
 获取url的所有参数
 @param url 需要提取参数的url
 @return NSDictionary
 */
+(NSDictionary *) parameterWithURL:(NSString *) urlStr {
    
    if (urlStr && urlStr.length && [urlStr rangeOfString:@"?"].length == 1) {
        NSArray *array = [urlStr componentsSeparatedByString:@"?"];
        if (array && array.count == 2) {
            NSString *paramsStr = array[1];
            if (paramsStr.length) {
                NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
                NSArray *paramArray = [paramsStr componentsSeparatedByString:@"&"];
                for (NSString *param in paramArray) {
                    if (param && param.length) {
                        NSArray *parArr = [param componentsSeparatedByString:@"="];
                        if (parArr.count == 2) {
                            [paramsDict setObject:parArr[1] forKey:parArr[0]];
                        }
                    }
                }
                return paramsDict;
            }else{
                return nil;
            }
        }else{
            return nil;
        }
    }else{
        return nil;
    }
 
    return nil;
}

//判断是否是16进制
+(BOOL)isHexString:(NSString*)string{
    if ([string hasPrefix:@"0x"]) {
        string = [string substringFromIndex:2];
    }
    NSString *regex = @"^[A-Fa-f0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL b = [predicate evaluateWithObject:string];
    return b;
}


//处理小数异常
+ (NSString *)errorValue:(double)value {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];

    numberFormatter.numberStyle = kCFNumberFormatterNoStyle;
    //整数最少位数
    numberFormatter.minimumIntegerDigits = 1;
    //小数位最多位数
    numberFormatter.maximumFractionDigits = 18;
    //小数位最少位数
    numberFormatter.minimumFractionDigits = 0;
    NSString *newAmount = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:value]];
    return newAmount;
}

//gif 解析成数组
+ (NSArray *)cgimagesWithGif:(NSString *)gifNameInBoundle {
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:gifNameInBoundle withExtension:@"gif"];
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);
    size_t gifCount = CGImageSourceGetCount(gifSource);
    NSMutableArray *frames = [[NSMutableArray alloc]init];
    for (size_t i = 0; i< gifCount; i++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
//        UIImage *image = [UIImage imageWithCGImage:imageRef];
        [frames addObject:(__bridge UIImage *)imageRef];
        CGImageRelease(imageRef);
    }
    return frames;
}

@end
