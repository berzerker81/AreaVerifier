//
//  ViewController.m
//  AreaVerifier
//
//  Created by 장웅 on 2018. 4. 16..
//  Copyright © 2018년 장웅. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *roomImage;
@property (weak, nonatomic) IBOutlet UILabel *lbImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"room_dummy2" ofType:@"jpg"];
    UIImage * image = [UIImage imageWithContentsOfFile:path];
    
    NSString * sizeStr = [NSString stringWithFormat:@"W - %f H - %f",image.size.width,image.size.height];
    
    [self.lbImage setText:[self.lbImage.text stringByAppendingString:sizeStr]];
    [self.roomImage setImage:image];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    AreaView * arv = (AreaView*)[self.view viewWithTag:10];
    if(arv)
    {
       [arv redraw:self.roomImage.frame];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showArea:(UIButton *)sender {
    
    if(sender.selected == NO)
    {
        AreaView * arv = [[AreaView alloc] initWithFrame:self.roomImage.frame];
        arv.tag = 10;
        arv.delegate = self;
        arv.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
        [self.view addSubview:arv];
        
    }else
    {
        UIView * arv = [self.view viewWithTag:10];
        [arv removeFromSuperview];
    }
    
    
    sender.selected = !sender.selected;
}

#pragma mark - delegate

- (CGSize)AreaViewStandardCoordinate
{
    return CGSizeMake(1000, 1000);
}

- (void)AreaViewStandardCoordinate:(CGSize)coordi points:(NSArray *)points
{
    NSLog(@"%@",points);
}


@end
