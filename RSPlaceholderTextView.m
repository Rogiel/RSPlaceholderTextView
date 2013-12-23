//
//  RSPlaceholderTextView.m
//  RSPlaceholderTextView
//
//  Created by Rogiel Sulzbach on 12/23/13.
//  Copyright (c) 2013 Rogiel Sulzbach. All rights reserved.
//

#import "RSPlaceholderTextView.h"

@interface RSPlaceholderTextView()
@property (nonatomic, getter = isPlaceholderActive) BOOL placeholderActive;
@end


@implementation RSPlaceholderTextView

-(id)init {
    self = [super init];
    if (self) {
        // Initialization code
        [self doInit];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self doInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self doInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        // Initialization code
        [self doInit];
    }
    return self;
}

-(void)awakeFromNib {
    [self doInit];
}

-(void)doInit {
    self.placeholderTextColor = [UIColor lightGrayColor];
    [super setDelegate:self];
}

-(void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}

-(void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    // Inset the rect
    CGRect rect = UIEdgeInsetsInsetRect(bounds, self.textContainerInset);
    
    if (self.typingAttributes) {
        NSParagraphStyle *style = self.typingAttributes[NSParagraphStyleAttributeName];
        if (style) {
            rect.origin.x += style.headIndent;
            rect.origin.y += style.firstLineHeadIndent;
        }
    }
    
    return rect;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // Drawing code
    if (self.text.length == 0 && self.placeholder) {
        NSDictionary* attributes = @{NSFontAttributeName: self.font,
                                     NSForegroundColorAttributeName: self.placeholderTextColor};
        
        rect = self.textInputView.frame;
        CGSize size = [self.placeholder sizeWithAttributes:attributes];
        
        float yOffset = (rect.size.height - size.height) /2;
        
        // Draw the text
        [self.placeholderTextColor set];
        [self.placeholder drawInRect:CGRectMake(rect.origin.x+5,  rect.origin.y + yOffset, size.width, size.height) withAttributes:attributes];
    }
}

#pragma mark - Delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if([self.textViewDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        [self.textViewDelegate textViewShouldBeginEditing:textView];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if([self.textViewDelegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [self.textViewDelegate textViewShouldEndEditing:textView];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if([self.textViewDelegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.textViewDelegate textViewDidBeginEditing:textView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if([self.textViewDelegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.textViewDelegate textViewDidEndEditing:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([self.textViewDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        return [self.textViewDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    [self setNeedsDisplay];
    if([self.textViewDelegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.textViewDelegate textViewDidChange:textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if([self.textViewDelegate respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        [self.textViewDelegate textViewDidChangeSelection:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if([self.textViewDelegate respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)]) {
        return [self.textViewDelegate textView:textView shouldInteractWithURL:URL inRange:characterRange];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange {
    if([self.textViewDelegate respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:)]) {
        [self.textViewDelegate textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    }
    return YES;
}

@end
