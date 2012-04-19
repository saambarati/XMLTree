//
//  XMLParserHelper.h
//  BarcodeScannerPearson
//
//  Created by Saam Barati on 4/16/12.
//  Copyright (c) 2012 Santa Monica College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLTree.h"

@interface XMLParserHelper : NSObject <NSXMLParserDelegate>

//populated dictionary will have all keys in lower case
//tags to ignore just ignores the specific tags, not its children branches
+ (void)parseSyncXMLString:(NSString *)xml 
				  withCallback:(void (^)(NSError *err, XMLTree *tree))acallback;

+ (void)parseSyncXMLData:(NSData *)xml 
				withCallback:(void (^)(NSError *err, XMLTree *tree))acallback;

+(void)parserTest;

@end
