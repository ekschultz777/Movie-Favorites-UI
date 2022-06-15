//
//  CollectionView.m
//  Favorite Movies
//
//  Created by Ted Schultz on 6/8/22.
//

#import "CollectionViewItem.h"
#import "CollectionView.h"

@implementation CollectionView

-(NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewItem *item = [collectionView makeItemWithIdentifier:@"CollectionViewItem" forIndexPath:indexPath];
    
    
    //[self getImageFromURLString];
    
    if(movieImageURLArray != nil) {
        NSLog(@"Movie images moved to window");
    }
    else {
        NSLog(@"Error in moving images to window");
    }
    if(movieImageURLArray != nil) {
        NSLog(@"Movie images moved to window");
    }
    else {
        NSLog(@"Error in moving images to window");
    }
    
    //Setting the movie title of each movie
    item->movieTitle.stringValue=[movieTitlesStringArray objectAtIndex:[indexPath item]];
    //Getting the image from its url
    [item getImageFileFromURL:[movieImageURLArray objectAtIndex:[indexPath item]]];
    
    return item;
    
    
}

-(NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //Returning the number of movie titles to get number of movies from
    return [movieTitlesStringArray count];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView {
    //Returns the amount of sections in the collection view. This will be 1.
    return 1;
}

-(void)collectionView:(NSCollectionView *)collectionView didEndDisplayingItem:(NSCollectionViewItem *)item forRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath
{
//Needed for creation of collection view
}

-(void)collectionView:(NSCollectionView *)collectionView willDisplayItem:(nonnull NSCollectionViewItem *)item forRepresentedObjectAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
}

- (void)viewDidMoveToWindow{
    
    self.delegate=self;
    self.dataSource=self;

    [self getMovies];
    
    if(movieTitlesStringArray != nil) {
        NSLog(@"Movies movied to window");
    }
    else {
        NSLog(@"Error in moving movies to window");
    }
    
    
}

//gets JSON data using NSURLSession and completionHandler then parses attributes to strings
- (void)getMovies {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSString *urlString = [[NSString alloc] initWithFormat:@"https://itunes.apple.com/us/rss/topmovies/limit=100/json"];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if (requestReply != nil) {
            //Getting data and parsing
            NSData *jsonData = [requestReply dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
            NSDictionary *parsedDataFeed = [[NSDictionary alloc]initWithDictionary:[parsedData objectForKey:@"feed"]];
            
            //Movie titles array
            NSMutableArray *movieTitles = [[[parsedDataFeed objectForKey:@"entry"] valueForKey:@"im:name"] valueForKey:@"label"];
            
            //Movie image URL array
            NSMutableArray *movieImageURLs = [[NSMutableArray alloc]init];
            
            for (int num = 0; num<movieTitles.count; num++) {
                movieImageURLs[num] = [[[[[parsedDataFeed objectForKey:@"entry"] objectAtIndex:num] valueForKey:@"im:image"] objectAtIndex:2] valueForKey:@"label"];
            }
            
            NSLog(@"URL Replied");
            if(movieTitles != nil) {
                
                self->movieTitlesStringArray = [[NSMutableArray alloc] initWithArray:movieTitles];
                self->movieImageURLArray = [[NSMutableArray alloc] initWithArray:movieImageURLs];
            }
        }
        
        else {
            NSLog(@"Error in gathering movie titles");
        }
    }];
    
    [dataTask resume];
    
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

@end
