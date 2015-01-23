//
//  WTTableViewController.m
//  Weather
//
//  Created by Scott on 26/01/2013.
//  Updated by Joshua Greene 16/12/2013.
//
//  Copyright (c) 2013 Scott Sherwood. All rights reserved.
//

#import "MovieTableViewController.h"
#import "MovieRatingViewController.h"
#import "MovieSearchTableViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

static NSString * const kBaseURLString = @"http://api.rottentomatoes.com/api/public/v1.0/";
static NSString * const kAPIKey = @"m3vgskj2mncgjk3wzqq36tre";
static NSString * const kListEndpoint = @"lists/movies/in_theaters.json";
static NSString * const kSearchEndpoint = @"movies.json?";

@interface MovieTableViewController ()
@property(nonatomic, strong) NSString * query;
@end

@implementation MovieTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.toolbarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.searchBar = (UISearchBar * ) [self.view viewWithTag:1];
    NSString *string = [NSString stringWithFormat:@"%@%@?apikey=%@&limit=4", kBaseURLString, kListEndpoint,kAPIKey];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.movieList = (NSDictionary *)responseObject;
        self.title = @"In Theatres";
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Movies"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    [operation start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"MovieDetailSegue"]){
         UITableViewCell *cell = (UITableViewCell *)sender;
         NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
         
         MovieRatingViewController *mrc = (MovieRatingViewController *)segue.destinationViewController;
         
         NSDictionary * movie;
         
         movie = self.movieList[@"movies"][indexPath.row];

         mrc.movie = movie;
     } else if ([segue.identifier isEqualToString:@"MovieSearchSegue"]){
         MovieSearchTableViewController *mstc = (MovieSearchTableViewController *)segue.destinationViewController;
         
         mstc.query = self.query;

     
     }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!self.movieList)
        return 0;
    
    NSArray *movies = self.movieList[@"movies"];
    return [movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MovieCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *curMovie = nil;
    
    NSArray *movies = self.movieList[@"movies"];
    curMovie = movies[indexPath.row];
    
    NSDictionary * posters = curMovie[@"posters"];

    NSInteger cutOff = [posters[@"detailed"] length] - 7;
    NSString * parsedURL = [posters[@"detailed"] substringToIndex:cutOff];
    
    NSRange r = [parsedURL rangeOfString:@"poster_default" options:NSCaseInsensitiveSearch];
    
    if (r.length > 0){
        UIImage * noPoster = [UIImage imageNamed:@"noposter.jpg"];
        [(UIImageView *)[cell viewWithTag:100] setImage:noPoster];
    } else {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@pro.jpg", parsedURL]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [(UIImageView *)[cell viewWithTag:100] setImageWithURLRequest:request placeholderImage:nil success:nil failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            UIImage * noPoster = [UIImage imageNamed:@"noposter.jpg"];
            [(UIImageView *)[cell viewWithTag:100] setImage:noPoster];
        }];
    }
    [(UILabel *)[cell viewWithTag:101] setText:curMovie[@"title"]];
    [(UILabel *)[cell viewWithTag:102] setText:[NSString stringWithFormat:@"%@",curMovie[@"year"]]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self handleSearch:searchBar];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
        //[self handleSearch:searchBar];
}

- (void)handleSearch:(UISearchBar *)searchBar {
    self.query = searchBar.text;
    [self performSegueWithIdentifier:@"MovieSearchSegue"
                              sender:self];
    [searchBar setText:@""];
    [searchBar resignFirstResponder]; // if you want the keyboard to go away
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    [searchBar resignFirstResponder]; // if you want the keyboard to go away
}
@end
