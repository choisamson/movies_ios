#import <Cedar-iOS/SpecHelper.h>
#import "MovieTableViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(MovieTableViewControllerSpec)


describe(@"MovieTableViewController", ^{
    __block MovieTableViewController * mtvc;
    
    describe(@"-numberOfSectionsInTableView:", ^{ // 1
        it(@"should return 1", ^{ // 2
            mtvc = [[MovieTableViewController alloc] init]; // 3
            
            mtvc.view should_not be_nil; // 4
            
            [mtvc numberOfSectionsInTableView:mtvc.tableView] should equal(1); // 5
        });
    });
    
    describe(@"Retrieve data from API and test", ^{

        describe(@"-tableView:numberOfRowsInSection:", ^{
            it(@"should return the number of rows for the table view", ^{
                mtvc = [[MovieTableViewController alloc] init];
                
                mtvc.view should_not be_nil;
                NSURL *url = [NSURL URLWithString:@"http://samsonchoi.me/bootcamp"];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                
                AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
                operation.responseSerializer = [AFJSONResponseSerializer serializer];
                
                [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    mtvc.movieList = (NSDictionary *)responseObject;
                    mtvc.title = @"In Theatres";
                    [mtvc.tableView reloadData];
                    [mtvc tableView:mtvc.tableView numberOfRowsInSection:0] should equal(16);
                    
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
        
        describe(@"-tableView:cellForRowAtIndexPath:", ^{
            it(@"should return a cell with year set to current year", ^{
                mtvc = [[MovieTableViewController alloc] init];
                
                mtvc.view should_not be_nil;
                NSURL *url = [NSURL URLWithString:@"http://samsonchoi.me/bootcamp"];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                
                AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
                operation.responseSerializer = [AFJSONResponseSerializer serializer];
                
                [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    mtvc.movieList = (NSDictionary *)responseObject;
                    mtvc.title = @"In Theatres";
                    [mtvc.tableView reloadData];
                    UITableViewCell * firstCell = [mtvc.tableView cellForRowAtIndexPath:0];
                    
                    UILabel * yearLabel = (UILabel *)[firstCell viewWithTag:102];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"yyyy"];
                    NSString *yearString = [formatter stringFromDate:[NSDate date]];
                    
                    yearLabel.text should equal (yearString);

                    
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
            
            it(@"should set cell 1 to Guardians of the Galaxy", ^{
                mtvc = [[MovieTableViewController alloc] init];
                
                mtvc.view should_not be_nil;
                NSURL *url = [NSURL URLWithString:@"http://samsonchoi.me/bootcamp"];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                
                AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
                operation.responseSerializer = [AFJSONResponseSerializer serializer];
                
                [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    mtvc.movieList = (NSDictionary *)responseObject;
                    mtvc.title = @"In Theatres";
                    [mtvc.tableView reloadData];
                    UITableViewCell * firstCell = [mtvc.tableView cellForRowAtIndexPath:0];
                    
                    UILabel * yearLabel = (UILabel *)[firstCell viewWithTag:101];
    
                        yearLabel.text should equal (@"Guardians of the Galaxy");
                    
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
});

SPEC_END
