//
//  TWTPickerControl.m
//  TWTCommon
//
//  Created by Jeremy Ellison on 8/26/10.
//  Copyright 2010 Two Toasters. All rights reserved.
//

#import "TWTPickerControl.h"
#import "UIView+TWTAdditions.h"
#import "NSString+TWTAdditions.h"

@interface TWTPickerControl (Private)

- (void)updateToolbar;
- (void)updateLabel;

@end

@implementation TWTPickerControl

// todo: The following need to update UI when set. Perhaps a -redraw: method to call after?
@synthesize pickerView = _pickerView;
@synthesize placeholderText = _placeholderText;
@synthesize font = _font;
@synthesize selectedFont = _selectedFont;
@synthesize textLabel = _label;
@synthesize doneButton = _doneButton;
@synthesize nextButton = _nextButton;
@synthesize toolbar = _toolbar;
@synthesize titleView = _titleView;
@synthesize delegate = _delegate;
@synthesize dataSource = _dataSource;
@synthesize selection = _selection;
@synthesize inputView = _myInputView;
@synthesize inputAccessoryView = _myInputAccessoryView;

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		_label = [[UILabel alloc] initWithFrame:self.bounds];
		[self addSubview:_label];
		self.placeholderText = @"Default Text";
		_label.backgroundColor = [UIColor clearColor];
		self.font = _label.font;
		[self addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
		
        _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 48, 320, 150)];
		[_picker sizeToFit];
		_picker.showsSelectionIndicator = YES;
        
		_toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
        
		_picker.dataSource = self;
		_picker.delegate = self;
		
        self.selection = [NSArray array];
		
        self.inputView = _picker;
        self.inputAccessoryView = _toolbar;
        
		[self updateToolbar];
		[self updateLabel];
	}
	return self;
}

- (void)setFont:(UIFont *)font {
	[font retain];
	[_font release];
	_font = font;
	_label.font = font;
}

- (void)dealloc {
	[self removeTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
	_delegate = nil;
	[self resignFirstResponder];
	[_pickerView removeFromSuperview];
	[_picker release];
	[_pickerView release];
	[_toolbar release];
	[_nextButton release];
	[_doneButton release];
	[_label release];
	[_font release];
	_font = nil;
	[_selectedFont release];
	_selectedFont = nil;
	[_dataSource release];
	_dataSource = nil;

	[super dealloc];
}

- (void)updateToolbar {
	[_doneButton release];
	[_nextButton release];
	_doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissPicker:)];
	_nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(nextButtonWasTouched:)];
	if (nil == _titleView) {
		[_toolbar setItems:[NSArray arrayWithObjects:
							_doneButton,
							[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
							_nextButton, nil]];
	} else {
		[_toolbar setItems:[NSArray arrayWithObjects:
							_doneButton,
							[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
							[[[UIBarButtonItem alloc] initWithCustomView:_titleView] autorelease],
							[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
							_nextButton, nil]];
	}
}

- (BOOL)hasSelection {
	return ([self.selection count] > 0 && NO == [self.selection containsObject:[NSNull null]]);
}

- (void)updateLabel {
	if (NO == self.hasSelection) {
		self.textLabel.text = self.placeholderText;
	} else {
		NSMutableArray* array = [NSMutableArray arrayWithCapacity:[self.selection count]];
		for (int i = 0; i < [self.selection count]; i++) {
			NSString* titleForRow = [self pickerView:_picker titleForRow:[[self.selection objectAtIndex:i] intValue] forComponent:i];
			
			if (nil == titleForRow) {
				UIView* viewForRow = [self pickerView:_picker viewForRow:[[self.selection objectAtIndex:i] intValue] forComponent:i reusingView:nil];
				
				if (viewForRow && [viewForRow isKindOfClass:[UILabel class]]) {
					titleForRow = ((UILabel*)viewForRow).text;
				}
				else {
					titleForRow = @"error";
				}
			}
			
			[array addObject:titleForRow];
		}
		if ([_delegate respondsToSelector:@selector(picker:labelTextForChoices:)]) {
			self.textLabel.text = [_delegate picker:self labelTextForChoices:array];
		} else {
			self.textLabel.text = [array componentsJoinedByString:@" "];
		}
	}
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)becomeFirstResponder {
	// replace nulls in selection with 0.
	for (int i = 0; i < [[self.dataSource components] count]; i++) {
		if ([self.selection objectAtIndex:i] == [NSNull null]) {
			[self.selection replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:0]];
			[self pickerView:_picker didSelectRow:0 inComponent:i];
		}
	}
	[self updateLabel];
    return [super becomeFirstResponder];
}

- (void)touchUpInside:(id)sender {
	[self becomeFirstResponder];
}

- (void)nextButtonWasTouched:(id)sender {
	if ([(NSObject*)_delegate respondsToSelector:@selector(picker:nextButtonWasTouched:)]) {
		[_delegate picker:self nextButtonWasTouched:sender];
	}
}

- (void)dismissPicker:(id)sender {
    [self resignFirstResponder];
}

- (void)resetSelection {
	NSMutableArray* array = [NSMutableArray arrayWithCapacity:[[self.dataSource components] count]];
	for (int i = 0; i < [[self.dataSource components] count]; i++) {
		[array addObject:[NSNull null]];
	}
	self.selection = array;
	[self updateLabel];
}

- (void)setSelection:(NSMutableArray *)selection {
	[selection retain];
	[_selection release];
	_selection = selection;
	
	// Ensure the underlying picker selection is correct
	for (NSInteger i = 0; i < [[self.dataSource components] count]; i++) {		
		int row = [[self.dataSource.components objectAtIndex:i] indexOfObject:[selection objectAtIndex:i]];
		[_picker selectRow:row inComponent:i animated:YES];
	}
	
	[self updateLabel];
}

- (NSString*)selectionText {
	if (self.hasSelection) {
		return self.textLabel.text;
	} else {
		return nil;
	}
}

- (void)setDataSource:(TWTPickerDataSource *)source {
	[source retain];
	[_dataSource release];
	_dataSource = source;
	[_picker reloadAllComponents];
	[self resetSelection];
}

- (void)setTitleView:(UIView *)titleView {
	[titleView retain];
	[_titleView release];
	_titleView = titleView;
	[self updateToolbar];
}

- (void)setPlaceholderText:(NSString *)str {
	NSString* newPlaceholder = [str copy];
	[_placeholderText release];
	_placeholderText = newPlaceholder;
	[self updateLabel];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	_label.frame = self.bounds;
}

// Picker View DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return [_dataSource.components count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [[_dataSource.components objectAtIndex:component] count];
}

// Picker View Delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [[_dataSource.components objectAtIndex:component] objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	[self.selection removeObjectAtIndex:component];
	[self.selection insertObject:[NSNumber numberWithInt:row] atIndex:component];
	[self updateLabel];
	[self sizeToFit];
	
	if ([_delegate respondsToSelector:@selector(picker:didSelectChoiceAtIndex:forComponent:)]) {
		[_delegate picker:self didSelectChoiceAtIndex:row forComponent:component];
	}
}

@end
