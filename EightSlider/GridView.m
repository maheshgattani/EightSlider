//
//  GridView.m
//  EightSlider
//
//  Created by mahesh gattani on 06/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GridView.h"

#define ROWS_AND_COLUMNS 3

@interface GridView()
@property (nonatomic) int emptySlot;
@end

@implementation GridView
@synthesize emptySlot;
@synthesize dataSource = _dataSource;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
    }
    return self;
}

- (int) coordinateToIndex:(CGPoint)coordinate
{
    int width = (int)(self.bounds.size.width / ROWS_AND_COLUMNS);
    int height = (int)(self.bounds.size.height / ROWS_AND_COLUMNS);
    int indexWidth = (int)(coordinate.x / width);
    int indexHeight = (int)(coordinate.y / height);
    return (ROWS_AND_COLUMNS*indexHeight) + indexWidth + 1;
}

- (NSString*) canMoveToDirection : (int)fromIndex
{
    return [self getEmptyBlockForPostion:fromIndex];
}

// Needs to be changed if we go from 3 blocks a row to any other number
- (NSString* ) getEmptyBlockForPostion: (int) position
{
    
    int positionEmpty = self.emptySlot;
    if(positionEmpty == 1){
        if(position == 1) return @"NOT";
        else if(position == 2) return @"right";
        else if(position == 4) return @"down";
        else return @"ME";
    }
    else if(positionEmpty == 2){
        if(position == 2) return @"NOT";
        else if(position == 3) return @"right";
        else if(position == 5) return @"down";
        else if(position == 1) return @"left";
        else return @"ME";
    }
    else if(positionEmpty == 3){
        if(position == 3) return @"NOT";
        else if(position == 6) return @"down";
        else if(position == 2) return @"left";
        else return @"ME";
    }
    else if(positionEmpty == 4){
        if(position == 4) return @"NOT";
        else if(position == 5) return @"right";
        else if(position == 7) return @"down";
        else if(position == 1) return @"up";
        else return @"ME";
    }
    else if(positionEmpty == 5){
        if(position == 5) return @"NOT";
        else if(position == 2) return @"up";
        else if(position == 4) return @"left";
        else if(position == 6) return @"right";
        else if(position == 8) return @"down";
        else return @"ME";
    }
    else if(positionEmpty == 6){
        if(position == 6) return @"NOT";
        else if(position == 3) return @"up";
        else if(position == 5) return @"left";
        else if(position == 9) return @"down";
        else return @"ME";
    }
    else if(positionEmpty == 7){
        if(position == 7) return @"NOT";
        else if(position == 4) return @"up";
        else if(position == 8) return @"right";
        else return @"ME";
    }    
    else if(positionEmpty == 8){
        if(position == 8) return @"NOT";
        else if(position == 5) return @"up";
        else if(position == 7) return @"left";
        else if(position == 9) return @"right";
        else return @"ME";
    }    
    else if(positionEmpty == 9){
        if(position == 9) return @"NOT";
        else if(position == 6) return @"up";
        else if(position == 8) return @"left";
        else return @"ME";
    }
    
    return @"0";
}

- (void) swipe:(UISwipeGestureRecognizer *) gesture
{
    CGPoint pointOfTouch = [gesture locationOfTouch:0 inView:self];
    int indexOfMovedBlock = [self coordinateToIndex:pointOfTouch];
    NSString* direction = [self canMoveToDirection:indexOfMovedBlock];
    if (([direction isEqualToString:@"down"] && gesture.direction == UISwipeGestureRecognizerDirectionUp)
        || ([direction isEqualToString:@"up"] && gesture.direction == UISwipeGestureRecognizerDirectionDown)
        || ([direction isEqualToString:@"right"] && gesture.direction == UISwipeGestureRecognizerDirectionLeft)
        || ([direction isEqualToString:@"left"] && gesture.direction == UISwipeGestureRecognizerDirectionRight))
    {
        [self.dataSource swapObjects:indexOfMovedBlock :emptySlot];
    }
}

- (void)drawRect:(CGRect)rect
{
    [[self subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSMutableArray* state = [self.dataSource getGridState:self];
    for (int i = 0; i < [state count]; i++) {

        NSString* position = [state objectAtIndex:i];
        if ([position isEqualToString:@" "]) {
            self.emptySlot = i+1;
            continue;
        }
        NSString* imageName = [NSString stringWithFormat:@"image%@.jpg", position];
        UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        int x = self.bounds.origin.x +  (((int)self.bounds.size.width / ROWS_AND_COLUMNS) * i) % ((int)self.bounds.size.width);
        int y = self.bounds.origin.y +  (((int)self.bounds.size.height / ROWS_AND_COLUMNS) * (int)(i/ROWS_AND_COLUMNS)) % ((int)self.bounds.size.height);
        int width = self.bounds.size.width / ROWS_AND_COLUMNS;
        int height = self.bounds.size.height / ROWS_AND_COLUMNS;
        [imageView1 setFrame:CGRectMake( x , y, width, height)];
        [self addSubview:imageView1];
    }
}

@end
