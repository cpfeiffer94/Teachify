//
//  FHHBehaviour.h
//  Teachify
//
//  Created by Bastian Kusserow on 18.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

#ifndef FHHBehaviour_h
#define FHHBehaviour_h


#endif /* FHHBehaviour_h */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FHHBehaviour : UIControl

// Convenient for non-IB usage
+ (instancetype)behaviourWithOwner:(id)owner;

- (void)setUp;

@property(nonatomic, weak) IBOutlet id owner;

@end

NS_ASSUME_NONNULL_END
