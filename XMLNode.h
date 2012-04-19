//
//  XMLNode.h
//  XMLTree
//
//  Created by Saam Barati on 4/18/12.
//  Copyright (c) 2012 Saam Barati Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLNode : NSObject


@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSDictionary *attributes;
@property (nonatomic, assign) XMLNode *nextSibling;


-(void)addChild:(XMLNode *)node;
-(NSArray *)children;
-(void)addIncomingCharacters:(NSString *)s;
-(NSString *)contents;

@end
