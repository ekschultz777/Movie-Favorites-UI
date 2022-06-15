//
//  CollectionView.h
//  Favorite Movies
//
//  Created by Ted Schultz on 6/8/22.
//
//#import "Movie.h"
#import "CollectionViewItem.h"
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionView : NSCollectionView<NSCollectionViewDataSource, NSCollectionViewDelegate> {
    
    NSMutableArray *movieTitlesStringArray;
    NSMutableArray *movieImageURLArray;

    NSImage *imageFromItem;

}

@end

NS_ASSUME_NONNULL_END
