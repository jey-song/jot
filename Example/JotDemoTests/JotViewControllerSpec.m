//
//  JotViewSpec.m
//  jot
//
//  Created by Laura Skelton on 5/7/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

// Uncomment the line below to record new snapshots.
//#define IS_RECORDING

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define EXP_SHORTHAND
#include <Specta/Specta.h>
#include <Expecta/Expecta.h>
#include <Expecta+Snapshots/EXPMatchers+FBSnapshotTest.h>
#import <jot/JotView.h>
#import <UIKit/UIKit.h>

@interface JotView ()

- (void)handleTapGesture:(UIGestureRecognizer *)recognizer;
- (void)handlePanGesture:(UIGestureRecognizer *)recognizer;
- (void)handlePinchOrRotateGesture:(UIGestureRecognizer *)recognizer;

@end

SpecBegin(JotView)

describe(@"JotView", ^{
    __block JotView *jotView;
    __block UIViewController *containerViewController;
    
    beforeEach(^{
        containerViewController = [UIViewController new];
        containerViewController.view.backgroundColor = [UIColor whiteColor];
        containerViewController.view.frame = CGRectMake(0.f, 0.f, 400.f, 600.f);

        jotView = [JotView new];
        jotView.frame = CGRectMake(0.f, 0.f, 400.f, 600.f);
        jotView.state = JotViewStateText;
        jotView.textString = @"Hello World";
        jotView.textColor = [UIColor blackColor];
        [containerViewController.view addSubview:jotView];
        jotView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    });
    
    it(@"can be created", ^{
        expect(jotView).toNot.beNil();
    });
    
    it(@"displays the string", ^{
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"TextString");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"TextString");
    });
    
    it(@"clears the string", ^{
        [jotView clearText];
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"ClearText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"ClearText");
    });
    
    it(@"clears drawing", ^{
        jotView.state = JotViewStateDrawing;
        jotView.drawingConstantStrokeWidth = NO;
        jotView.drawingColor = [UIColor cyanColor];
        jotView.drawingStrokeWidth = 8.f;
        [jotView layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingColor = [UIColor greenColor];
        jotView.drawingStrokeWidth = 15.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingConstantStrokeWidth = YES;
        jotView.drawingColor = [UIColor magentaColor];
        jotView.drawingStrokeWidth = 10.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView clearAll];
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"ClearDrawing");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"ClearDrawing");
    });
    
    it(@"clears all", ^{
        jotView.state = JotViewStateDrawing;
        jotView.drawingConstantStrokeWidth = NO;
        jotView.drawingColor = [UIColor cyanColor];
        jotView.drawingStrokeWidth = 8.f;
        [jotView layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingColor = [UIColor greenColor];
        jotView.drawingStrokeWidth = 15.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingConstantStrokeWidth = YES;
        jotView.drawingColor = [UIColor magentaColor];
        jotView.drawingStrokeWidth = 10.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView clearAll];
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"ClearAll");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"ClearAll");
    });
    
    it(@"sets the font", ^{
        jotView.font = [UIFont boldSystemFontOfSize:50.f];
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"Font");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"Font");
    });
    
    it(@"sets the font size", ^{
        jotView.fontSize = 80.f;
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"FontSize");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"FontSize");
    });
    
    it(@"sets the text color", ^{
        jotView.textColor = [UIColor magentaColor];
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"TextColor");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"TextColor");
    });
    
    it(@"sets the text editing alignment to left if fitOriginalFontSizeToViewWidth is false", ^{
        [jotView layoutIfNeeded];
        jotView.textString = @"The quick brown fox jumped over the lazy dog.";
        jotView.fitOriginalFontSizeToViewWidth = NO;
        jotView.state = JotViewStateEditingText;
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"TextAlignmentLeftInEditMode");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"TextAlignmentLeftInEditMode");
    });
    
    it(@"sets the text alignment to left", ^{
        [jotView layoutIfNeeded];
        jotView.fitOriginalFontSizeToViewWidth = YES;
        jotView.textString = @"The quick brown fox jumped over the lazy dog.";
        jotView.fontSize = 60.f;
        jotView.textAlignment = NSTextAlignmentLeft;
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"TextAlignmentLeft");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"TextAlignmentLeft");
    });
    
    it(@"sets the text alignment to center", ^{
        [jotView layoutIfNeeded];
        jotView.fitOriginalFontSizeToViewWidth = YES;
        jotView.textString = @"The quick brown fox jumped over the lazy dog.";
        jotView.fontSize = 60.f;
        jotView.textAlignment = NSTextAlignmentCenter;
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"TextAlignmentCenter");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"TextAlignmentCenter");
    });
    
    it(@"sets the text alignment to right", ^{
        [jotView layoutIfNeeded];
        jotView.fitOriginalFontSizeToViewWidth = YES;
        jotView.textString = @"The quick brown fox jumped over the lazy dog.";
        jotView.fontSize = 60.f;
        jotView.textAlignment = NSTextAlignmentRight;
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"TextAlignmentRight");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"TextAlignmentRight");
    });
    
    it(@"sets the text insets", ^{
        [jotView layoutIfNeeded];
        jotView.fitOriginalFontSizeToViewWidth = YES;
        jotView.textString = @"The quick brown fox jumped over the lazy dog.";
        jotView.fontSize = 60.f;
        jotView.textAlignment = NSTextAlignmentLeft;
        jotView.initialTextInsets = UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f);
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"TextInsets");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"TextInsets");
    });
    
    it(@"draws constant width lines", ^{
        jotView.state = JotViewStateDrawing;
        jotView.drawingConstantStrokeWidth = YES;
        jotView.drawingColor = [UIColor magentaColor];
        jotView.drawingStrokeWidth = 10.f;
        [jotView layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[given([mockTouch locationInView:anything()])
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]];
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"ConstantWidthDrawing");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"ConstantWidthDrawing");
    });
    
    it(@"draws variable width lines", ^{
        jotView.state = JotViewStateDrawing;
        jotView.drawingConstantStrokeWidth = NO;
        jotView.drawingColor = [UIColor cyanColor];
        jotView.drawingStrokeWidth = 8.f;
        [jotView layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[given([mockTouch locationInView:anything()])
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]];
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
#ifdef IS_RECORDING
        // NOTE: We can't force the touchesMoved methods to be called an exact time interval
        // apart, which means the velocity will differ slightly each time this is run, and
        // the snapshot test will fail since it is not pixel-perfect. This records
        // an image for visual confirmation but does not automatically check whether it is valid
        // against a previous image.
        expect(containerViewController.view).notTo.recordSnapshotNamed(@"VariableWidthDrawing");
#endif
    });
    
    it(@"draws all line types", ^{
        jotView.state = JotViewStateDrawing;
        jotView.drawingConstantStrokeWidth = NO;
        jotView.drawingColor = [UIColor cyanColor];
        jotView.drawingStrokeWidth = 8.f;
        [jotView layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingColor = [UIColor greenColor];
        jotView.drawingStrokeWidth = 15.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingConstantStrokeWidth = YES;
        jotView.drawingColor = [UIColor magentaColor];
        jotView.drawingStrokeWidth = 10.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
#ifdef IS_RECORDING
        // NOTE: We can't force the touchesMoved methods to be called an exact time interval
        // apart, which means the velocity will differ slightly each time this is run, and
        // the snapshot test will fail since it is not pixel-perfect. This records
        // an image for visual confirmation but does not automatically check whether it is valid
        // against a previous image.
        expect(containerViewController.view).notTo.recordSnapshotNamed(@"DrawAllTypes");
#endif
    });
    
    it(@"handles pan gestures for large text", ^{
        [jotView layoutIfNeeded];
        jotView.fitOriginalFontSizeToViewWidth = YES;
        jotView.textString = @"The quick brown fox jumped over the lazy dog.";
        jotView.fontSize = 60.f;
        jotView.textAlignment = NSTextAlignmentLeft;
        jotView.initialTextInsets = UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f);
        [jotView layoutIfNeeded];
        
        UIPanGestureRecognizer *mockPanRecognizer = mock([UIPanGestureRecognizer class]);
        
        [[[given([mockPanRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPanRecognizer translationInView:anything()])
         willReturn:[NSValue valueWithCGPoint:CGPointMake(100.f, 150.f)]];
        
        [jotView handlePanGesture:mockPanRecognizer];
        [jotView handlePanGesture:mockPanRecognizer];
        [jotView handlePanGesture:mockPanRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"PanGestureLargeText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"PanGestureLargeText");
    });
    
    it(@"handles pan gestures for single line text", ^{
        [jotView layoutIfNeeded];
        
        UIPanGestureRecognizer *mockPanRecognizer = mock([UIPanGestureRecognizer class]);
        
        [[[given([mockPanRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPanRecognizer translationInView:anything()])
         willReturn:[NSValue valueWithCGPoint:CGPointMake(100.f, 150.f)]];
        
        [jotView handlePanGesture:mockPanRecognizer];
        [jotView handlePanGesture:mockPanRecognizer];
        [jotView handlePanGesture:mockPanRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"PanGestureSingleLineText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"PanGestureSingleLineText");
    });
    
    it(@"handles rotate gestures for large text", ^{
        jotView.fitOriginalFontSizeToViewWidth = YES;
        jotView.textAlignment = NSTextAlignmentLeft;
        [jotView layoutIfNeeded];
        jotView.textString = @"The quick brown fox jumped over the lazy dog.";
        jotView.fontSize = 60.f;
        jotView.initialTextInsets = UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f);
        [jotView layoutIfNeeded];
        
        UIRotationGestureRecognizer *mockRotationRecognizer = mock([UIRotationGestureRecognizer class]);
        
        [[[given([mockRotationRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockRotationRecognizer rotation])
         willReturn:@(0.75f)];
        
        [jotView handlePinchOrRotateGesture:mockRotationRecognizer];
        [jotView handlePinchOrRotateGesture:mockRotationRecognizer];
        [jotView handlePinchOrRotateGesture:mockRotationRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"RotationGestureLargeText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"RotationGestureLargeText");
    });
    
    it(@"handles rotate gestures for single line text", ^{
        [jotView layoutIfNeeded];
        
        UIRotationGestureRecognizer *mockRotationRecognizer = mock([UIRotationGestureRecognizer class]);
        
        [[[given([mockRotationRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockRotationRecognizer rotation])
         willReturn:@(0.75f)];
        
        [jotView handlePinchOrRotateGesture:mockRotationRecognizer];
        [jotView handlePinchOrRotateGesture:mockRotationRecognizer];
        [jotView handlePinchOrRotateGesture:mockRotationRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"RotationGestureSingleLineText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"RotationGestureSingleLineText");
    });
    
    it(@"handles pinch gestures for large text", ^{
        [jotView layoutIfNeeded];
        jotView.fitOriginalFontSizeToViewWidth = YES;
        jotView.textString = @"The quick brown fox jumped over the lazy dog.";
        jotView.fontSize = 60.f;
        jotView.textAlignment = NSTextAlignmentLeft;
        jotView.initialTextInsets = UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f);
        [jotView layoutIfNeeded];
        
        UIPinchGestureRecognizer *mockPinchRecognizer = mock([UIPinchGestureRecognizer class]);
        
        [[[given([mockPinchRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPinchRecognizer scale])
         willReturn:@(0.25f)];
        
        [jotView handlePinchOrRotateGesture:mockPinchRecognizer];
        [jotView handlePinchOrRotateGesture:mockPinchRecognizer];
        [jotView handlePinchOrRotateGesture:mockPinchRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"PinchGestureLargeText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"PinchGestureLargeText");
    });
    
    it(@"handles pinch gestures for single line text", ^{
        [jotView layoutIfNeeded];
        
        UIPinchGestureRecognizer *mockPinchRecognizer = mock([UIPinchGestureRecognizer class]);
        
        [[[given([mockPinchRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPinchRecognizer scale])
         willReturn:@(0.25f)];
        
        [jotView handlePinchOrRotateGesture:mockPinchRecognizer];
        [jotView handlePinchOrRotateGesture:mockPinchRecognizer];
        [jotView handlePinchOrRotateGesture:mockPinchRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"PinchGestureSingleLineText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"PinchGestureSingleLineText");
    });
    
    it(@"handles zoom in pinch gestures for large text", ^{
        [jotView layoutIfNeeded];
        jotView.fitOriginalFontSizeToViewWidth = YES;
        jotView.textString = @"The quick brown fox jumped over the lazy dog.";
        jotView.fontSize = 60.f;
        jotView.textAlignment = NSTextAlignmentLeft;
        jotView.initialTextInsets = UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f);
        [jotView layoutIfNeeded];
        
        UIPinchGestureRecognizer *mockPinchRecognizer = mock([UIPinchGestureRecognizer class]);
        
        [[[given([mockPinchRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPinchRecognizer scale])
         willReturn:@(3.f)];
        
        [jotView handlePinchOrRotateGesture:mockPinchRecognizer];
        [jotView handlePinchOrRotateGesture:mockPinchRecognizer];
        [jotView handlePinchOrRotateGesture:mockPinchRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"PinchGestureZoomLargeText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"PinchGestureZoomLargeText");
    });
    
    it(@"handles zoom in pinch gestures for single line text", ^{
        [jotView layoutIfNeeded];
        
        UIPinchGestureRecognizer *mockPinchRecognizer = mock([UIPinchGestureRecognizer class]);
        
        [[[given([mockPinchRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPinchRecognizer scale])
         willReturn:@(3.f)];
        
        [jotView handlePinchOrRotateGesture:mockPinchRecognizer];
        [jotView handlePinchOrRotateGesture:mockPinchRecognizer];
        [jotView handlePinchOrRotateGesture:mockPinchRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"PinchGestureZoomSingleLineText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"PinchGestureZoomSingleLineText");
    });
    
    it(@"handles pinch zoom and pan gestures for large text", ^{
        [jotView layoutIfNeeded];
        jotView.fitOriginalFontSizeToViewWidth = YES;
        jotView.textString = @"The quick brown fox jumped over the lazy dog.";
        jotView.fontSize = 60.f;
        jotView.textAlignment = NSTextAlignmentLeft;
        jotView.initialTextInsets = UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f);
        [jotView layoutIfNeeded];
        
        UIPanGestureRecognizer *mockPanRecognizer = mock([UIPanGestureRecognizer class]);
        
        [[[given([mockPanRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPanRecognizer translationInView:anything()])
         willReturn:[NSValue valueWithCGPoint:CGPointMake(100.f, 150.f)]];
        
        UIPinchGestureRecognizer *mockPinchRecognizer = mock([UIPinchGestureRecognizer class]);
        
        [[[given([mockPinchRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPinchRecognizer scale])
         willReturn:@(0.15f)];
        
        UIRotationGestureRecognizer *mockRotationRecognizer = mock([UIRotationGestureRecognizer class]);
        
        [[[given([mockRotationRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockRotationRecognizer rotation])
         willReturn:@(0.75f)];
        
        [jotView handlePanGesture:mockPanRecognizer];
        [jotView handlePinchOrRotateGesture:mockRotationRecognizer];
        [jotView handlePinchOrRotateGesture:mockPinchRecognizer];
        
        [jotView handlePanGesture:mockPanRecognizer];
        [jotView handlePinchOrRotateGesture:mockRotationRecognizer];
        [jotView handlePinchOrRotateGesture:mockPinchRecognizer];
        
        [jotView handlePanGesture:mockPanRecognizer];
        [jotView handlePinchOrRotateGesture:mockRotationRecognizer];
        [jotView handlePinchOrRotateGesture:mockPinchRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"PinchZoomPanGestureLargeText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"PinchZoomPanGestureLargeText");
    });
    
    it(@"handles pinch zoom and pan gestures for single line text", ^{
        [jotView layoutIfNeeded];
        
        UIPanGestureRecognizer *mockPanRecognizer = mock([UIPanGestureRecognizer class]);
        
        [[[given([mockPanRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPanRecognizer translationInView:anything()])
         willReturn:[NSValue valueWithCGPoint:CGPointMake(100.f, 150.f)]];
        
        UIPinchGestureRecognizer *mockPinchRecognizer = mock([UIPinchGestureRecognizer class]);
        
        [[[given([mockPinchRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPinchRecognizer scale])
         willReturn:@(0.15f)];
        
        UIRotationGestureRecognizer *mockRotationRecognizer = mock([UIRotationGestureRecognizer class]);
        
        [[[given([mockRotationRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockRotationRecognizer rotation])
         willReturn:@(0.75f)];
        
        [jotView handlePanGesture:mockPanRecognizer];
        [jotView handlePinchOrRotateGesture:mockRotationRecognizer];
        [jotView handlePinchOrRotateGesture:mockPinchRecognizer];
        
        [jotView handlePanGesture:mockPanRecognizer];
        [jotView handlePinchOrRotateGesture:mockRotationRecognizer];
        [jotView handlePinchOrRotateGesture:mockPinchRecognizer];
        
        [jotView handlePanGesture:mockPanRecognizer];
        [jotView handlePinchOrRotateGesture:mockRotationRecognizer];
        [jotView handlePinchOrRotateGesture:mockPinchRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"PinchZoomPanGestureSingleLineText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"PinchZoomPanGestureSingleLineText");
    });
    
    it(@"handles pinch gestures for single line text", ^{
        [jotView layoutIfNeeded];
        
        UIPinchGestureRecognizer *mockPinchRecognizer = mock([UIPinchGestureRecognizer class]);
        
        [[[given([mockPinchRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPinchRecognizer scale])
         willReturn:@(0.25f)];
        
        [jotView handlePinchOrRotateGesture:mockPinchRecognizer];
        [jotView handlePinchOrRotateGesture:mockPinchRecognizer];
        [jotView handlePinchOrRotateGesture:mockPinchRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"PinchGestureSingleLineText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"PinchGestureSingleLineText");
    });
    
    it(@"renders all drawing types to an image at view size", ^{
        jotView.state = JotViewStateDrawing;
        jotView.drawingConstantStrokeWidth = NO;
        jotView.drawingColor = [UIColor cyanColor];
        jotView.drawingStrokeWidth = 8.f;
        [jotView layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingColor = [UIColor greenColor];
        jotView.drawingStrokeWidth = 15.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingConstantStrokeWidth = YES;
        jotView.drawingColor = [UIColor magentaColor];
        jotView.drawingStrokeWidth = 10.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        UIImage *renderedImage = [jotView renderImage];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:renderedImage];
        imageView.backgroundColor = [UIColor lightGrayColor];
        
#ifdef IS_RECORDING
        // NOTE: We can't force the touchesMoved methods to be called an exact time interval
        // apart, which means the velocity will differ slightly each time this is run, and
        // the snapshot test will fail since it is not pixel-perfect. This records
        // an image for visual confirmation but does not automatically check whether it is valid
        // against a previous image.
        expect(imageView).notTo.recordSnapshotNamed(@"RenderDrawingAllTypes");
#endif
    });
    
    it(@"renders all drawing types to an image at a larger scale", ^{
        jotView.state = JotViewStateDrawing;
        jotView.drawingConstantStrokeWidth = NO;
        jotView.drawingColor = [UIColor cyanColor];
        jotView.drawingStrokeWidth = 8.f;
        [jotView layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingColor = [UIColor greenColor];
        jotView.drawingStrokeWidth = 15.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingConstantStrokeWidth = YES;
        jotView.drawingColor = [UIColor magentaColor];
        jotView.drawingStrokeWidth = 10.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        UIImage *renderedImage = [jotView renderImageWithScale:2.f];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:renderedImage];
        imageView.backgroundColor = [UIColor lightGrayColor];
        
#ifdef IS_RECORDING
        // NOTE: We can't force the touchesMoved methods to be called an exact time interval
        // apart, which means the velocity will differ slightly each time this is run, and
        // the snapshot test will fail since it is not pixel-perfect. This records
        // an image for visual confirmation but does not automatically check whether it is valid
        // against a previous image.
        expect(imageView).notTo.recordSnapshotNamed(@"RenderDrawingAllTypesDoubleSize");
#endif
    });
    
    it(@"renders all drawing types on a color at double view size", ^{
        jotView.state = JotViewStateDrawing;
        jotView.drawingConstantStrokeWidth = NO;
        jotView.drawingColor = [UIColor cyanColor];
        jotView.drawingStrokeWidth = 8.f;
        [jotView layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingColor = [UIColor greenColor];
        jotView.drawingStrokeWidth = 15.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingConstantStrokeWidth = YES;
        jotView.drawingColor = [UIColor magentaColor];
        jotView.drawingStrokeWidth = 10.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        UIImage *renderedImage = [jotView renderImageWithScale:2.f onColor:[UIColor yellowColor]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:renderedImage];
        imageView.backgroundColor = [UIColor lightGrayColor];
        
#ifdef IS_RECORDING
        // NOTE: We can't force the touchesMoved methods to be called an exact time interval
        // apart, which means the velocity will differ slightly each time this is run, and
        // the snapshot test will fail since it is not pixel-perfect. This records
        // an image for visual confirmation but does not automatically check whether it is valid
        // against a previous image.
        expect(imageView).notTo.recordSnapshotNamed(@"RenderDrawingAllTypesOnAColor");
#endif
    });
    
    it(@"renders all drawing types on a color at view size", ^{
        jotView.state = JotViewStateDrawing;
        jotView.drawingConstantStrokeWidth = NO;
        jotView.drawingColor = [UIColor cyanColor];
        jotView.drawingStrokeWidth = 8.f;
        [jotView layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingColor = [UIColor greenColor];
        jotView.drawingStrokeWidth = 15.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingConstantStrokeWidth = YES;
        jotView.drawingColor = [UIColor magentaColor];
        jotView.drawingStrokeWidth = 10.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        UIImage *renderedImage = [jotView renderImageOnColor:[UIColor yellowColor]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:renderedImage];
        imageView.backgroundColor = [UIColor lightGrayColor];
        
#ifdef IS_RECORDING
        // NOTE: We can't force the touchesMoved methods to be called an exact time interval
        // apart, which means the velocity will differ slightly each time this is run, and
        // the snapshot test will fail since it is not pixel-perfect. This records
        // an image for visual confirmation but does not automatically check whether it is valid
        // against a previous image.
        expect(imageView).notTo.recordSnapshotNamed(@"RenderDrawingAllTypesOnAColor");
#endif
    });
    
    it(@"draws all path types on top of a background image", ^{
        jotView.state = JotViewStateDrawing;
        jotView.drawingConstantStrokeWidth = NO;
        jotView.drawingColor = [UIColor cyanColor];
        jotView.drawingStrokeWidth = 8.f;
        [jotView layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingColor = [UIColor greenColor];
        jotView.drawingStrokeWidth = 15.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingConstantStrokeWidth = YES;
        jotView.drawingColor = [UIColor magentaColor];
        jotView.drawingStrokeWidth = 10.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        UIImage *testImage = [UIImage imageNamed:@"JotTestImage.png"];
        UIImage *renderedImage = [jotView drawOnImage:testImage];
        
#ifdef IS_RECORDING
        UIImageView *imageView = [[UIImageView alloc] initWithImage:renderedImage];
        // NOTE: We can't force the touchesMoved methods to be called an exact time interval
        // apart, which means the velocity will differ slightly each time this is run, and
        // the snapshot test will fail since it is not pixel-perfect. This records
        // an image for visual confirmation but does not automatically check whether it is valid
        // against a previous image.
        expect(imageView).notTo.recordSnapshotNamed(@"DrawAllTypesOnBackgroundImage");
#else
        expect(renderedImage).toNot.beNil();
#endif
    });
    
    it(@"doesn't draw when in text mode", ^{
        jotView.state = JotViewStateText;
        jotView.drawingConstantStrokeWidth = NO;
        jotView.drawingColor = [UIColor cyanColor];
        jotView.drawingStrokeWidth = 8.f;
        [jotView layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingColor = [UIColor greenColor];
        jotView.drawingStrokeWidth = 15.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingConstantStrokeWidth = YES;
        jotView.drawingColor = [UIColor magentaColor];
        jotView.drawingStrokeWidth = 10.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"DoesntDrawInTextMode");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"DoesntDrawInTextMode");
    });
    
    it(@"doesn't draw and hides text when in text edit mode", ^{
        jotView.state = JotViewStateEditingText;
        jotView.textAlignment = NSTextAlignmentLeft;
        jotView.drawingConstantStrokeWidth = NO;
        jotView.drawingColor = [UIColor cyanColor];
        jotView.drawingStrokeWidth = 8.f;
        [jotView layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingColor = [UIColor greenColor];
        jotView.drawingStrokeWidth = 15.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingConstantStrokeWidth = YES;
        jotView.drawingColor = [UIColor magentaColor];
        jotView.drawingStrokeWidth = 10.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"DoesntDrawInTextEditMode");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"DoesntDrawInTextEditMode");
    });
    
    it(@"doesn't draw when in default mode", ^{
        jotView.state = JotViewStateDefault;
        jotView.drawingConstantStrokeWidth = NO;
        jotView.drawingColor = [UIColor cyanColor];
        jotView.drawingStrokeWidth = 8.f;
        [jotView layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingColor = [UIColor greenColor];
        jotView.drawingStrokeWidth = 15.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotView.drawingConstantStrokeWidth = YES;
        jotView.drawingColor = [UIColor magentaColor];
        jotView.drawingStrokeWidth = 10.f;
        
        [jotView.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotView.drawingContainer touchesEnded:nil withEvent:nil];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"DoesntDrawInDefaultMode");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"DoesntDrawInDefaultMode");
    });
    
    afterEach(^{
        jotView = nil;
        containerViewController = nil;
    });
});

SpecEnd
