//
//  ViewController.m
//  HPPSixGoodLuck
//
//  Created by 黄晓展 on 2019/4/21.
//  Copyright © 2019 HPP. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *openNumbers = @[//2018
                             @"34",@"27",@"02",@"13",@"37",
                             @"13",@"47",@"33",@"37",@"35",
                             @"41", @"26",@"46",@"30",@"04",
                             @"36",@"16",@"19",@"27",@"08",
                             @"15",@"41",@"01",@"37",@"05",
                             @"15",@"21",@"43",@"38",@"12",
                             @"46",@"12",@"17",@"08",@"29",
                             @"44",@"45",@"38",@"34",@"32",
                             @"39",@"35",@"47",@"19",@"34",
                             @"43",@"22",@"39",@"22",@"45",
                             @"42",@"04",@"23",@"37",@"43",
                             //2019
                             @"24",@"02",@"10",@"23",@"27",
                             @"07",@"37",@"08",@"44",@"36",
                             @"21",@"29",@"27",@"39",@"01",
                             @"43",@"27",@"11",@"12",@"41",
                             @"34",@"01",@"15",@"11",@"08",
                             @"45",@"40",@"30",@"46",@"39",
                             @"29",@"15",@"47",@"21",@"11",
                             @"40",@"31",@"49",@"36",@"49",
                             @"36",@"33",@"39",@"34",@"23",
                             @"19",@"04"];
//    [self oneNumberWithOpenNumbers:openNumbers];
//    [self numbersWithOpenNumbers:openNumbers];
//    [self animalsWithOpenNumber:openNumbers];
    [self numbersWithOpenNumbers:openNumbers numbersIntervalLength:5];
    
}
- (void)getMoneyDeadlinewNumber:(NSInteger)DeadlinewNumber{
    
}

- (void)numbersWithOpenNumbers:(NSArray *)openNumbers numbersIntervalLength:(NSInteger)length{
    
    NSMutableArray *key = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 49; i ++ ) {
        NSInteger endNumber = i+length-1;
        if (endNumber <= 49) {
            [key addObject:[NSString stringWithFormat:@"%d-%ld",i,endNumber]];
        }
    }
    NSMutableDictionary *endNumbers = [[NSMutableDictionary alloc] init];
    [key enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [endNumbers setObject:@(0) forKey:obj];
    }];
    [openNumbers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *openNumber = obj;
        [endNumbers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *numberKey = key;
            NSArray *numberKeys = [numberKey componentsSeparatedByString:@"-"];
            NSLog(@"%@",numberKeys);
        }];
    }];
    NSLog(@"%@",endNumbers);
    
}

- (void)animalsWithOpenNumber:(NSArray *)openNumbers{
    NSArray *values = @[@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0)];
    NSArray *keys = @[@"🐭",@"🐂",@"🐯",@"🐰",@"🐲",@"🐍",@"🐴",@"🐑",@"🐵",@"🐔",@"🐶",@"🐖"];
    NSMutableDictionary *endNumbers = [[NSMutableDictionary alloc] initWithObjects:values forKeys:keys];
    [openNumbers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger currentNumber = [obj integerValue];
        NSString *superKey = @"";
        switch (currentNumber) {
            case 1:
            case 13:
            case 25:
            case 37:
            case 49:
            {
                superKey = @"🐖";
            }
            break;
            case 2:
            case 14:
            case 26:
            case 38:
            {
                superKey = @"🐶";
            }
                break;
                break;
            case 3:
            case 15:
            case 27:
            case 39:
            {
                superKey = @"🐔";
            }
                break;
            case 4:
            case 16:
            case 28:
            case 40:
            {
                superKey = @"🐵";
            }
                break;
            case 5:
            case 17:
            case 29:
            case 41:
            {
                superKey = @"🐑";
            }
                break;
            case 6:
            case 18:
            case 30:
            case 42:
            {
                superKey = @"🐴";
            }
                break;
            case 7:
            case 19:
            case 31:
            case 43:
            {
                superKey = @"🐍";
            }
                break;
            case 8:
            case 20:
            case 32:
            case 44:
            {
                superKey = @"🐲";
            }
                break;
            case 9:
            case 21:
            case 33:
            case 45:
            {
                superKey = @"🐰";
            }
                break;
            case 10:
            case 22:
            case 34:
            case 46:
            {
                superKey = @"🐯";
            }
                break;
            case 11:
            case 23:
            case 35:
            case 47:
            {
                superKey = @"🐂";
            }
                break;
            case 12:
            case 24:
            case 36:
            case 48:
            {
                superKey = @"🐭";
            }
                break;
        }
        [keys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *key = [NSString stringWithFormat:@"%@",obj];
            NSInteger end = [[endNumbers objectForKey:key] integerValue];
            if ([superKey isEqualToString:key]) {
                end = 0;
            }else{
                end ++ ;
            }
            [endNumbers setObject:@(end) forKey:key];
        }];
    }];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:endNumbers options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
     NSLog(@"endNumbers = %@",str);
}

- (void)numbersWithOpenNumbers:(NSArray *)openNumbers{
    NSArray *values = @[@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0)];
    NSArray *keys = @[@"1-5",@"6-10",@"11-15",@"16-20",@"21-25",@"26-30",@"31-35",@"36-40",@"41-45",@"46-49"];
    NSMutableDictionary *endNumbers = [[NSMutableDictionary alloc] initWithObjects:values forKeys:keys];
    [openNumbers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger currentNumber = [obj integerValue];
        NSString *superKey = @"";
        if (currentNumber <= 5 ) {
            superKey = @"1-5";
        }else if (currentNumber>5 && currentNumber <= 10){
            superKey = @"6-10";
        }else if (currentNumber>10 && currentNumber <= 15){
            superKey = @"11-15";
        }else if (currentNumber>15 && currentNumber <= 20){
            superKey = @"16-20";
        }else if (currentNumber>20 && currentNumber <= 25){
            superKey = @"21-25";
        }else if (currentNumber>25 && currentNumber <= 30){
            superKey = @"26-30";
        }else if (currentNumber>30 && currentNumber <= 35){
            superKey = @"31-35";
        }else if (currentNumber>35 && currentNumber <= 40){
            superKey = @"36-40";
        }else if (currentNumber>40 && currentNumber <= 45){
            superKey = @"41-45";
        }else{
            superKey = @"46-49";
        }
        [keys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *key = [NSString stringWithFormat:@"%@",obj];
            NSInteger end = [[endNumbers objectForKey:key] integerValue];
            if ([superKey isEqualToString:key]) {
                end = 0;
            }else{
                end ++ ;
            }
            [endNumbers setObject:@(end) forKey:key];
        }];
    }];
    NSLog(@"endNumbers = %@",endNumbers);
}
- (void)oneNumberWithOpenNumbers:(NSArray *)openNumbers{
    __block NSInteger a1 = 0;
    __block NSInteger a2 = 0;
    __block NSInteger a3 = 0;
    __block NSInteger a4 = 0;
    __block NSInteger a5 = 0;
    __block NSInteger a6 = 0;
    __block NSInteger a7 = 0;
    __block NSInteger a8 = 0;
    __block NSInteger a9 = 0;
    __block NSInteger a10 = 0;
    __block NSInteger a11 = 0;
    __block NSInteger a12 = 0;
    __block NSInteger a13 = 0;
    __block NSInteger a14 = 0;
    __block NSInteger a15 = 0;
    __block NSInteger a16 = 0;
    __block NSInteger a17 = 0;
    __block NSInteger a18 = 0;
    __block NSInteger a19 = 0;
    __block NSInteger a20 = 0;
    __block NSInteger a21 = 0;
    __block NSInteger a22 = 0;
    __block NSInteger a23 = 0;
    __block NSInteger a24 = 0;
    __block NSInteger a25 = 0;
    __block NSInteger a26 = 0;
    __block NSInteger a27 = 0;
    __block NSInteger a28 = 0;
    __block NSInteger a29 = 0;
    __block NSInteger a30 = 0;
    __block NSInteger a31 = 0;
    __block NSInteger a32 = 0;
    __block NSInteger a33 = 0;
    __block NSInteger a34 = 0;
    __block NSInteger a35 = 0;
    __block NSInteger a36 = 0;
    __block NSInteger a37 = 0;
    __block NSInteger a38 = 0;
    __block NSInteger a39 = 0;
    __block NSInteger a40 = 0;
    __block NSInteger a41 = 0;
    __block NSInteger a42 = 0;
    __block NSInteger a43 = 0;
    __block NSInteger a44 = 0;
    __block NSInteger a45 = 0;
    __block NSInteger a46 = 0;
    __block NSInteger a47 = 0;
    __block NSInteger a48 = 0;
    __block NSInteger a49 = 0;
    NSArray * values = @[
                         @(a1),@(a2),@(a3),@(a4),@(a5),@(a6),@(a7),@(a8),@(a9),
                         @(a10),@(a11),@(a12),@(a13),@(a14),@(a15),@(a16),@(a17),@(a18),@(a19),
                         @(a20),@(a21),@(a22),@(a23),@(a24),@(a25),@(a26),@(a27),@(a28),@(a29),
                         @(a30),@(a31),@(a32),@(a33),@(a34),@(a35),@(a36),@(a37),@(a38),@(a39),
                         @(a40),@(a41),@(a42),@(a43),@(a44),@(a45),@(a46),@(a47),@(a48),@(a49),
                         ];
    NSArray * keys = @[
                       @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",
                       @"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",
                       @"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",
                       @"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",
                       @"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",
                       ];
    NSMutableDictionary *endNumbers = [[NSMutableDictionary alloc] initWithObjects:values forKeys:keys];
    [openNumbers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSInteger currentNumber = [obj integerValue];
            [keys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *key = [NSString stringWithFormat:@"%@",obj];
                NSInteger end = [[endNumbers objectForKey:key] integerValue];
                if (currentNumber == [obj integerValue]) {
                    end = 0;
                }else{
                    end ++ ;
                }
                [endNumbers setObject:@(end) forKey:key];
            }];
        }];
        __block NSMutableArray *results = [[NSMutableArray alloc] init];
        [endNumbers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:obj,key, nil];
            if (results.firstObject == nil) {
                [results addObject:dict];
            }else{
                NSDictionary *firstInfo = results.firstObject;
                NSArray *allKeys = [firstInfo allKeys];
                NSString *key = allKeys.firstObject;
                NSArray *allValuses = [firstInfo allValues];
                NSInteger number = [allValuses.firstObject integerValue];
                if ([obj integerValue] > number) {
                    [results insertObject:dict atIndex:0];
                }else if([obj integerValue] == number){
                    if ([key integerValue] < [key integerValue]) {
                        [results insertObject:dict atIndex:0];
                    }else{
                        [results insertObject:dict atIndex:1];
                    }
                }else{
                    [results addObject:dict];
                }
            }
        }];
        for (int i = 0; i<results.count-1; i++) {
            for (int j = 0; j<results.count-1-i; j++) {
                NSDictionary *infoL = results[j];
                NSArray * valuesL = [infoL allValues];
                NSInteger valueL = [valuesL.firstObject integerValue];
    
                NSDictionary *infoR = results[j+1];
                NSArray * valuesR = [infoR allValues];
                NSInteger valueR = [valuesR.firstObject integerValue];
                if (valueR > valueL) {
                    [results exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                }
            }
        }
        NSLog(@"%@",results);
}



@end
