//
//  MovieRatingViewController.m
//  TomatoesApp
//
//  Created by DEV FLOATER 98 on 9/11/14.
//  Copyright (c) 2014 PivotalLabs. All rights reserved.
//

#import "MovieRatingViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

@interface MovieRatingViewController ()

@end

@implementation MovieRatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"";
    
    NSDictionary * ratings = self.movie[@"ratings"];
    NSString * criticString;
    if (ratings[@"critics_rating"]){
        criticString = [NSString stringWithFormat:@"%@ (%@%%)", ratings[@"critics_rating"], ratings[@"critics_score"]];
    } else {
        criticString = @"No Reviews Yet";
    }
    
    NSString * audString;
    
    if ([ratings[@"audience_score"] intValue] > 0){
        audString = [NSString stringWithFormat:@"%@ (%@%%)", ratings[@"audience_rating"], ratings[@"audience_score"]];
    } else {
        audString = @"No Score Yet";
    }

    [(UILabel *)[self.view viewWithTag:200] setText:self.movie[@"title"]];
    [(UILabel *)[self.view viewWithTag:206] setText:[NSString stringWithFormat:@"(%@)",self.movie[@"year"]]];
    [(UILabel *)[self.view viewWithTag:204] setText:criticString];
    [(UILabel *)[self.view viewWithTag:205] setText:audString];
    
    NSDictionary * posters = self.movie[@"posters"];
    
    NSInteger cutOff = [posters[@"detailed"] length] - 7;
    NSString * parsedURL = [posters[@"detailed"] substringToIndex:cutOff];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@ori.jpg", parsedURL]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    UIImageView * poster = (UIImageView *)[self.view viewWithTag:201];
    
    [poster setImageWithURLRequest:request placeholderImage:nil success:nil failure:nil];
    
    
    UIImage * criticImg;
    
    if ([ratings[@"critics_score"] intValue] > 90){
        criticImg = [UIImage imageNamed:@"certified.png"];
    } else if ([ratings[@"critics_score"] intValue] > 50){
        criticImg = [UIImage imageNamed:@"fresh.png"];
    } else if ([ratings[@"critics_score"] intValue] >= 0){
        criticImg = [UIImage imageNamed:@"rotten.png"];
    } else {
        criticImg = nil;
    }
    
    UIImage * audImg;

    if ([ratings[@"audience_score"] integerValue] > 60){
        audImg = [UIImage imageNamed:@"upright.png"];
    } else if (ratings[@"audience_rating"] == nil && [ratings[@"audience_score"] intValue] > 0){
        audImg = [UIImage imageNamed:@"want.png"];
    } else if ([ratings[@"audience_score"] intValue] > 0){
        audImg = [UIImage imageNamed:@"spilled.png"];
    } else {
        audImg = nil;
    }
    
    UIImageView * criticImgView = (UIImageView *)[self.view viewWithTag:202];
    
    [criticImgView setImage:criticImg];
    
    UIImageView * audImgView = (UIImageView *)[self.view viewWithTag:203];

    audImgView.image = audImg;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
