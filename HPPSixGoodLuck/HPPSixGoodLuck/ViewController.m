//
//  ViewController.m
//  HPPSixGoodLuck
//
//  Created by 黄晓展 on 2019/4/21.
//  Copyright © 2019 HPP. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *baseNumbers;
@property (nonatomic, strong) NSArray *historyNumbers;
@property (nonatomic, strong) NSArray *openNumbers;
@property (nonatomic, strong) UIButton *inAllThreeButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hpp_setupUI];
    
//    [self oneNumberWithOpenNumbers:self.openNumbers];
//    [self numbersWithOpenNumbers:self.openNumbers];
//    [self numbersWithOpenTenNumbers:self.openNumbers];
//    [self animalsWithOpenNumber:self.openNumbers];
//    [self numbersWithOpenNumbers:self.openNumbers numbersIntervalLength:5];
}

- (void)hpp_setupUI{
    [self.view addSubview:self.inAllThreeButton];
}

- (void)inAllThreeAtion{
    NSLog(@" 开始运算 ");
    NSMutableArray * allThreeCombinations = [[NSMutableArray alloc] init];
//    NSLog(@"%@",self.historyNumbers);
    
    NSMutableArray *combinations = [[NSMutableArray alloc] init];
    for (NSString *number in self.baseNumbers) {
        [combinations removeAllObjects];
        [combinations addObject:number];
        for (NSString *number in self.baseNumbers) {
            if([number integerValue] > [combinations.firstObject integerValue]){
                [combinations addObject:number];
                for (NSString *number in self.baseNumbers) {
                    if([number integerValue] > [combinations.lastObject integerValue]){
                        [combinations addObject:number];
                        [allThreeCombinations addObject:[combinations copy]];
                        [combinations removeObject:number];
                    }
                }
                [combinations removeObject:number];
            }
        }
    }
    
    NSArray *openNumbers = [self.historyNumbers copy];
    NSMutableArray * openAllThreeCombinations = [[NSMutableArray alloc] init];
    NSMutableArray *openCombinations = [[NSMutableArray alloc] init];
    for (NSArray *openNumber in openNumbers) {
        NSMutableArray *subOpenCombinations = [[NSMutableArray alloc] init];
        for (NSString *number in openNumber) {
            [openCombinations removeAllObjects];
            [openCombinations addObject:number];
//            [subOpenCombinations removeAllObjects];
            for (NSString *number in openNumber) {
                if([number integerValue] > [openCombinations.firstObject integerValue]){
                    [openCombinations addObject:number];
                    for (NSString *number in openNumber) {
                        if([number integerValue] > [openCombinations.lastObject integerValue]){
                            [openCombinations addObject:number];
                            [subOpenCombinations addObject:[openCombinations copy]];
                            [openCombinations removeObject:number];
                        }
                    }
                    [openCombinations removeObject:number];
                }
            }
            
        }
        [openAllThreeCombinations addObject:[subOpenCombinations copy]];
    }
    
    

    
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < allThreeCombinations.count ; i ++ ) {
        [results setValue:@"0" forKey:[NSString stringWithFormat:@"%d",i]];
    }
    for (NSMutableArray *subOpenCombinations in openAllThreeCombinations) {
        NSMutableArray *subOpenCombinationKeys = [[NSMutableArray alloc] init];
        for (NSMutableArray *obj in subOpenCombinations) {
            NSInteger index = [allThreeCombinations indexOfObject:obj];
            NSString *openKey = [NSString stringWithFormat:@"%ld",(long)index];
            [subOpenCombinationKeys addObject:openKey];
        }
        
        [results enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSInteger sun = [obj intValue];
            if([key isEqualToString:@"3074"]){
                
            }
            sun ++ ;
            NSString *sunStr = [NSString stringWithFormat:@"%ld",(long)sun];
            [results setValue:sunStr forKey:key];
        }];
        
        [subOpenCombinationKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [results setValue:@"0" forKey:obj];
        }];
        
    }
    
    [results enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSArray *unopenCombination = [allThreeCombinations objectAtIndex:[key intValue]];
            NSLog(@" %@,%@,%@ : %@",unopenCombination[0],unopenCombination[1],unopenCombination[2],obj);
    }];
    
    NSLog(@" 结束运算 ");
}

#pragma mark button ation
- (void)inAllThreeButtonAtion{
    [self inAllThreeAtion];
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
    NSArray *keys = [endNumbers allKeys].mutableCopy;
    [openNumbers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *openNumber = obj;
        [keys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *numberKey = obj;
            NSArray *numberKeys = [numberKey componentsSeparatedByString:@"-"];
            NSInteger minNumber = [numberKeys.firstObject integerValue];
            NSInteger maxNumber = [numberKeys.lastObject integerValue];
            NSInteger openIntNumber = [openNumber integerValue];
            if (openIntNumber >= minNumber && openIntNumber <= maxNumber) {
                [endNumbers setObject:@(0) forKey:numberKey];
            }else{
                NSInteger end = [[endNumbers objectForKey:numberKey] integerValue];
                end ++ ;
                [endNumbers setObject:@(end) forKey:numberKey];
            }
            
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

- (void)numbersWithOpenTenNumbers:(NSArray *)openNumbers{
    NSArray *values = @[@(0),@(0),@(0),@(0),@(0)];
    NSArray *keys = @[@"01-10",@"11-20",@"21-30",@"31-40",@"41-49"];
    NSMutableDictionary *endNumbers = [[NSMutableDictionary alloc] initWithObjects:values forKeys:keys];
    [openNumbers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger currentNumber = [obj integerValue];
        NSString *superKey = @"";
        if (currentNumber <= 10 ) {
            superKey = @"01-10";
        }else if (currentNumber>10 && currentNumber <= 20){
            superKey = @"11-20";
        }else if (currentNumber>20 && currentNumber <= 30){
            superKey = @"21-30";
        }else if (currentNumber>30 && currentNumber <= 40){
            superKey = @"31-40";
        }else if (currentNumber>40 && currentNumber <= 49){
            superKey = @"41-49";
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





#pragma mark get
- (UIButton *)inAllThreeButton{
    if(!_inAllThreeButton){
        _inAllThreeButton = [[UIButton alloc] init];
        _inAllThreeButton.frame = CGRectMake( 100,100 , 100, 50);
        [_inAllThreeButton setTitle:@"三中三" forState:UIControlStateNormal];
        [_inAllThreeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _inAllThreeButton.layer.borderColor = [UIColor redColor].CGColor;
        _inAllThreeButton.layer.borderWidth = 1;
        [_inAllThreeButton addTarget:self action:@selector(inAllThreeButtonAtion) forControlEvents:UIControlEventTouchUpInside];
    }
    return _inAllThreeButton;
}

- (NSArray *)baseNumbers{
    if(!_baseNumbers){
        _baseNumbers = @[
        @"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",
        @"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",
        @"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",
        @"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",
        @"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",
        ];
//        _baseNumbers = @[
//        @"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",
//        @"10",@"11",@"12",@"13",@"14"
//        ];
//        _baseNumbers = @[
//        @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",
//        @"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",
//        @"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",
//        @"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",
//        @"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",
//        ];
    }
    return _baseNumbers;
}

- (NSArray *)historyNumbers{
    
//    @[@"24",@"44",@"26",@"47",@"35",@"21",@"08"],//025
    
    
//    @[@"",@"",@"",@"",@"",@"",@""],
//    @[@"",@"",@"",@"",@"",@"",@""],
//    @[@"",@"",@"",@"",@"",@"",@""],
//    @[@"",@"",@"",@"",@"",@"",@""],
//    @[@"",@"",@"",@"",@"",@"",@""],
    if(!_historyNumbers){
        _historyNumbers = @[
            @[@"04",@"07",@"21",@"35",@"41",@"24",@"18"],
            @[@"43",@"13",@"11",@"17",@"33",@"14",@"27"],
            @[@"14",@"30",@"40",@"48",@"23",@"12",@"01"],
            @[@"37",@"49",@"42",@"29",@"45",@"22",@"47"],
            @[@"16",@"15",@"31",@"36",@"46",@"12",@"03"],
//2019060
            @[@"19",@"03",@"13",@"43",@"35",@"23",@"26"],
            @[@"16",@"24",@"21",@"28",@"37",@"40",@"48"],
            @[@"21",@"24",@"47",@"06",@"32",@"13",@"38"],
            @[@"24",@"03",@"27",@"49",@"28",@"08",@"44"],
            @[@"25",@"19",@"08",@"37",@"20",@"21",@"13"],
//2019065
            @[@"03",@"31",@"33",@"21",@"38",@"06",@"45"],
            @[@"42",@"30",@"17",@"44",@"08",@"07",@"24"],
            @[@"48",@"23",@"29",@"35",@"26",@"18",@"36"],
            @[@"15",@"25",@"11",@"09",@"33",@"21",@"46"],
            @[@"29",@"33",@"13",@"30",@"47",@"43",@"16"],
//2019070
            @[@"29",@"46",@"25",@"32",@"40",@"23",@"13"],
            @[@"20",@"46",@"47",@"12",@"42",@"33",@"27"],
            @[@"29",@"13",@"46",@"09",@"31",@"22",@"45"],
            @[@"45",@"14",@"15",@"42",@"13",@"48",@"02"],
            @[@"44",@"15",@"01",@"24",@"02",@"12",@"14"],
//2019075
            @[@"42",@"11",@"28",@"08",@"10",@"07",@"29"],
            @[@"05",@"31",@"42",@"20",@"39",@"03",@"25"],
            @[@"49",@"03",@"26",@"06",@"32",@"27",@"29"],
            @[@"32",@"14",@"12",@"46",@"38",@"35",@"16"],
            @[@"28",@"06",@"16",@"22",@"37",@"45",@"13"],
//2019080
            @[@"17",@"02",@"04",@"11",@"08",@"31",@"19"],
            @[@"47",@"26",@"27",@"44",@"33",@"30",@"37"],
            @[@"25",@"38",@"42",@"19",@"39",@"14",@"46"],
            @[@"16",@"10",@"07",@"18",@"35",@"11",@"43"],
            @[@"14",@"45",@"04",@"24",@"39",@"19",@"08"],
//2019085
            @[@"03",@"22",@"44",@"19",@"16",@"41",@"29"],
            @[@"21",@"20",@"13",@"43",@"49",@"18",@"30"],
            @[@"24",@"28",@"43",@"27",@"23",@"37",@"16"],
            @[@"06",@"21",@"37",@"22",@"15",@"05",@"36"],
            @[@"19",@"30",@"08",@"44",@"25",@"09",@"37"],
//2019090

            @[@"48",@"49",@"44",@"22",@"15",@"42",@"06"],
            @[@"29",@"14",@"30",@"16",@"10",@"43",@"11"],
            @[@"13",@"02",@"38",@"23",@"35",@"46",@"17"],
            @[@"32",@"44",@"04",@"29",@"26",@"20",@"11"],
            @[@"12",@"32",@"23",@"35",@"16",@"15",@"02"],
//2019095

            @[@"06",@"42",@"01",@"05",@"04",@"43",@"08"],
            @[@"01",@"31",@"47",@"21",@"49",@"10",@"13"],
            @[@"06",@"29",@"18",@"33",@"43",@"46",@"16"],
            @[@"38",@"26",@"24",@"44",@"08",@"37",@"18"],
            @[@"14",@"32",@"44",@"06",@"24",@"01",@"05"],
//2019100
            @[@"02",@"27",@"24",@"39",@"08",@"17",@"10"],
            @[@"04",@"44",@"29",@"03",@"18",@"41",@"39"],
            @[@"08",@"43",@"07",@"25",@"45",@"12",@"13"],
            @[@"43",@"49",@"12",@"28",@"13",@"11",@"47"],
            @[@"33",@"25",@"24",@"23",@"05",@"31",@"07"],
//2019105

            @[@"28",@"07",@"19",@"04",@"12",@"01",@"43"],
            @[@"12",@"26",@"20",@"30",@"22",@"36",@"02"],
            @[@"44",@"08",@"17",@"42",@"39",@"34",@"07"],
            @[@"42",@"28",@"39",@"44",@"03",@"40",@"37"],
            @[@"06",@"44",@"17",@"49",@"46",@"45",@"41"],
//2019110
            @[@"03",@"27",@"20",@"46",@"11",@"02",@"04"],
            @[@"48",@"07",@"02",@"18",@"10",@"03",@"33"],
            @[@"12",@"19",@"13",@"15",@"45",@"01",@"44"],
            @[@"23",@"36",@"43",@"35",@"47",@"13",@"16"],
            @[@"10",@"37",@"27",@"42",@"29",@"16",@"44"],
//2019115
            @[@"19",@"18",@"45",@"21",@"14",@"47",@"49"],
            @[@"22",@"06",@"44",@"19",@"42",@"01",@"25"],
            @[@"31",@"11",@"01",@"41",@"47",@"06",@"32"],
            @[@"10",@"16",@"23",@"27",@"07",@"34",@"24"],
            @[@"49",@"24",@"17",@"30",@"40",@"01",@"48"],
//2019120
            @[@"20",@"19",@"13",@"02",@"10",@"24",@"17"],
            @[@"13",@"25",@"15",@"46",@"30",@"40",@"26"],
            @[@"33",@"34",@"20",@"30",@"07",@"44",@"46"],
            @[@"18",@"06",@"23",@"46",@"31",@"17",@"44"]
//2019124
        ];
//        _historyNumbers = @[
//            @[@"01",@"02",@"03",@"04",@"05",@"06",@"07"],
//            @[@"01",@"02",@"03",@"04",@"05",@"06",@"07"],
//            @[@"08",@"09",@"10",@"11",@"12",@"13",@"14"],
//             @[@"08",@"09",@"10",@"11",@"12",@"13",@"14"],
//             @[@"08",@"09",@"10",@"11",@"12",@"13",@"14"]
//            ////2019124
//                    ];
    }
    return _historyNumbers;
}

- (NSArray *)openNumbers{
    if(!_openNumbers){
        _openNumbers = @[//2018
        @"34",@"27",@"02",@"13",@"37",
        @"13",@"47",@"33",@"37",@"35",
        @"41",@"26",@"46",@"30",@"04",
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
        @"19",@"04",@"05",@"49",@"43",
        @"22",@"02",@"05",@"34",@"35",
        @"18",@"27",@"01",@"47",@"03",
        @"26",@"48",@"38",@"44",@"13",
        @"45",@"24",@"36",@"46",@"16",
        @"13",@"27",@"45",@"02",@"14",
        @"29",@"25",@"29",@"16",@"13",
        @"19",@"37",@"46",@"08",@"29",
        @"30",@"16",@"36",@"37",@"06",
        @"11",@"17",@"11",@"02",@"08",
        @"13",@"16",@"18",@"05",@"10",
        @"39",@"13",@"47",@"07",@"43",
        @"02",@"07",@"37",@"41",@"04",
        @"33",@"44",@"16",@"44",@"49",
        @"25",@"32",@"24",@"48",@"17",
        @"26",@"46",@"44"];
    }
    return _openNumbers;
}


+ (id)getJsonDataJsonname:(NSString *)jsonname
{
    NSString *path = [[NSBundle mainBundle] pathForResource:jsonname ofType:@"JSON"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonData || error) {
        //DLog(@"JSON解码失败");
        return nil;
    } else {
        return jsonObj;
    }
}



@end
