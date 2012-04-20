//
//  XMLTree.h
//  XMLTree
//
//  Created by Saam Barati on 4/18/12.
//  Copyright (c) 2012 Saam Barati Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLNode.h"

@interface XMLTree : NSObject

@property (nonatomic, readonly) XMLNode *root;


-(NSString *)treeAsString;
-(NSArray *)getNodesWithTag:(NSString *)tag; //an array of XMLNodes
-(NSDictionary *)getNodesWithTags:(NSArray *)tags; //a dictionary with arrays of XMLNodes for each tag

@end
