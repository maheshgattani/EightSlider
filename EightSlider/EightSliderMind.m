//
//  MindspModel.m
//  minsp
//
//  Created by mahesh gattani on 01/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EightSliderMind.h"

@interface EightSliderMind()
@property (nonatomic, weak) NSDictionary *allStateData;
@property (nonatomic, weak) NSArray *allKeys;
@end

@implementation EightSliderMind

@synthesize state = _state;
@synthesize allStateData = _allStateData;
@synthesize bestForState = _bestForState;
@synthesize allKeys = _allKeys;



- (NSMutableArray* ) state
{
    if (!_state) {
        _state = self.getRandomState;
    }
    
    return _state;
}

- (NSDictionary *) allStateData
{
    if(_allStateData == nil){
        //read from json file
        NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
        _allStateData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    }
    return _allStateData;
}


- (NSInteger) positionOfEmptyBlock
{
    return (int)[self.state indexOfObject:@" "];
}

- (NSMutableArray *) getRandomState
{
    if(self.allKeys == nil){
            self.allKeys = [[self allStateData] allKeys];
    }
    int randomIndex = arc4random() % [self.allKeys count];
    NSString *randomState = [self.allKeys objectAtIndex:randomIndex];
    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:[randomState length]]; 
    
    for (int i=0; i < [randomState length]; i++) 
    { 
        NSRange r = NSMakeRange(i, 1);
        NSString *ichar = [randomState substringWithRange:r]; 
        [characters insertObject:ichar atIndex:i];
    }
    
    NSString *stateString = [characters componentsJoinedByString:@""];
    self.bestForState = [[self allStateData] valueForKey:stateString];
    NSLog(@"BEST FOR STATE %@", self.bestForState);
    return characters;
}

- (NSString*) distanceToOptimalSolution
{
    NSString *stateString = [[self state] componentsJoinedByString:@""];
    return [[self allStateData] valueForKey:stateString];
}

- (BOOL) didWin
{
    NSString *stateString = [[self state] componentsJoinedByString:@""];
    if ([stateString isEqualToString:@"12345678 "]) {
        return YES;
    }
    return NO;

}

@end
