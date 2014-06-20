//
//  TWCoreDataHelper.m
//  Thousend Words
//
//  Created by Michał Kozak on 24.03.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import "TWCoreDataHelper.h"

@implementation TWCoreDataHelper

+(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context = nil;
    
    id delegate = [[UIApplication sharedApplication]delegate];
    if([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    
    return context;
}

@end