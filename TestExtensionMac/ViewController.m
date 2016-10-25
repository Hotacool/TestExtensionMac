//
//  ViewController.m
//  TestExtensionMac
//
//  Created by macbook on 16/10/21.
//  Copyright © 2016年 Hotacool. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    NSString *originStr = @"ppplll  l";
    NSLog(@"origin str: %@", originStr);
    NSLog(@"after filter: %@", [self filterBlankAndBlankLines:originStr]);
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (NSString *)filterBlankAndBlankLines:(NSString *)str {
    NSArray* words = [str componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* nospacestring = [words componentsJoinedByString:@""];
    return nospacestring;
}
@end
