//
//  NSDate+Extension.h
//  SmartLock
//
//  Created by 江欣华 on 2016/10/25.
//  Copyright © 2016年 工程锁. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@interface NSDate (Extension)

+ (NSCalendar *) currentCalendar; // avoid bottlenecks

// Relative dates from the current date
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;
+ (NSDate *) date:(NSString *)datestr format:(NSString *)format;

// Short string utilities
- (NSString *) stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle;
- (NSString *) stringWithFormat: (NSString *) format;
@property (nonatomic, readonly) NSString *shortString;
@property (nonatomic, readonly) NSString *shortDateString;
@property (nonatomic, readonly) NSString *shortTimeString;
@property (nonatomic, readonly) NSString *mediumString;
@property (nonatomic, readonly) NSString *mediumDateString;
@property (nonatomic, readonly) NSString *mediumTimeString;
@property (nonatomic, readonly) NSString *longString;
@property (nonatomic, readonly) NSString *longDateString;
@property (nonatomic, readonly) NSString *longTimeString;

// Comparing dates
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;

- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;

- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;

- (BOOL) isSameMonthAsDate: (NSDate *) aDate;
- (BOOL) isThisMonth;
- (BOOL) isNextMonth;
- (BOOL) isLastMonth;

- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;

- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;

- (BOOL) isInFuture;
- (BOOL) isInPast;

// Date roles
- (BOOL) isTypicallyWorkday;
- (BOOL) isTypicallyWeekend;

// Adjusting dates
- (NSDate *) dateByAddingYears: (NSInteger) dYears;
- (NSDate *) dateBySubtractingYears: (NSInteger) dYears;
- (NSDate *) dateByAddingMonths: (NSInteger) dMonths;
- (NSDate *) dateBySubtractingMonths: (NSInteger) dMonths;
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) dateByAddingHours: (NSInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;

// Date extremes
- (NSDate *) dateAtStartOfDay;
- (NSDate *) dateAtEndOfDay;

// Retrieving intervals
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;


/**
 返回时间间隔

 @param startStr 开始时间
 @param endStr   结束时间
 @return 间隔多少秒
 */
+ (NSTimeInterval)timeTntervalInSecondsToStart:(NSString *)startStr withEnd:(NSString *)endStr;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;


/**
 返回特定格式的时间

 @param formatStr 自定义格式
 @return 返回时间
 */
- (NSString *)dateWithCustomFormat:(NSString *)formatStr;
- (NSDate *)dateWithFormatter:(NSString *)formatter;

@end
