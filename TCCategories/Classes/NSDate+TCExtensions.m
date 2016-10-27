//
//  NSDate+TCExtensions.m
//  TCCategories
//
//  Created by 陈 胜 on 16/5/24.
//  Copyright © 2016年 陈胜. All rights reserved.
//

#import "NSDate+TCExtensions.h"

#define SECOND_OF_MINUTE	60
#define SECOND_OF_HOUR		3600
#define SECOND_OF_DAY		86400
#define SECOND_OF_WEEK		604800
#define SECOND_OF_YEAR		31556926

#define CURRENT_CALENDAR [NSCalendar currentCalendar]

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
#define CALENDAR_COMPONENTS (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
#else
#define CALENDAR_COMPONENTS (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#endif

@implementation NSDate (TCExtensions)

/**
 *  获取时间戳
 *
 *  @return 时间戳
 */
- (long long)tc_timestamp {
    return [[NSNumber numberWithDouble:[self timeIntervalSince1970] * 1000] longLongValue];
}

/**
 *  获取当前时间戳
 *
 *  @return 当前时间戳
 */
+ (long long)tc_currentTimestamp {
    return [[NSDate date] tc_timestamp];
}

/**
 *  时间戳转换为NSDate
 *
 *  @param timestamp 时间戳
 *
 *  @return 时间对象
 */
+ (NSDate *)tc_dateFromTimestamp:(long long)timestamp {
    return [NSDate dateWithTimeIntervalSince1970:(timestamp / 1000.0)];
}

/**
 *  字符串时间转换成NSDate
 *
 *  @param dateString 时间字符串
 *
 *  @return 时间对象
 */
+ (NSDate *)tc_dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    return [dateFormatter dateFromString:dateString];
}

/**
 *  格式化时间
 *
 *  @param format 时间格式
 *
 *  @return 时间字符串
 */
- (NSString *)tc_stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}

/**
 *  指定format格式化时间
 *
 *  @param date 时间
 *  @param format 时间格式
 *
 *  @return 时间字符串
 */
+ (NSString *)tc_formatDateToString:(NSDate *)date
                     withDateFormat:(NSString *)format {
    
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    [formate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formate stringFromDate:date];
    NSString *timeString = [NSDate tc_formatDate:dateString withDateFormat:format];
    return timeString;
}

/**
 *  转换时间格式
 *
 *  @param date 时间字符串
 *  @param format 时间格式
 *
 *  @return 时间字符串
 */
+ (NSString *)tc_formatDate:(NSString *)dateString
             withDateFormat:(NSString *)format {
    
    if (dateString.length == 10) {
        dateString = [dateString stringByAppendingString:@" 00:00:00"];
    } else if (dateString.length == 16){
        dateString = [dateString stringByAppendingString:@":00"];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:dateString];
    
    NSDateFormatter *stringFormatter = [[NSDateFormatter alloc] init];
    [stringFormatter setDateFormat:format];
    stringFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-cn"];
    return [stringFormatter stringFromDate:date];
}

// Relative dates from the current date
+ (NSDate *)tc_dateTomorrow {
    return [NSDate tc_dateWithDaysFromNow:1];
}
+ (NSDate *)tc_dateYesterday {
    return [NSDate tc_dateWithDaysBeforeNow:1];
}
+ (NSDate *)tc_dateWithDaysFromNow:(NSInteger)days {
    return [[NSDate date] tc_dateByAddingDays:days];
}
+ (NSDate *)tc_dateWithDaysBeforeNow:(NSInteger)days {
    return [[NSDate date] tc_dateBySubtractingDays:days];
}
+ (NSDate *)tc_dateWithHoursFromNow:(NSInteger)hours {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + SECOND_OF_HOUR * hours;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}
+ (NSDate *)tc_dateWithHoursBeforeNow:(NSInteger)hours {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - SECOND_OF_HOUR * hours;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}
+ (NSDate *)tc_dateWithMinutesFromNow:(NSInteger)minutes {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + SECOND_OF_MINUTE * minutes;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}
+ (NSDate *)tc_dateWithMinutesBeforeNow:(NSInteger)minutes {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - SECOND_OF_MINUTE * minutes;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}

// Comparing dates
- (BOOL)tc_isEqualToDateIgnoringTime:(NSDate *)date {
    NSDateComponents *components1 = [CURRENT_CALENDAR components:CALENDAR_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:CALENDAR_COMPONENTS fromDate:date];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}
- (BOOL)tc_isToday {
    return [self tc_isEqualToDateIgnoringTime:[NSDate date]];
}
- (BOOL)tc_isTomorrow {
    return [self tc_isEqualToDateIgnoringTime:[NSDate tc_dateTomorrow]];
}
- (BOOL)tc_isYesterday {
    return [self tc_isEqualToDateIgnoringTime:[NSDate tc_dateYesterday]];
}
- (BOOL)tc_isSameWeekAsDate:(NSDate *)date {
    NSDateComponents *components1 = [CURRENT_CALENDAR components:CALENDAR_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:CALENDAR_COMPONENTS fromDate:date];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if ([components1 weekOfMonth] != [components2 weekOfMonth]) {
        return NO;
    }
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:date]) < SECOND_OF_WEEK);
}
- (BOOL)tc_isThisWeek {
    return [self tc_isSameWeekAsDate:[NSDate date]];
}
- (BOOL)tc_isNextWeek {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + SECOND_OF_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
    return [self tc_isSameWeekAsDate:newDate];
}
- (BOOL)tc_isLastWeek {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - SECOND_OF_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
    return [self tc_isSameWeekAsDate:newDate];
}
- (BOOL)tc_isSameMonthAsDate:(NSDate *)date {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:date];
#else
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:date];
#endif
    return ((components1.month == components2.month) && (components1.year == components2.year));
}
- (BOOL)tc_isThisMonth {
    return [self tc_isSameMonthAsDate:[NSDate date]];
}
- (BOOL)tc_isSameYearAsDate:(NSDate *)date {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:date];
#else
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:date];
#endif
    return (components1.year == components2.year);
}
- (BOOL)tc_isThisYear {
    return [self tc_isSameYearAsDate:[NSDate date]];
}
- (BOOL)tc_isNextYear {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:[NSDate date]];
#else
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
#endif
    return (components1.year == (components2.year + 1));
}
- (BOOL)tc_isLastYear {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:[NSDate date]];
#else
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
#endif
    return (components1.year == (components2.year - 1));
}
- (BOOL)tc_isEarlierThanDate:(NSDate *)date {
    return ([self compare:date] == NSOrderedAscending);
}
- (BOOL)tc_isLaterThanDate:(NSDate *)date {
    return ([self compare:date] == NSOrderedDescending);
}
- (BOOL)tc_isInFuture {
    return ([self tc_isLaterThanDate:[NSDate date]]);
}
- (BOOL)tc_isInPast {
    return ([self tc_isEarlierThanDate:[NSDate date]]);
}

// Date roles
- (BOOL)tc_isTypicallyWorkday {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components = [CURRENT_CALENDAR components:NSCalendarUnitWeekday fromDate:self];
#else
    NSDateComponents *components = [CURRENT_CALENDAR components:NSWeekdayCalendarUnit fromDate:self];
#endif
    if ((components.weekday == 1) || (components.weekday == 7)) {
        return YES;
    }
    return NO;
}
- (BOOL)tc_isTypicallyWeekend {
    return ![self tc_isTypicallyWeekend];
}

// Adjusting dates
- (NSDate *)tc_dateByAddingDays:(NSInteger)days {
    NSTimeInterval timeInterval = [self timeIntervalSinceReferenceDate] + SECOND_OF_DAY * days;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}
- (NSDate *)tc_dateBySubtractingDays:(NSInteger)days {
    return [self tc_dateByAddingDays:(days * -1)];
}
- (NSDate *)tc_dateByAddingHours:(NSInteger)hours {
    NSTimeInterval timeInterval = [self timeIntervalSinceReferenceDate] + SECOND_OF_HOUR * hours;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}
- (NSDate *)tc_dateBySubtractingHours:(NSInteger)hours {
    return [self tc_dateByAddingHours: (hours * -1)];
}
- (NSDate *)tc_dateByAddingMinutes:(NSInteger)minutes {
    NSTimeInterval timeInterval = [self timeIntervalSinceReferenceDate] + SECOND_OF_MINUTE * minutes;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}
- (NSDate *)tc_dateBySubtractingMinutes:(NSInteger)minutes {
    return [self tc_dateByAddingMinutes: (minutes * -1)];
}
- (NSDate *)tc_dateAtStartOfDay {
    NSDateComponents *components = [CURRENT_CALENDAR components:CALENDAR_COMPONENTS fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [CURRENT_CALENDAR dateFromComponents:components];
}

// Retrieving intervals
- (NSInteger)tc_minutesAfterDate:(NSDate *)date {
    return (NSInteger)([self timeIntervalSinceDate:date] / SECOND_OF_MINUTE);
}
- (NSInteger)tc_minutesBeforeDate:(NSDate *)date {
    return (NSInteger)([date timeIntervalSinceDate:self] / SECOND_OF_MINUTE);
}
- (NSInteger)tc_hoursAfterDate:(NSDate *)date {
    return (NSInteger)([self timeIntervalSinceDate:date] / SECOND_OF_HOUR);
}
- (NSInteger)tc_hoursBeforeDate:(NSDate *)date {
    return (NSInteger)([date timeIntervalSinceDate:self] / SECOND_OF_HOUR);
}
- (NSInteger)tc_daysAfterDate:(NSDate *)date {
    return (NSInteger)([self timeIntervalSinceDate:date] / SECOND_OF_DAY);
}
- (NSInteger)tc_daysBeforeDate:(NSDate *)date {
    return (NSInteger)([date timeIntervalSinceDate:self] / SECOND_OF_DAY);
}
- (NSInteger)tc_distanceInDaysToDate:(NSDate *)anotherDate {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0].day;
#else
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [gregorianCalendar components:NSDayCalendarUnit fromDate:self toDate:anotherDate options:0].day;
#endif
}
- (NSInteger)tc_distanceInSecondsToSecond:(NSDate *)anotherDate {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [gregorianCalendar components:NSCalendarUnitSecond fromDate:self toDate:anotherDate options:0].second;
#else
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [gregorianCalendar components:NSSecondCalendarUnit fromDate:self toDate:anotherDate options:0].second;
#endif
}

// Decomposing dates
- (NSInteger)tc_nearestHour {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + SECOND_OF_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components = [CURRENT_CALENDAR components:NSCalendarUnitHour fromDate:newDate];
#else
    NSDateComponents *components = [CURRENT_CALENDAR components:NSHourCalendarUnit fromDate:newDate];
#endif
    return components.hour;
}
- (NSInteger)tc_hour {
    NSDateComponents *components = [CURRENT_CALENDAR components:CALENDAR_COMPONENTS fromDate:self];
    return components.hour;
}

- (NSInteger)tc_minute {
    NSDateComponents *components = [CURRENT_CALENDAR components:CALENDAR_COMPONENTS fromDate:self];
    return components.minute;
}

- (NSInteger)tc_seconds {
    NSDateComponents *components = [CURRENT_CALENDAR components:CALENDAR_COMPONENTS fromDate:self];
    return components.second;
}
- (NSInteger)tc_day {
    NSDateComponents *components = [CURRENT_CALENDAR components:CALENDAR_COMPONENTS fromDate:self];
    return components.day;
}
- (NSInteger)tc_month {
    NSDateComponents *components = [CURRENT_CALENDAR components:CALENDAR_COMPONENTS fromDate:self];
    return components.month;
}
- (NSInteger)tc_week {
    NSDateComponents *components = [CURRENT_CALENDAR components:CALENDAR_COMPONENTS fromDate:self];
    return [components weekOfMonth];
}
- (NSInteger)tc_weekday {
    NSDateComponents *components = [CURRENT_CALENDAR components:CALENDAR_COMPONENTS fromDate:self];
    return components.weekday;
}
- (NSInteger)tc_nthWeekday {
    NSDateComponents *components = [CURRENT_CALENDAR components:CALENDAR_COMPONENTS fromDate:self];
    return components.weekdayOrdinal;
}
- (NSInteger)tc_year {
    NSDateComponents *components = [CURRENT_CALENDAR components:CALENDAR_COMPONENTS fromDate:self];
    return components.year;
}

@end
