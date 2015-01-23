#import <Cedar-iOS/SpecHelper.h>
#import "MovieSearchTableViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "UIKit+PivotalSpecHelper.h"
#import "UIKit+PivotalSpecHelperStubs.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(MoveSearchTableViewControllerSpec)

describe(@"MoveSearchTableViewController", ^{
    __block MovieSearchTableViewController * mstvc;
    
    describe(@"-numberOfSectionsInTableView:", ^{ // 1
        it(@"should return 1", ^{ // 2
            mstvc = [[MovieSearchTableViewController alloc] init]; // 3
            
            mstvc.view should_not be_nil; // 4
            
            [mstvc numberOfSectionsInTableView:mstvc.tableView] should equal(1); // 5
        });
    });
    
    describe(@"Retrieve data from API and test", ^{
        
        describe(@"-tableView:numberOfRowsInSection:", ^{
            it(@"should set title to the query sent", ^{
                mstvc = [[MovieSearchTableViewController alloc] init];
                
                mstvc.view should_not be_nil;
                NSURL *url = [NSURL URLWithString:@"http://samsonchoi.me/bootcamp_search"];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                
                AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
                operation.responseSerializer = [AFJSONResponseSerializer serializer];
                
                [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    mstvc.movieList = (NSDictionary *)responseObject;
                    mstvc.query = @"the lion king";
                    [mstvc.tableView reloadData];
                    mstvc.title should equal(@"the lion king");
                    
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

        it(@"should return the number of rows for the table view with a search that has at least one full page of results", ^{
            mstvc = [[MovieSearchTableViewController alloc] init];
            
            mstvc.view should_not be_nil;
            NSURL *url = [NSURL URLWithString:@"http://samsonchoi.me/bootcamp_search"];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            operation.responseSerializer = [AFJSONResponseSerializer serializer];
            
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                mstvc.movieList = (NSDictionary *)responseObject;
                mstvc.query = @"the lion king";
                [mstvc.tableView reloadData];
                [mstvc tableView:mstvc.tableView numberOfRowsInSection:0] should equal(16);
                
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
    
        it(@"should return the number of rows for the table view after another search that has at least one full page of results", ^{
            mstvc = [[MovieSearchTableViewController alloc] init];
            
            mstvc.view should_not be_nil;
            NSURL *url = [NSURL URLWithString:@"http://samsonchoi.me/bootcamp_search2"];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            operation.responseSerializer = [AFJSONResponseSerializer serializer];
            
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                mstvc.movieList = (NSDictionary *)responseObject;
                mstvc.query = @"frozen";
                [mstvc.tableView reloadData];
                [mstvc tableView:mstvc.tableView numberOfRowsInSection:0] should equal(16);
                
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
        
        it(@"should return 0 for the number of rows for the table view after a search with no results", ^{
            mstvc = [[MovieSearchTableViewController alloc] init];
            
            mstvc.view should_not be_nil;
            NSURL *url = [NSURL URLWithString:@"http://samsonchoi.me/bootcamp_search_empty"];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            operation.responseSerializer = [AFJSONResponseSerializer serializer];
            
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                mstvc.movieList = (NSDictionary *)responseObject;
                mstvc.query = @"asdfasdfasdf";
                [mstvc.tableView reloadData];
                [mstvc tableView:mstvc.tableView numberOfRowsInSection:0] should equal(0);
                
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
        
        it(@"should detect an alert has popped up when a search that returns no movies occurs", ^{
            mstvc = [[MovieSearchTableViewController alloc] init];
            
            mstvc.view should_not be_nil;
            NSURL *url = [NSURL URLWithString:@"http://samsonchoi.me/bootcamp_search_empty"];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            operation.responseSerializer = [AFJSONResponseSerializer serializer];
            
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                mstvc.movieList = (NSDictionary *)responseObject;
                mstvc.query = @"asdfasdfasdf";
                [mstvc.tableView reloadData];
                
                UIAlertView * alert = [UIAlertView currentAlertView];
                
                alert.title should equal (@"No Movies Found");
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
