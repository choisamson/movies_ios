#import <Cedar-iOS/SpecHelper.h>
#import "MovieRatingViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(MovieRatingViewControllerSpec)

describe(@"MovieRatingViewController", ^{
    __block MovieRatingViewController *mrvc;
    
    describe(@"Retrieve data from API and test", ^{
        
        describe(@"-create rating view for Guardians of the Galaxy:", ^{
            it(@"should blank the title bar", ^{
                mrvc = [[MovieRatingViewController alloc] init];
                
                mrvc.view should_not be_nil;
                NSURL *url = [NSURL URLWithString:@"http://samsonchoi.me/bootcamp"];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                
                AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
                operation.responseSerializer = [AFJSONResponseSerializer serializer];
                
                [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    NSDictionary * movieList = (NSDictionary *)responseObject;
                    mrvc.movie = movieList[@"movies"][0];
                    mrvc.view;
                    
                    mrvc.title should equal (@"");
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Movies"
                                                                        message:[error localizedDescription]
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }];
                
                [operation start];
            });

            
            it(@"should set title label to Guardians of the Galaxy", ^{
                mrvc = [[MovieRatingViewController alloc] init];
                
                mrvc.view should_not be_nil;
                NSURL *url = [NSURL URLWithString:@"http://samsonchoi.me/bootcamp"];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                
                AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
                operation.responseSerializer = [AFJSONResponseSerializer serializer];
                
                [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    NSDictionary * movieList = (NSDictionary *)responseObject;
                    mrvc.title = @"";
                    mrvc.movie = movieList[@"movies"][0];
                    
                    UILabel * titleLabel = (UILabel *)[mrvc.view viewWithTag:200];
                    
                    titleLabel.text should equal (@"Guardians of the Galaxy");
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Movies"
                                                                        message:[error localizedDescription]
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }];
                
                [operation start];
            });
        });
        
        it(@"should set critic rating to 92 and 'Certified Fresh'", ^{
            mrvc = [[MovieRatingViewController alloc] init];
            
            mrvc.view should_not be_nil;
            NSURL *url = [NSURL URLWithString:@"http://samsonchoi.me/bootcamp"];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            operation.responseSerializer = [AFJSONResponseSerializer serializer];
            
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSDictionary * movieList = (NSDictionary *)responseObject;
                mrvc.title = @"";
                mrvc.movie = movieList[@"movies"][0];
                
                UILabel * criticLabel = (UILabel *)[mrvc.view viewWithTag:204];
                NSString * criticString = [NSString stringWithFormat:@"%@ (%@%%)", @"Certified Fresh", @"92"];
                
                criticLabel.text should equal (criticString);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Movies"
                                                                    message:[error localizedDescription]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                [alertView show];
            }];
            
            [operation start];
        });
        
        it(@"should set audience rating to 95 and 'Upright'", ^{
            mrvc = [[MovieRatingViewController alloc] init];
            
            mrvc.view should_not be_nil;
            NSURL *url = [NSURL URLWithString:@"http://samsonchoi.me/bootcamp"];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            operation.responseSerializer = [AFJSONResponseSerializer serializer];
            
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSDictionary * movieList = (NSDictionary *)responseObject;
                mrvc.title = @"";
                mrvc.movie = movieList[@"movies"][0];
                
                UILabel * criticLabel = (UILabel *)[mrvc.view viewWithTag:205];
                NSString * criticString = [NSString stringWithFormat:@"%@ (%@%%)", @"Upright", @"95"];
                
                criticLabel.text should equal (criticString);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Movies"
                                                                    message:[error localizedDescription]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                [alertView show];
            }];
            
            [operation start];
        });


    });
});

SPEC_END
