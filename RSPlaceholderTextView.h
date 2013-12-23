//
//  RSPlaceholderTextView.h
//  RSPlaceholderTextView
//
//  Created by Rogiel Sulzbach on 12/23/13.
//  Copyright (c) 2013 Rogiel Sulzbach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSPlaceholderTextView : UITextView<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet id<UITextViewDelegate> textViewDelegate;

@property (strong, nonatomic) NSString* placeholder;
@property (strong, nonatomic) UIColor*  placeholderTextColor;

@end
