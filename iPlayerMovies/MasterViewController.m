//
//  MasterViewController.m
//  iPlayerMovies
//
//  Created by Dan on 09/04/2013.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "TFHpple.h"
#import "Parser.h"


@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

-(void)loadMovies {

    NSURL *movieListUrl = [NSURL URLWithString:@"http://feeds.bbc.co.uk/iplayer/categories/films/tv/list"];
    NSData *moviesHtmlData = [NSData dataWithContentsOfURL:movieListUrl];
    
    TFHpple *movieListParser = [TFHpple hppleWithHTMLData:moviesHtmlData];
    
    // If the query string is changed to get the whole entry, more information about the movie 
    // can be acquired from the	content tag.
    NSString *entryQuery = @"//entry/title";
    NSArray *moviesNodes = [movieListParser searchWithXPathQuery:entryQuery];
       
    //NSLog(@"%@",[moviesNodes description]);

    NSMutableArray *newMovies = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (TFHppleElement *element in moviesNodes) {
        // 5
        Parser *movie = [[Parser alloc] init];
        [newMovies addObject:movie];
    
        movie.title = [[element firstChild] content];
        // if available get info for the movie and add it to movie.info
    }
 
    // sorting by title
    // can be optimised by discarding leading "the/a" from titles
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
    sortedArray = [newMovies sortedArrayUsingDescriptors:sortDescriptors];

    NSMutableArray *temp = [sortedArray mutableCopy];
    _objects = temp;//newMovies;
    [self.tableView reloadData];
}


- (void)awakeFromNib
{
    /*if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }*/
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadMovies];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Parser *thisMovie = [_objects objectAtIndex:indexPath.row];
    cell.textLabel.text = thisMovie.title;
    //cell.detailTextLabel.text =  thisMovie.info;
    
    return cell;

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = _objects[indexPath.row];
        self.detailViewController.detailItem = object;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
