//
//  MindspModel.h
//  minsp
//
//  Created by mahesh gattani on 01/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EightSliderMind : NSObject

@property (nonatomic, strong) NSMutableArray *state;
@property (nonatomic) NSString* bestForState;
- (NSMutableArray *) getRandomState;
- (NSString*) distanceToOptimalSolution;
- (BOOL) didWin;

@end
