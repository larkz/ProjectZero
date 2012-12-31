//
//  UserVariables.m
//  ProjectZero
//
//  Created by Larkin on 12/29/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import "UserVariables.h"

@implementation UserVariables

@synthesize patientPresc;


+(UserVariables *)sharedInstance
{
    static UserVariables *myInstance = nil;
    
    if (myInstance == nil){
        myInstance  = [[[self class] alloc] init];
    }
    
    return myInstance;
    
    
}

+(void)setPresc:(NSMutableArray*)list
{
   // patientPresc = list;
}


@end
