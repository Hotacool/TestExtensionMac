//
//  HACDocuments.m
//  TestExtensionMac
//
//  Created by macbook on 16/10/24.
//  Copyright © 2016年 Hotacool. All rights reserved.
//

#import "HACDocumentManager.h"
#import "HACDocument.h"

static NSString *const HACDocumentManagerIsFunc = @"\\s*-\\s*\\(\\s*(\\w+)\\s*\\)([\\w\\s]+)\\s*(\\:\\s*\\(\\s*\\w+\\s*\\)[\\w\\s]+)*\\s*[\\;|\\{]+";
static NSString *const HACDocumentManagerExtractParam = @"[\\w\\s]+\\:\\s*\\(\\s*(\\w+)+\\s*\\)\\s*(\\w+)";

@implementation HACDocumentManager

+(BOOL)handleInvocation:(XCSourceEditorCommandInvocation *)invocation {
    NSString *documents2Add = [self analyzeInvocation:invocation];
    
    if (documents2Add) {
        XCSourceTextRange *selection = invocation.buffer.selections.firstObject;
        NSInteger index = selection.start.line;
        [invocation.buffer.lines insertObject:documents2Add atIndex:index+1];
        return YES;
    }
    return NO;
}
+ (NSString *)filterBlankAndBlankLines:(NSString *)str {
    NSMutableString *Mstr = [ NSMutableString string ];
    NSArray *arr = [str componentsSeparatedByString:@"\n"];
    for ( int i = 0 ; i < arr. count ; i++) {
        NSString *tempStr = ( NSString *)arr[i];
        [tempStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [tempStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        [tempStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        if (tempStr.length != 0 ) {
            [Mstr appendString :arr[i]];
        }
    }
    return Mstr;
}

+ (NSString*)analyzeInvocation:(XCSourceEditorCommandInvocation*)invocation {
    XCSourceTextRange *selection = invocation.buffer.selections.firstObject;
    NSMutableArray* lines = invocation.buffer.lines;
    NSInteger index = selection.start.line;
    
    NSArray *afterLines = [lines subarrayWithRange:NSMakeRange(index, lines.count-index)];
    NSString *afterContent = [afterLines componentsJoinedByString:@""];
    NSString *content = [self filterBlankAndBlankLines:afterContent];
    
    NSString *__block funcName;
    NSString *__block returnParam;
    NSMutableArray<HACParam*> *__block params = [NSMutableArray array];
    NSError * __block error;
    NSRegularExpression *r_isFunc = [NSRegularExpression regularExpressionWithPattern:HACDocumentManagerIsFunc options:NSRegularExpressionCaseInsensitive error:&error];
    [r_isFunc enumerateMatchesInString:content
                               options:NSMatchingReportProgress
                                 range:NSMakeRange(0, [content length])
                            usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
                                NSRange matchRange = [result range];
                                NSString *matchStr = [content substringWithRange:matchRange];
                                if (result.numberOfRanges == 4) {
                                    NSRange range1 = [result rangeAtIndex:1];
                                    returnParam = [content substringWithRange:range1];
                                    NSRange range2 = [result rangeAtIndex:2];
                                    funcName = [content substringWithRange:range2];
                                    // params
                                    NSRegularExpression *r_params = [NSRegularExpression regularExpressionWithPattern:HACDocumentManagerExtractParam options:0 error:&error];
                                    [r_params enumerateMatchesInString:matchStr options:0 range:NSMakeRange(0, [matchStr length]) usingBlock:^(NSTextCheckingResult * _Nullable r, NSMatchingFlags f, BOOL * _Nonnull s) {
                                        if (r.numberOfRanges == 3) {
                                            NSRange r1 = [r rangeAtIndex:1];
                                            NSString *type = [matchStr substringWithRange:r1];
                                            NSRange r2 = [r rangeAtIndex:2];
                                            NSString *name = [matchStr substringWithRange:r2];
                                            if (type&&name) {
                                                [params addObject:[[HACParam alloc] initWithType:type name:name]];
                                            }
                                        } else {
                                            *s = YES;
                                        }
                                    }];
                                } else {
                                    *stop = YES;
                                }
                            }];
    if (!error) {
        return [HACDocument createDocumentsWithFuncName:funcName returnParam:returnParam params:params];
    }
    return nil;
}
@end
