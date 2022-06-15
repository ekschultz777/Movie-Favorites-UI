//
//  CollectionViewItem.m
//  Favorite Movies
//
//  Created by Ted Schultz on 6/8/22.
//
//#import "Movie.h"
#import "CollectionViewItem.h"

@interface CollectionViewItem () {
    
}

@end

@implementation CollectionViewItem

- (void)getImageFileFromURL:(NSString *)imageURLString {
    
    NSImageView *movieImageView;
    NSRect fromRect = NSMakeRect(20, 52, 113, 170);
    movieImageView = [[NSImageView alloc] initWithFrame:fromRect];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:imageURLString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //creating an asynchronous queue for images to be allocated to memory
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSImage *image = [[NSImage alloc ] initWithData:data];
            
            //gets image from NSImageView using main queue asynchronously
            dispatch_async(dispatch_get_main_queue(), ^{
                
                movieImageView.image = image;
                movieImageView.hidden = NO;
                
                [self.view addSubview:movieImageView];
                
            });
        });
    }];
    [dataTask resume];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
