//
//  MulticastDelegate.m
//  ToolClass
//
//  Created by zhuzi-cdd on 2023/11/21.
//

#import "MulticastDelegate.h"
#import "Test2VC.h"

@interface MulticastDelegate ()
@property (nonatomic, strong) NSHashTable *delegates;
@end

@implementation MulticastDelegate
+(instancetype)shared {
    static dispatch_once_t onceToken;
    static MulticastDelegate *instance;
    dispatch_once(&onceToken, ^{
        instance = [[MulticastDelegate alloc] init];
    });
    return instance;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegates = [NSHashTable weakObjectsHashTable];
    }
    return self;
}

- (void)addDelegate:(id<MyDelegateProtocol>)delegate {
    [self.delegates addObject:delegate];
}

- (void)removeDelegate:(id<MyDelegateProtocol>)delegate {
    [self.delegates removeObject:delegate];
}

- (void)removeDelegateWithClass:(Class)classObj {
    NSMutableArray *delegatesToRemove = [NSMutableArray array];
    for (id delegate in self.delegates) {
        if ([delegate isKindOfClass:classObj]) {
            [delegatesToRemove addObject:delegate];
        }
    }
    
    for (id delegate in delegatesToRemove) {
        [self.delegates removeObject:delegate];
    }
}

- (void)performDelegateMethod {
    for (id<MyDelegateProtocol> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(didReceiveEvent:)]) {
            [delegate didReceiveEvent:@"接受事件"];
        }
    }
    
}



@end
