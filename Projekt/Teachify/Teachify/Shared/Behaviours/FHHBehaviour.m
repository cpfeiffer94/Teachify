//
//  FHHBehaviour.m
//  Teachify
//
//  Created by Bastian Kusserow on 18.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

#import "FHHBehaviour.h"
#import <objc/runtime.h>

@implementation FHHBehaviour

+ (instancetype) behaviourWithOwner:(id)owner
{
    FHHBehaviour * behaviour = [[self alloc] init];
    behaviour.owner = self;
    
    return behaviour;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return self;
    }
    [self setUp];
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return self;
    }
    [self setUp];
    return self;
}

- (void) setUp
{
    //Override for custom setup
}

#if DEBUG
- (void) awakeFromNib
{
    [super awakeFromNib];
    NSParameterAssert(self.owner);
}
#endif

#pragma mark - Properties
- (void) setOwner:(id)owner
{
    if(_owner != owner){
        [self releaseLifetimeFromObject:_owner];
        _owner = owner;
        [self bindLifetimeToObject:_owner];
    }
}

- (void)bindLifetimeToObject:(id)owner
{
    objc_setAssociatedObject(owner, (__bridge void *)self, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)releaseLifetimeFromObject:(id)owner
{
    objc_setAssociatedObject(owner, (__bridge void *)self, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end



