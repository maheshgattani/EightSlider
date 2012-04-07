//
//  EightSliderViewController.m
//  EightSlider
//
//  Created by mahesh gattani on 06/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EightSliderViewController.h"
#import "GridView.h"

@interface EightSliderViewController () <GridViewDataSource>
@property (nonatomic, weak) IBOutlet GridView* gridView;
@property (weak, nonatomic) IBOutlet UILabel *helpText;
@property (nonatomic) int numberOfTurnsUserTakes;
@end

@implementation EightSliderViewController
@synthesize gridView = _gridView;
@synthesize helpText = _helpText;
@synthesize mind = _mind;
@synthesize numberOfTurnsUserTakes = _numberOfTurnsUserTakes;

- (IBAction)gameInfo:(UIButton *)sender 
{
    sender.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [self presentInfo];
}

- (void)presentInfo
{
    NSString *info = @"This is the age old 8 Slider Game. Swipe to move the tiles. \n\nAt any point of time, you can use hint to find if you making the right moves. But dont always use the hint, otherwise the game wont be as much fun. But you already know that :)";
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" 
                                                        message:info 
                                                       delegate:nil 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil];
    
    [alertView show];
}

- (IBAction)hint:(UIButton *)sender 
{
    if(([self.helpText.text isEqualToString:@""] || [self.helpText isHidden]) && ([[[sender titleLabel] text] isEqualToString:@"Help Me!"])){
        [self.helpText setHidden:NO];
        [self setHelpLabelText];
        [sender setTitle:@"I'm awesome, I dont need help" forState: UIControlStateNormal];
    }
    else {
        [self.helpText setHidden:YES];
        [sender setTitle:@"Help Me!" forState: UIControlStateNormal];
    }
}

- (void) setHelpLabelText
{
    NSString* steps= [self.mind distanceToOptimalSolution];
    NSString* label = [NSString stringWithFormat:@"You are %@ steps away from best solution", steps];
    [self.helpText setText:label];  
}

- (IBAction)newGame 
{
    [self startNewGame];
}

- (EightSliderMind*) mind
{
    if (_mind == nil) {
        _mind = [[EightSliderMind alloc] init];
    }
    
    return _mind;
}

- (void) setGridView:(GridView *)gridView
{
    
    _gridView = gridView;
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self.gridView action:@selector(swipe:)];
    [swipeRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.gridView addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self.gridView action:@selector(swipe:)];
    [swipeLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.gridView addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeTop = [[UISwipeGestureRecognizer alloc] initWithTarget:self.gridView action:@selector(swipe:)];
    [swipeTop setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self.gridView addGestureRecognizer:swipeTop];

    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self.gridView action:@selector(swipe:)];
    [swipeDown setDirection:(UISwipeGestureRecognizerDirectionDown )];
    [self.gridView addGestureRecognizer:swipeDown];
    
    self.gridView.dataSource = self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self startNewGame];
}

- (void) swapObjects : (int) indexOfObjectOne : (int) indexOfObjectTwo
{
    [self.mind.state exchangeObjectAtIndex:(indexOfObjectTwo-1) withObjectAtIndex:(indexOfObjectOne-1)];
    [self.gridView setNeedsDisplay];
    if(![[self.helpText text] isEqualToString:@""]){
        [self setHelpLabelText];
    }
    self.numberOfTurnsUserTakes++;
    if([self.mind didWin]){
        NSString* message = [NSString stringWithFormat:@"You have completed the challenge in %d turns. Best possible was %@. Hurray!!", self.numberOfTurnsUserTakes, self.mind.bestForState];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Winner!!" 
                                                        message:message 
                                                       delegate:self
                                              cancelButtonTitle:@"New Game"
                                              otherButtonTitles:nil];
        [alert show];
        
        
    }
}

- (void)startNewGame 
{
    self.mind.state = [self.mind getRandomState];
    if(![[self.helpText text] isEqualToString:@""]){    
        [self setHelpLabelText];
    }
    [self.gridView setNeedsDisplay];
}

- (NSMutableArray*) getGridState:(GridView *) sender
{

    
    return self.mind.state;
}

- (void)viewDidUnload {
    [self setHelpText:nil];
    [self setHelpText:nil];
    [super viewDidUnload];
}
@end
