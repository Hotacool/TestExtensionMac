//
//  HACDocument.m
//  TestExtensionMac
//
//  Created by macbook on 16/10/24.
//  Copyright © 2016年 Hotacool. All rights reserved.
//

#import "HACDocument.h"

static NSString *const HACDocumentNormalString = @"/**\n *  <#Description#>\n */";
static NSString *const HACDocumentHeader = @"/**\n";
static NSString *const HACDocumentFooter = @"*/";
static NSString *const HACDocumentDescription = @"*  <#Description#>\n";
static NSString *const HACDocumentContent = @"*  %@\n";
static NSString *const HACDocumentParam = @"*  @param %@ %@ <#frame description#>\n";
static NSString *const HACDocumentReturn = @"*  @return %@ <#return value description#>\n";

@implementation HACParam
- (instancetype)initWithType:(NSString*)type name:(NSString*)name {
    if (self = [super init]) {
        self.type = type;
        self.name = name;
    }
    return self;
}

- (NSString *)description {
    return [@{@"type":self.type,
              @"name":self.name
              } description];
}
@end

@implementation HACDocument

+ (NSString*)createDocumentsWithFuncName:(NSString*)funcName_ returnParam:(NSString*)returnParam_ params:(NSMutableArray<HACParam*>*)params_ {
    if (funcName_) {
        NSMutableString *documents = [NSMutableString string];
        [documents appendString:HACDocumentHeader];
        [documents appendFormat:HACDocumentContent,funcName_];
        [documents appendString:HACDocumentDescription];
        if (returnParam_) {
            if ([returnParam_ isEqualToString:@"void"]) {
                //
            } else {
                [documents appendFormat:HACDocumentReturn,returnParam_];
            }
        }
        [params_ enumerateObjectsUsingBlock:^(HACParam * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [documents appendFormat:HACDocumentParam, obj.name, obj.type];
        }];
        [documents appendString:HACDocumentFooter];
        return [documents copy];
    }
    return HACDocumentNormalString;
}
@end
