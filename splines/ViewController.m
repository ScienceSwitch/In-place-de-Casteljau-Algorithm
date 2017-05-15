//
//  ViewController.m
//  splines
//
//  Created by Oluwapelumi on 5/5/17.
//  Copyright © 2017 Oluwapelumi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) SplineView* b_view;
@property (nonatomic, strong) UIStepper* iter_step;
@property (nonatomic, strong) UILabel* iter_label;
@property (nonatomic, strong) UIButton* clearBtn;
- (void) stepperChanged;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect bounds = self.view.bounds;
    _b_view = [[SplineView alloc] initWithFrame:bounds];
    [self.view addSubview:_b_view];
    
    _iter_step = [[UIStepper alloc] init];
    [_iter_step setValue:_b_view.getIterationNumber];
    [_iter_step setMinimumValue:1.0];
    [_iter_step setMaximumValue:7.0];
    [_iter_step setStepValue:1.0];
    [_iter_step addTarget:self action:@selector(stepperChanged) forControlEvents:UIControlEventValueChanged];
    [_iter_step setTintColor:[UIColor greenColor]];
    
    _iter_label = [[UILabel alloc] init];
    [_iter_label setText:[[NSString alloc] initWithFormat:@"%d", [_b_view getIterationNumber]]];
    [_iter_label setTextAlignment:NSTextAlignmentCenter];
    [_iter_label setBackgroundColor:[UIColor greenColor]];
    
    _clearBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_clearBtn setTitle:@"Clear" forState:UIControlStateNormal];
    [_clearBtn setBackgroundColor:[UIColor greenColor]];
    [_clearBtn addTarget:_b_view action:@selector(clearCanvas:) forControlEvents:UIControlEventTouchUpInside];
    [_clearBtn setFrame:CGRectMake(10.0, bounds.size.height-40-10, 70, 40)];
    [_iter_step setFrame:CGRectMake(CGRectGetMaxX(_clearBtn.frame)+10, CGRectGetMinY(_clearBtn.frame), 40, 40)];
    [_iter_label setFrame:CGRectMake(CGRectGetMaxX(_iter_step.frame)+10, CGRectGetMinY(_iter_step.frame), 40, _iter_step.frame.size.height)];
    
    [self.view addSubview:_clearBtn];
    [self.view addSubview:_iter_step];
    [self.view addSubview:_iter_label];
}

- (void) stepperChanged{
    [_b_view setIterationNumber:_iter_step.value];
    [_iter_label setText:[[NSString alloc] initWithFormat:@"%d", [_b_view getIterationNumber]]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
