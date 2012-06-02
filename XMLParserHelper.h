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



+ (void)parseAsyncXMLString:(NSString *)xml 
				  withCallback:(void (^)(NSError *err, XMLTree *tree))acallback;

+ (void)parseAsyncXMLData:(NSData *)xml 
				withCallback:(void (^)(NSError *err, XMLTree *tree))acallback;

+(void)parserTest;

@end
