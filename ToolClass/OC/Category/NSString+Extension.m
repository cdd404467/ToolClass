//
//  NSString+Extension.m
//  full_lease_landlord
//
//  Created by apple on 2020/12/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+ (NSString *)correctPrecisionOC:(NSString *)money {
//        NSDecimalNumber * number = [NSDecimalNumber decimalNumberWithString:money];
//        NSDecimal resultStruct;
//        NSDecimal str = number.decimalValue;
//        NSDecimalRound(&resultStruct, &str, 2, NSRoundPlain); // 四舍五入保留3为小数，末尾没有0
//        NSDecimalNumber * resultNumber = [NSDecimalNumber decimalNumberWithDecimal:resultStruct];
//        return [resultNumber stringValue];
//    if (![Help isRightData:money]) {
//        return @"";
//    }
//
//    double conversionValue = [money doubleValue];
//    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
//    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
//    return [decNumber stringValue];
    
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    format.minimumFractionDigits = 0;
    format.maximumIntegerDigits = 6;
    format.numberStyle = NSNumberFormatterDecimalStyle;
//    format.positivePrefix = @"赚";
//    format.positiveSuffix = @"元";
//    format.negativePrefix = @"亏";
//    format.negativeSuffix = @"金";
    // 小数点样式
    format.decimalSeparator = @".";

        // 零的样式
    format.zeroSymbol       = @"-";
    return [format stringFromNumber:@1.200];
     
}

+ (NSString *)notRounding:(float)price {

    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:YES raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:YES];

    NSDecimalNumber *ouncesDecimal;

    NSDecimalNumber *roundedOunces;

    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];

    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];

    return [NSString stringWithFormat:@"%@",roundedOunces];

}

@end
