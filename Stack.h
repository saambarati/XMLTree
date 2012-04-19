//
//  Stack.h
//  BarcodeScannerPearson
//
//  Created by Saam Barati on 4/16/12.
//  Copyright (c) 2012 Santa Monica College. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject
{
	__block NSMutableArray *stack;
}

-(NSInteger)count;
-(void)push:(id)obj;
-(id)pop;
-(id)peek;
-(void)applyBlockToAllInStack:(void (^)(id obj))block;


@end
