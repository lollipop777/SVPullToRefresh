//
//  SVViewController.m
//  SVPullToRefreshDemo
//
//  Created by Sam Vermette on 23.04.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "SVViewController.h"
#import "SVPullToRefresh.h"

@interface SVViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SVViewController
@synthesize tableView = tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // setup the pull-to-refresh view
    [self.tableView addPullToRefreshWithActionHandler:^{
        NSLog(@"refresh dataSource");
        [tableView.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
    }];
    
    // trigger the refresh manually at the end of viewDidLoad
    [tableView.pullToRefreshView triggerRefresh];
    
    
    // you can also display the "last updated" date
    // tableView.pullToRefreshView.lastUpdatedDate = [NSDate date];
    
    // you can configure how that date is displayed
    // NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // dateFormatter.dateStyle = NSDateFormatterLongStyle;
    // dateFormatter.timeStyle = NSDateFormatterNoStyle;
    // tableView.pullToRefreshView.dateFormatter = dateFormatter;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];

    if (indexPath.row == 0) {
        cell.textLabel.text = @"Toggle Pull To Refresh Off";
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

        if (self.tableView.showsPullToRefresh) {
            
            self.tableView.showsPullToRefresh = FALSE;
            cell.textLabel.text = @"Toggle Pull To Refresh On";
        } else {
            
            self.tableView.showsPullToRefresh = TRUE;
            cell.textLabel.text = @"Toggle Pull To Refresh Off";
        }
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
