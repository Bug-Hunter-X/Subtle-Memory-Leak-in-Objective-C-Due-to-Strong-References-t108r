The solution lies in understanding how strong references work. In the original code, each time `someMethod` is called, a new `NSString` object is created and strongly referenced by `myString`. This means the object's reference count increases, preventing it from being deallocated. When `myString` is changed to a new string on the next call to `someMethod`, the old string will never be released, hence the memory leak. 

The correct approach uses ARC to manage memory and avoids potential memory leaks.

```objectivec
@interface MyClass : NSObject
@property (nonatomic, strong) NSMutableString *myString;
@end

@implementation MyClass
- (instancetype)init {
    self = [super init];
    if (self) {
        _myString = [NSMutableString string]; // Initialize here
    }
    return self;
}

- (void)someMethod:(NSString *)newString {
    [self.myString appendString:newString]; // Modify existing string
}
@end
```
By initializing `myString` once in the `init` method, and then appending the new strings, we avoid constantly creating new string objects. Each change appends the new content to the existing mutable string, thus preventing memory leaks.  This is a more efficient and safer pattern in Objective-C