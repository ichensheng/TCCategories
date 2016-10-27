//
//  NSDate+TCExtensions.h
//  TCCategories
//
//  Created by 陈 胜 on 16/5/24.
//  Copyright © 2016年 陈胜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TCExtensions)

/**
 *  获取时间戳
 *
 *  @return 时间戳
 */
- (long long)tc_timestamp;

/**
 *  获取当前时间戳
 *
 *  @return 当前时间戳
 */
+ (long long)tc_currentTimestamp;

/**
 *  时间戳转换为NSDate
 *
 *  @param timestamp 时间戳
 *
 *  @return 时间对象
 */
+ (NSDate *)tc_dateFromTimestamp:(long long)timestamp;

/**
 *  字符串时间转换成NSDate
 *
 *  @param dateString 时间字符串
 *
 *  @return 时间对象
 */
+ (NSDate *)tc_dateFromString:(NSString *)dateString;

/**
 *  格式化时间
 *
 *  @param format 时间格式
 *  
 *  @return 时间字符串
 */
- (NSString *)tc_stringWithFormat:(NSString *)format;

/**
 *  指定format格式化时间
 *
 *  @param date 时间
 *  @param format 时间格式
 *  
 *  @return 时间字符串
 */
+ (NSString *)tc_formatDateToString:(NSDate *)date
                     withDateFormat:(NSString *)format;

/**
 *  转换时间格式
 *
 *  @param date 时间字符串
 *  @param format 时间格式
 *  
 *  @return 时间字符串
 */
+ (NSString *)tc_formatDate:(NSString *)dateString
             withDateFormat:(NSString *)format;

// Relative dates from the current date
+ (NSDate *)tc_dateTomorrow;
+ (NSDate *)tc_dateYesterday;
+ (NSDate *)tc_dateWithDaysFromNow:(NSInteger)days;
+ (NSDate *)tc_dateWithDaysBeforeNow:(NSInteger)days;
+ (NSDate *)tc_dateWithHoursFromNow:(NSInteger)hours;
+ (NSDate *)tc_dateWithHoursBeforeNow:(NSInteger)hours;
+ (NSDate *)tc_dateWithMinutesFromNow:(NSInteger)minutes;
+ (NSDate *)tc_dateWithMinutesBeforeNow:(NSInteger)minutes;

// Comparing dates
- (BOOL)tc_isEqualToDateIgnoringTime:(NSDate *)date;
- (BOOL)tc_isToday;
- (BOOL)tc_isTomorrow;
- (BOOL)tc_isYesterday;
- (BOOL)tc_isSameWeekAsDate:(NSDate *)date;
- (BOOL)tc_isThisWeek;
- (BOOL)tc_isNextWeek;
- (BOOL)tc_isLastWeek;
- (BOOL)tc_isSameMonthAsDate:(NSDate *)date;
- (BOOL)tc_isThisMonth;
- (BOOL)tc_isSameYearAsDate:(NSDate *)date;
- (BOOL)tc_isThisYear;
- (BOOL)tc_isNextYear;
- (BOOL)tc_isLastYear;
- (BOOL)tc_isEarlierThanDate:(NSDate *)date;
- (BOOL)tc_isLaterThanDate:(NSDate *)date;
- (BOOL)tc_isInFuture;
- (BOOL)tc_isInPast;

// Date roles
- (BOOL)tc_isTypicallyWorkday;
- (BOOL)tc_isTypicallyWeekend;

// Adjusting dates
- (NSDate *)tc_dateByAddingDays:(NSInteger)days;
- (NSDate *)tc_dateBySubtractingDays:(NSInteger)days;
- (NSDate *)tc_dateByAddingHours:(NSInteger)hours;
- (NSDate *)tc_dateBySubtractingHours:(NSInteger)hours;
- (NSDate *)tc_dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)tc_dateBySubtractingMinutes:(NSInteger)minutes;
- (NSDate *)tc_dateAtStartOfDay;

// Retrieving intervals
- (NSInteger)tc_minutesAfterDate:(NSDate *)date;
- (NSInteger)tc_minutesBeforeDate:(NSDate *)date;
- (NSInteger)tc_hoursAfterDate:(NSDate *)date;
- (NSInteger)tc_hoursBeforeDate:(NSDate *)date;
- (NSInteger)tc_daysAfterDate:(NSDate *)date;
- (NSInteger)tc_daysBeforeDate:(NSDate *)date;
- (NSInteger)tc_distanceInDaysToDate:(NSDate *)anotherDate;
- (NSInteger)tc_distanceInSecondsToSecond:(NSDate *)anotherDate;

// Decomposing dates
@property (readonly) NSInteger tc_nearestHour;
@property (readonly) NSInteger tc_hour;
@property (readonly) NSInteger tc_minute;
@property (readonly) NSInteger tc_seconds;
@property (readonly) NSInteger tc_day;
@property (readonly) NSInteger tc_month;
@property (readonly) NSInteger tc_week;
@property (readonly) NSInteger tc_weekday;
@property (readonly) NSInteger tc_nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger tc_year;

@end
