//
//  NSString+Extension.m
//  full_lease_landlord
//
//  Created by apple on 2020/12/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

//+ (NSString *)correctPrecision:(NSString *)money {
//    //    NSDecimalNumber * number = [NSDecimalNumber decimalNumberWithString:originMoney];
//    //    NSDecimal resultStruct;
//    //    NSDecimal str = number.decimalValue;
//    //    NSDecimalRound(&resultStruct, &str, 2, NSRoundPlain); // 四舍五入保留3为小数，末尾没有0
//    //    NSDecimalNumber * resultNumber = [NSDecimalNumber decimalNumberWithDecimal:resultStruct];
//    //    return [resultNumber stringValue];
//    if ([Help isRightData:money]) {
//        return @"";
//    }
//    
//    double conversionValue = [money doubleValue];
//    NSString *doubleString = [NSString stringWithFormat:@"%.2lf", conversionValue];
//    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
//    return [decNumber stringValue];
//}

@end
