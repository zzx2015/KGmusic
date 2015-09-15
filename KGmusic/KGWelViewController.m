//
//  KGWelViewController.m
//  KGmusic
//
//  Created by neuedu on 15/9/15.
//  Copyright (c) 2015年 zzx. All rights reserved.
//

#import "KGWelViewController.h"

#import "KGhomeViewController.h"
#define kStartButtonCenterYRatio 470.f/667.f
#define kPageControlCenterYRatio 637.f/667.f
@interface KGWelViewController ()
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation KGWelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置scrollView 包括显示的图片以及contentSize。
    [self setUpScrollView];//函数是按功能封装的。
    //设置pageControl的点数。
    _pageControl.numberOfPages = 5;
    
    //scrollView填充屏幕，让pageControl处于屏幕的637.f／667.f比例的位置
    _scrollView.frame = [UIScreen mainScreen].bounds;
    _pageControl.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height*kPageControlCenterYRatio);
    // Do any additional setup after loading the view.
}

#pragma  mark 设置scrollView 包括显示的图片以及contentSize。
-(void)setUpScrollView{
    for (int i = 0; i<5; i++) {
        UIImageView * imageView = [[UIImageView alloc]init];
        NSString * imageName = [NSString stringWithFormat:@"introduction_%i",i+1];
        [imageView setImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        if (i==4) {
            //添加“开启音乐之旅”按钮，
            [self addStartButton:imageView];//在这里封装一个函数, 传递一个参数，把第五个view传过去。
            
        }
        
        [_scrollView addSubview:imageView];
    }
    _scrollView.contentSize = CGSizeMake(5*[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger number = (NSUInteger)_scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    _pageControl.currentPage =  number;
}
#pragma mark 添加“开启音乐之旅”按钮
-(void)addStartButton:(UIImageView * )imageView{
    imageView.userInteractionEnabled = YES;
    UIButton * startButton = [[UIButton alloc]init];
    //startButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-122.f)*0.5, 550.f, 122.f, 32.f);
    startButton.bounds = CGRectMake(0, 0, 122.f, 32.f);
    startButton.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height*kStartButtonCenterYRatio);
    [startButton setBackgroundImage:[UIImage imageNamed:@"introduction_enter_nomal"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"introduction_enter_press"] forState:UIControlStateHighlighted];
    //startButton.backgroundColor = [UIColor redColor];
    [imageView addSubview:startButton];
    [startButton addTarget:self action:@selector(startMusicChip:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark 开启音乐之旅
-(void)startMusicChip:(UIButton * )sender{
    //直接将主页设置为window的rootViewController这样就不回再回到欢迎页了。
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIPageViewController * homeVC = [storyBoard instantiateViewControllerWithIdentifier:@"HomePage"];
    [UIApplication sharedApplication].keyWindow.rootViewController = homeVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
