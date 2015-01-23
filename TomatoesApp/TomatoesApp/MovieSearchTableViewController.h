//
//  SearchTableTableViewController.h
//  TomatoesApp
//
//  Created by DEV FLOATER 98 on 9/11/14.
//  Copyright (c) 2014 PivotalLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieSearchTableViewController : UITableViewController <UISearchBarDelegate>
@property(strong) UISearchBar * searchBar;
@property(strong) NSString * query;
@property(nonatomic, strong) NSDictionary *movieList;
@end
