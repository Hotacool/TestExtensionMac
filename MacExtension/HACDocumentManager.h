//
//  HACDocuments.h
//  TestExtensionMac
//
//  Created by macbook on 16/10/24.
//  Copyright © 2016年 Hotacool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XcodeKit/XcodeKit.h>

@interface HACDocumentManager : NSObject

+ (BOOL)handleInvocation:(XCSourceEditorCommandInvocation *)invocation ;
@end
