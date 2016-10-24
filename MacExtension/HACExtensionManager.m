//
//  HACExtensionManager.m
//  TestExtensionMac
//
//  Created by macbook on 16/10/24.
//  Copyright © 2016年 Hotacool. All rights reserved.
//

#import "HACExtensionManager.h"
#import "HACDocumentManager.h"

@implementation HACExtensionManager

+ (BOOL)handleInvocation:(XCSourceEditorCommandInvocation *)invocation {
    if ([invocation.commandIdentifier isEqualToString:@"HAC.addDocuments"]) {
        return [HACDocumentManager handleInvocation:invocation];
    }
    return NO;
}
@end
