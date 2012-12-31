//
//  UserVariables.h
//  ProjectZero
//
//  Created by Larkin on 12/29/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserVariables : NSObject{

    NSMutableArray * patientPresc;

}

@property (nonatomic, retain) NSMutableArray *patientPresc;

+(UserVariables *)sharedInstance;
+(void)setPresc:(NSMutableArray*)list;

@end
