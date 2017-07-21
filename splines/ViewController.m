//
//  ViewController.m
//  splines
//
//  Created by Oluwapelumi on 5/5/17.
//  Copyright © 2017 Oluwapelumi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//@property (nonatomic, strong) SplineView* b_view;
//@property (nonatomic, strong) UIStepper* iter_step;
//@property (nonatomic, strong) UILabel* iter_label;
//@property (nonatomic, strong) UIButton* clearBtn;
@property (weak, nonatomic) IBOutlet SplineView *b_view;
@property (weak, nonatomic) IBOutlet UIStepper *iter_step;
@property (weak, nonatomic) IBOutlet UILabel *iter_label;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;

- (IBAction)stepperChanged:(UIStepper *)sender;
- (IBAction)clear:(UIButton *)sender;
- (IBAction)receivedTap:(UITapGestureRecognizer *)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_iter_step setValue:_b_view.getIterationNumber];
    [_iter_label setText:[[NSString alloc] initWithFormat:@"%d", [_b_view getIterationNumber]]];
}

- (IBAction)stepperChanged:(UIStepper *)sender {
    [_b_view setIterationNumber:_iter_step.value];
    [_iter_label setText:[[NSString alloc] initWithFormat:@"%d", [_b_view getIterationNumber]]];
}

- (IBAction)clear:(UIButton *)sender {
    [_b_view clearCanvas:sender];
}

- (IBAction)receivedTap:(UITapGestureRecognizer *)sender {
    [_b_view didReceiveTap:sender];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
