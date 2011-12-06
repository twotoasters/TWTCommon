//
//  TWTPickerControl.h
//  TWTCommon
//
//  Created by Jeremy Ellison on 8/26/10.
//  Copyright 2010 Two Toasters. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWTPickerDataSource.h"

@protocol TWTPickerDelegate;
@protocol TWTPickerDataSource;

@interface TWTPickerControl : UIControl <UIPickerViewDelegate, UIPickerViewDataSource> {
	UIView* _pickerView;
	UIPickerView* _picker;
	UIToolbar* _toolbar;
	UIBarButtonItem* _nextButton;
	UIBarButtonItem* _doneButton;
	UILabel* _label;
	
	UIFont* _font;
	UIFont* _selectedFont;
	
	NSString* _placeholderText;
	UIView* _titleView;
	
	NSObject<TWTPickerDelegate>* _delegate;
	TWTPickerDataSource* _dataSource;
	
	NSMutableArray* _selection;
}

@property (nonatomic, retain) UIView* inputView;
@property (nonatomic, retain) UIView* inputAccessoryView;

@property (nonatomic, readonly) UIView* pickerView;

/**
 * This text is displayed on the label when no choice has been selected
 */
@property (nonatomic, copy) NSString* placeholderText;

/**
 * The default font for the choice to be displayed in.
 */
@property (nonatomic, retain) UIFont* font;

/**
 * The font to use while the picker is being displayed. Default is nil, and to use the standard font.
 */
@property (nonatomic, retain) UIFont* selectedFont;

/**
 * A reference to the text label that is displaying the selection (or placeholder text).
 * Can be used to change the text color. Don't change the font here, use the font properties.
 */
@property (nonatomic, readonly) UILabel* textLabel;

/*
 * Bar button item that dismisses the picker and triggers the next: delegate method.
 */
@property (nonatomic, readonly) UIBarButtonItem* nextButton;

/**
 * Bar button item that dismisses the picker. This shows up on the left by default.
 */
@property (nonatomic, readonly) UIBarButtonItem* doneButton;

/**
 * Custom view for the center of the toolbar. Defaults to nil.
 */
@property (nonatomic, retain) UIView* titleView;

/**
 * A reference to the toolbar displayed above the picker.
 */
@property (nonatomic, readonly) UIToolbar* toolbar;

/**
 * The TWTPickerDelegate. Not retained.
 */
@property (nonatomic, assign) NSObject<TWTPickerDelegate>* delegate;

/*
 * The DataSource. Should conform to <TTDataSource>
 */
@property (nonatomic, retain) TWTPickerDataSource* dataSource;

/**
 * An array of the current selection. Indexes match components
 */
@property (nonatomic, retain) NSMutableArray* selection;

/**
 * Returns YES when a selection has been made
 */
@property (nonatomic, readonly) BOOL hasSelection;

/**
 * Returns the textual value of the current selection. If there is not
 * a current selection nil will be returned
 */
@property (nonatomic, readonly) NSString* selectionText;

/**
 * Reset the toolbar. Called automatically when you set the title view.
 * Needs to be called if you update the tint color or other nonsense like that.
 */
- (void)updateToolbar;

@end

@protocol TWTPickerDelegate

@optional

- (void)picker:(TWTPickerControl*)picker nextButtonWasTouched:(id)sender;

- (void)picker:(TWTPickerControl*)picker didSelectChoiceAtIndex:(int)index forComponent:(int)component;

- (NSString*)picker:(TWTPickerControl*)picker labelTextForChoices:(NSArray*)choices;

@end
