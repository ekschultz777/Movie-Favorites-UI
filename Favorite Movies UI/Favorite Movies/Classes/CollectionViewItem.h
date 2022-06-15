//
//  CollectionViewItem.h
//  Favorite Movies
//
//  Created by Ted Schultz on 6/8/22.
//
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewItem : NSCollectionViewItem
{
@public
    __weak IBOutlet NSTextField *movieTitle;
}
- (void)getImageFileFromURL:(NSImage *)image;

@end

NS_ASSUME_NONNULL_END
