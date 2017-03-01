//
//  NSString+CMKit.m
//  CMKit-HCCategory
//
//  Created by HC on 16/10/25.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "NSString+CMKit.h"
#import "NSData+CMKit.h"

@implementation NSString (CMKit)

- (BOOL)isNotBlank {
    return ![NSString isBlankString:self];
}

+ (BOOL)isNotBlankString:(NSString * _Nullable)string {
    return ![NSString isBlankString:string];
}

- (BOOL)isBlank
{
    return [NSString isBlankString:self];
}

+ (BOOL)isBlankString:(NSString * _Nullable)string
{
    // 判断字符串是否为空
    if (string == nil || string == NULL)
    {
        return YES;
    }
    
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)
    {
        // 去掉前后空格，判断length是否为0
        return YES;
    }
    
    if ([string isEqualToString:@"(null)"] || [string isEqualToString:@"null"] || [string isEqualToString:@"<null>"])
    {
        return YES;
    }
    
    return NO;
}



- (CGFloat)heightForWidth:(float)width andFont:(UIFont * _Nonnull)font {
    return [self sizeWithFont:font maxSize:CGSizeMake(width, MAXFLOAT)].height;
}

- (CGSize)sizeWithFont:(UIFont * _Nonnull)font maxSize:(CGSize)maxSize
{
    CGSize size = CGSizeZero;
    if (self.length > 0) {
        CGRect frame = [self boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName: font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size;
}

- (BOOL) isValidMobileNumber {
    NSString* const MOBILE = @"^1(3|4|5|7|8)\\d{9}$";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [predicate evaluateWithObject:self];
}

- (BOOL) isValidVerifyCode
{
    NSString *pattern = @"^[0-9]{4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [predicate evaluateWithObject:self];
}

- (BOOL) isValidRealName

{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{2,8}$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    
    return [predicate evaluateWithObject:self];
}

- (BOOL) isOnlyChinese
{
    NSString * chineseTest=@"^[\u4e00-\u9fa5]{0,}$";
    NSPredicate*chinesePredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",chineseTest];
    return [chinesePredicate evaluateWithObject:self];
}


- (BOOL) isValidBankCardNumber {
    NSString* const BANKCARD = @"^(\\d{16}|\\d{19})$";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", BANKCARD];
    return [predicate evaluateWithObject:self];
}




- (BOOL) isValidEmail
{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
    
}
- (BOOL) validateNickName
{
    NSString *userNameRegex = @"^[A-Za-z0-9\u4e00-\u9fa5]{1,24}+$";
    
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    
    return [userNamePredicate evaluateWithObject:self];
}
- (BOOL) isValidAlphaNumberPassword
{
    NSString *regex = @"^(?!\\d+$|[a-zA-Z]+$)\\w{6,12}$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [identityCardPredicate evaluateWithObject:self];
}


- (BOOL) isValidIdentifyFifteen
{
    NSString * identifyTest=@"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    NSPredicate*identifyPredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",identifyTest];
    return [identifyPredicate evaluateWithObject:self];
}

- (BOOL) isValidIdentifyEighteen
{
    NSString * identifyTest=@"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    NSPredicate*identifyPredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",identifyTest];
    return [identifyPredicate evaluateWithObject:self];
}


- (BOOL) isOnlyNumber
{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < self.length) {
        NSString * string = [self substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    
    return res;
}

+ (NSString * _Nonnull) getSecrectStringWithPhoneNumber:(NSString *_Nonnull)phoneNum
{
    NSMutableString *newStr = [NSMutableString stringWithString:phoneNum];
    NSRange range = NSMakeRange(3, 4);
    [newStr replaceCharactersInRange:range withString:@"****"];
    return newStr;
}

+ (NSString *_Nonnull) getSecrectStringWithAccountNo:(NSString *_Nonnull)accountNo
{
    NSMutableString *newStr = [NSMutableString stringWithString:accountNo];
    NSRange range = NSMakeRange(4, 8);
    if (newStr.length>12) {
        [newStr replaceCharactersInRange:range withString:@" **** **** "];
    }
    return newStr;
    
}

+(NSString * _Nonnull) compareCurrentTime:(NSTimeInterval) compareDate
{
    
    NSDate *confromTimesp        = [NSDate dateWithTimeIntervalSince1970:compareDate/1000];
    
    NSTimeInterval  timeInterval = [confromTimesp timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    
    NSCalendar *calendar     = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags      = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents*referenceComponents=[calendar components:unitFlags fromDate:confromTimesp];
    //    NSInteger referenceYear  =referenceComponents.year;
    //    NSInteger referenceMonth =referenceComponents.month;
    //    NSInteger referenceDay   =referenceComponents.day;
    NSInteger referenceHour  =referenceComponents.hour;
    //    NSInteger referemceMinute=referenceComponents.minute;
    
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp= timeInterval/60) < 60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = timeInterval/3600) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if ((temp = timeInterval/3600/24)==1)
    {
        result = [NSString stringWithFormat:@"昨天%ld时",(long)referenceHour];
    }
    else if ((temp = timeInterval/3600/24)==2)
    {
        result = [NSString stringWithFormat:@"前天%ld时",(long)referenceHour];
    }
    
    else if((temp = timeInterval/3600/24) <31){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = timeInterval/3600/24/30) <12){
        result = [NSString stringWithFormat:@"%ld个月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}
+ (NSString * _Nonnull) getDateStringWithTimestamp:(NSTimeInterval)timestamp
{
    NSDate *confromTimesp    = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    NSCalendar *calendar     = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags      = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents*referenceComponents=[calendar components:unitFlags fromDate:confromTimesp];
    NSInteger referenceYear  =referenceComponents.year;
    NSInteger referenceMonth =referenceComponents.month;
    NSInteger referenceDay   =referenceComponents.day;
    
    return [NSString stringWithFormat:@"%ld年%ld月%ld日",referenceYear,(long)referenceMonth,(long)referenceDay];
}



+ (NSString * _Nonnull) getStringWithTimestamp:(NSTimeInterval)timestamp formatter:(NSString *_Nonnull)formatter
{
    if ([NSString stringWithFormat:@"%@", @(timestamp)].length == 13) {
        timestamp /= 1000.0f;
    }
    NSDate*timestampDate=[NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *strDate = [dateFormatter stringFromDate:timestampDate];
    
    return strDate;
}

+ (NSString * _Nonnull)searchInString:(NSString *)string charStart:(char)charStart charEnd:(char)charEnd {
    int start = 0, end = 0;
    
    for (int i = 0; i < [string length]; i++) {
        if ([string characterAtIndex:i] == charStart && start == 0) {
            start = i+1;
            i += 1;
            continue;
        }
        if ([string characterAtIndex:i] == charEnd) {
            end = i;
            break;
        }
    }
    
    end -= start;
    
    if (end < 0) {
        end = 0;
    }
    
    return [[string substringFromIndex:start] substringToIndex:end];
}

- (NSString * _Nonnull)searchCharStart:(char)start charEnd:(char)end {
    return [NSString searchInString:self charStart:start charEnd:end];
}

- (NSInteger)indexOfCharacter:(char)character {
    for (NSUInteger i = 0; i < [self length]; i++) {
        if ([self characterAtIndex:i] == character) {
            return i;
        }
    }
    
    return -1;
}

- (NSString * _Nonnull)substringFromCharacter:(char)character {
    NSInteger index = [self indexOfCharacter:character];
    if (index != -1) {
        return [self substringFromIndex:index];
    } else {
        return @"";
    }
}

- (NSString * _Nonnull)substringToCharacter:(char)character {
    NSInteger index = [self indexOfCharacter:character];
    if (index != -1) {
        return [self substringToIndex:index];
    } else {
        return @"";
    }
}

- (BOOL)hasString:(NSString * _Nonnull)substring {
    return [self hasString:substring caseSensitive:YES];
}

- (BOOL)hasString:(NSString *)substring caseSensitive:(BOOL)caseSensitive {
    if (caseSensitive) {
        return [self rangeOfString:substring].location != NSNotFound;
    } else {
        return [self.lowercaseString rangeOfString:substring.lowercaseString].location != NSNotFound;
    }
}

- (BOOL)isEmail {
    return [NSString isEmail:self];
}

+ (BOOL)isEmail:(NSString * _Nonnull)email {
    NSString *emailRegEx = @"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[email lowercaseString]];
}

+ (NSString * _Nonnull)encodeToBase64:(NSString * _Nonnull)string {
    NSData *data = [string convertToNSData];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString * _Nonnull)encodeToBase64 {
    return [NSString encodeToBase64:self];
}

+ (NSString * _Nonnull)decodeBase64:(NSString * _Nonnull)string {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:0];
    return [data convertToUTF8String];
}

- (NSString * _Nonnull)decodeBase64 {
    return [NSString decodeBase64:self];
}


+ (NSData * _Nonnull)convertToNSData:(NSString * _Nonnull)string {
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSData * _Nonnull)convertToNSData {
    return [NSString convertToNSData:self];
}

- (NSString * _Nonnull)sentenceCapitalizedString {
    if (![self length]) {
        return @"";
    }
    NSString *uppercase = [[self substringToIndex:1] uppercaseString];
    NSString *lowercase = [[self substringFromIndex:1] lowercaseString];
    
    return [uppercase stringByAppendingString:lowercase];
}

- (NSString * _Nonnull)dateFromTimestamp {
    NSString *year = [self substringToIndex:4];
    NSString *month = [[self substringFromIndex:5] substringToIndex:2];
    NSString *day = [[self substringFromIndex:8] substringToIndex:2];
    NSString *hours = [[self substringFromIndex:11] substringToIndex:2];
    NSString *minutes = [[self substringFromIndex:14] substringToIndex:2];
    
    return [NSString stringWithFormat:@"%@/%@/%@ %@:%@", day, month, year, hours, minutes];
}

+ (NSString * _Nonnull)generateUUID {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge_transfer NSString *)string;
}

- (BOOL)isUUID {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger matches = [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
    return matches == 1;
}

- (BOOL)isUUIDForAPNS {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9a-f]{32}$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger matches = [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
    return matches == 1;
}

- (NSString * _Nonnull)convertToAPNSUUID {
    return [[[self stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"-" withString:@""];
}




@end
