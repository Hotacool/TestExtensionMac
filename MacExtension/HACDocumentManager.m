//
//  HACDocuments.m
//  TestExtensionMac
//
//  Created by macbook on 16/10/24.
//  Copyright © 2016年 Hotacool. All rights reserved.
//

#import "HACDocumentManager.h"
#import "HACDocument.h"

static NSString *const HACDocumentManagerIsFunc = @"^-\\((\\w+)\\)(\\w+)(\\:\\(\\w+\\)\\w+)*[\\;|\\{]+";
static NSString *const HACDocumentManagerExtractParam = @"\\w+\\:\\((\\w+)\\)(\\w+)";

@implementation HACDocumentManager

+(BOOL)handleInvocation:(XCSourceEditorCommandInvocation *)invocation {
    BOOL ret = NO;
    NSString *documents2Add = [self analyzeInvocation:invocation];
    
    if (documents2Add) {
        @try {
            XCSourceTextRange *selection = invocation.buffer.selections.firstObject;
            NSInteger index = selection.start.line;
            [invocation.buffer.lines insertObject:documents2Add atIndex:index+1];
            ret = YES;
        } @catch (NSException *exception) {
            NSLog(@"%@", exception);
        } @finally {
            
        }
    }
    return NO;
}

+ (NSString *)filterBlankAndBlankLines:(NSString *)str {
    NSArray* words = [str componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* nospacestring = [words componentsJoinedByString:@""];
    return nospacestring;
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
    NSTextCheckingResult *firstResult = [r_isFunc firstMatchInString:content options:0 range:NSMakeRange(0, [content length])];
    if (firstResult) {
        NSRange matchRange = [firstResult range];
        NSString *matchStr = [content substringWithRange:matchRange];
        if (firstResult.numberOfRanges == 4) {
            NSRange range1 = [firstResult rangeAtIndex:1];
            returnParam = [content substringWithRange:range1];
            NSRange range2 = [firstResult rangeAtIndex:2];
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
        }
    }
    if (!error) {
        return [HACDocument createDocumentsWithFuncName:funcName returnParam:returnParam params:params];
    }
    return nil;
}
@end
