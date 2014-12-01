//
//  KeyboardViewController.m
//  Slangin
//
//  Created by bw on 11/23/14.
//  Copyright (c) 2014 rounded. All rights reserved.
//

#define BUTTONWIDTH 34
#define BUTTONHEIGHT 42
#define BUTTONMARGIN 7
#define ROWMARGIN 10

#import "KeyboardViewController.h"

@interface KeyboardViewController ()

@property (nonatomic, strong) UIButton *nextKeyboardButton;
@property (strong, nonatomic) UIView *row1View;
@property (strong, nonatomic) UIView *row2View;
@property (strong, nonatomic) UIView *row3View;
@property (strong, nonatomic) NSArray *row1Buttons;
@property (strong, nonatomic) NSArray *row2Buttons;
@property (strong, nonatomic) NSArray *row3Buttons;
@property (nonatomic) NSInteger currentColorIndex;
@property (strong, nonatomic) UIButton *deleteButton;
@property (strong, nonatomic) UIButton *shiftButton;
@property (strong, nonatomic) UIButton *spaceBarButton;
@property (nonatomic) int shiftStatus;

@end

@implementation KeyboardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupDefaults];
    [self setupViews];
}

- (void)setupDefaults
{
    self.shiftStatus = 0;
}

- (void)setupViews
{
    self.view.backgroundColor = [UIColor colorWithRed:0.23 green:0.16 blue:0.28 alpha:1];
    
    self.currentColorIndex = 0;
    
    [self.view addSubview:self.nextKeyboardButton];
    [self.view addSubview:self.row1View];
    [self.view addSubview:self.row2View];
    [self.view addSubview:self.row3View];
    [self.view addSubview:self.spaceBarButton];
    [self.view addSubview:self.deleteButton];
    [self.view addSubview:self.shiftButton];
    
    self.row1Buttons = [self createButtons:@[@"Q", @"W", @"E", @"R", @"T", @"Y", @"U", @"I", @"O", @"P"]];
    [self.row1Buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        [self.row1View addSubview:button];
    }];

    self.row2Buttons = [self createButtons:@[@"A", @"S", @"D", @"F", @"G", @"H", @"J", @"K", @"L"]];
    [self.row2Buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        [self.row2View addSubview:button];
    }];

    self.row3Buttons = [self createButtons:@[@"Z", @"X", @"C", @"V", @"B", @"N", @"M"]];
    [self.row3Buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        [self.row3View addSubview:button];
    }];

    [self updateViewConstraints];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    [self.nextKeyboardButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view];
    [self.nextKeyboardButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view];

    [self.spaceBarButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view withOffset:-BUTTONMARGIN];
    [self.spaceBarButton autoSetDimension:ALDimensionWidth toSize:5*BUTTONWIDTH];
    [self.spaceBarButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.spaceBarButton autoSetDimension:ALDimensionHeight toSize:BUTTONHEIGHT];

    [self.deleteButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.row3View];
    [self.deleteButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.row3View];
    //    [self.deleteButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-BUTTONMARGIN];
    [self.deleteButton autoSetDimension:ALDimensionWidth toSize:48];
    [self.deleteButton autoSetDimension:ALDimensionHeight toSize:BUTTONHEIGHT];

    [self.shiftButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.row3View];
    [self.shiftButton autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.row3View];
//    [self.shiftButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:BUTTONMARGIN];
    [self.shiftButton autoSetDimension:ALDimensionWidth toSize:49];
    [self.shiftButton autoSetDimension:ALDimensionHeight toSize:BUTTONHEIGHT];

    // Row 1
    [self.row1View autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(ROWMARGIN, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.row1View autoSetDimension:ALDimensionHeight toSize:BUTTONHEIGHT];
    
    [self.row1Buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        [button autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.row1View];
    }];
    [self.row1Buttons autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeTop withFixedSize:BUTTONWIDTH];
    [self.row1Buttons autoSetViewsDimension:ALDimensionHeight toSize:BUTTONHEIGHT];

    // Row 2
    [self.row2View autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.row1View withOffset:ROWMARGIN];
    [self.row2View autoSetDimension:ALDimensionHeight toSize:BUTTONHEIGHT];
    [self.row2View autoSetDimension:ALDimensionWidth toSize:340];
    [self.row2View autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    [self.row2Buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        [button autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.row2View];
    }];
    [self.row2Buttons autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeTop withFixedSize:BUTTONWIDTH];
    [self.row2Buttons autoSetViewsDimension:ALDimensionHeight toSize:BUTTONHEIGHT];

    // Row 3
    [self.row3View autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.row2View withOffset:ROWMARGIN];
    [self.row3View autoSetDimension:ALDimensionHeight toSize:BUTTONHEIGHT];
    [self.row3View autoSetDimension:ALDimensionWidth toSize:270];
    [self.row3View autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    [self.row3Buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        [button autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.row3View];
    }];
    [self.row3Buttons autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeTop withFixedSize:BUTTONWIDTH];
    [self.row3Buttons autoSetViewsDimension:ALDimensionHeight toSize:BUTTONHEIGHT];

}

# pragma mark - Actions

- (void)keyTouchDown:(id)sender
{
    UIButton *button = (UIButton *)sender;
    UIColor *previousColor = button.backgroundColor;
    [button setBackgroundColor:[UIColor whiteColor]];
//    [UIView animateWithDuration:1.0 animations:^{
        [button setBackgroundColor:previousColor];
//    }];
}

- (void)keyTouchUpInside:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSString *title = button.titleLabel.text;
    if (self.shiftStatus == 0) {
        title = title.lowercaseString;
    } else if (self.shiftStatus == 1) {
        self.shiftStatus = 0;
    }
    [self.textDocumentProxy insertText:title];
}

- (void)spaceBarPressed:(id)sender
{
    [self.textDocumentProxy insertText:@" "];
}

- (void)shiftPressed:(id)sender
{
    // we need to handle the scenario in which you double click the shift button, and turn on caps
    
    if (self.shiftStatus == 0) {
        self.shiftStatus++;
    } else if (self.shiftStatus == 1) {
        self.shiftStatus = 0;
    } else {
        self.shiftStatus = 0;
    }
}

- (void)deletePressed:(id)sender
{
    [self.textDocumentProxy deleteBackward];
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

# pragma mark - Getters / Setters

- (NSArray *)createButtons:(NSArray *)titles
{
    NSMutableArray *buttons = [NSMutableArray new];
    
    [titles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = [[UIButton alloc] initForAutoLayout];
        [button setTitle:titles[idx] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[self colors][self.currentColorIndex]];
        [button addTarget:self action:@selector(keyTouchDown:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(keyTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 3;
        button.translatesAutoresizingMaskIntoConstraints = FALSE;
        [buttons addObject:button];
        if (self.currentColorIndex > 5) {
            self.currentColorIndex = 0;
        }
        self.currentColorIndex++;
    }];
    
    return [buttons copy];
}

- (NSArray *)colors
{
    UIColor *orange = [UIColor colorWithRed:0.99 green:0.42 blue:0.27 alpha:1];
    UIColor *yellow = [UIColor colorWithRed:1 green:0.81 blue:0.38 alpha:1];
    UIColor *green = [UIColor colorWithRed:0.36 green:0.79 blue:0.6 alpha:1];
    UIColor *red = [UIColor colorWithRed:0.92 green:0 blue:0.25 alpha:1];
    UIColor *purple = [UIColor colorWithRed:0.66 green:0.27 blue:0.74 alpha:1];
    UIColor *blue = [UIColor colorWithRed:0.32 green:0.69 blue:1 alpha:1];
    
    return @[orange, yellow, green, red, purple, blue, orange, yellow, green, red, purple, blue];
}

-(UIView *)row1View
{
    if (!_row1View) {
        _row1View = [[UIView alloc] initForAutoLayout];
        _row1View.translatesAutoresizingMaskIntoConstraints = FALSE;
    }
    return _row1View;
}

-(UIView *)row2View
{
    if (!_row2View) {
        _row2View = [[UIView alloc] initForAutoLayout];
        _row2View.translatesAutoresizingMaskIntoConstraints = FALSE;
    }
    return _row2View;
}

-(UIView *)row3View
{
    if (!_row3View) {
        _row3View = [[UIView alloc] initForAutoLayout];
        _row3View.translatesAutoresizingMaskIntoConstraints = FALSE;
    }
    return _row3View;
}

-(UIButton *)nextKeyboardButton
{
    if (!_nextKeyboardButton) {
        _nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_nextKeyboardButton setTitle:NSLocalizedString(@"Next Keyboard", @"Title for 'Next Keyboard' button") forState:UIControlStateNormal];
        [_nextKeyboardButton sizeToFit];
        _nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextKeyboardButton;
}

-(UIButton *)spaceBarButton
{
    if (!_spaceBarButton) {
        _spaceBarButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _spaceBarButton.layer.masksToBounds = YES;
        _spaceBarButton.layer.cornerRadius = 3;
        _spaceBarButton.translatesAutoresizingMaskIntoConstraints = FALSE;
        [_spaceBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_spaceBarButton setTitle:@"space" forState:UIControlStateNormal];
        [_spaceBarButton setBackgroundColor:self.colors[3]];
        [_spaceBarButton addTarget:self action:@selector(spaceBarPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _spaceBarButton;
}

-(UIButton *)deleteButton
{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _deleteButton.layer.masksToBounds = YES;
        _deleteButton.layer.cornerRadius = 3;
        _deleteButton.translatesAutoresizingMaskIntoConstraints = FALSE;
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteButton setTitle:@"Del" forState:UIControlStateNormal];
        [_deleteButton setBackgroundColor:self.colors[5]];
        [_deleteButton addTarget:self action:@selector(deletePressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

-(UIButton *)shiftButton
{
    if (!_shiftButton) {
        _shiftButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _shiftButton.layer.masksToBounds = YES;
        _shiftButton.layer.cornerRadius = 3;
        _shiftButton.translatesAutoresizingMaskIntoConstraints = FALSE;
        [_shiftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_shiftButton setTitle:@"^" forState:UIControlStateNormal];
        [_shiftButton setBackgroundColor:self.colors[4]];
        [_shiftButton addTarget:self action:@selector(shiftPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shiftButton;
}

@end
