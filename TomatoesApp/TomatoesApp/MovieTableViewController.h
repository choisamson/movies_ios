//
//  MovieTableViewController.h
//  TomatoesApp
//
//  Created by DEV FLOATER 98 on 9/11/14.
//  Copyright (c) 2014 PivotalLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieTableViewController : UITableViewController <UISearchBarDelegate>
@property(strong) UISearchBar * searchBar;
@property(nonatomic, strong) NSDictionary *movieList;
@end
