//
//  SourceEditorCommand.m
//  MacExtension
//
//  Created by macbook on 16/10/21.
//  Copyright © 2016年 Hotacool. All rights reserved.
//

#import "SourceEditorCommand.h"
#import "HACExtensionManager.h"

@implementation SourceEditorCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation
                   completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
    [HACExtensionManager handleInvocation:invocation];
    completionHandler(nil);
}

@end
