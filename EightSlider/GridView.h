//
//  GridView.h
//  EightSlider
//
//  Created by mahesh gattani on 06/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EightSliderMind.h"
@class GridView;

@protocol GridViewDataSource
@property (nonatomic, weak) EightSliderMind* mind;
- (NSMutableArray*) getGridState:(GridView *) sender;
- (void) swapObjects : (int) indexOfObjectOne : (int) indexOfObjectTwo;
@end
@interface GridView : UIView

@property (nonatomic, weak) IBOutlet id <GridViewDataSource> dataSource;
- (void) swipe:(UISwipeGestureRecognizer *) gesture;
@end
