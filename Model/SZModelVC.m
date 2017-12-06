//
//  SZModel.m
//  LearningYYDemo
//
//  Created by starz on 2017/12/5.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "SZModelVC.h"
#import <YYKit.h>
//######################################################################//
@interface SZBook : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) uint64_t pages;
@property (nonatomic, strong) NSDate *publishDate;
@end

@implementation SZBook
@end

static void SimpleObjectExa() {
    // JSON字符串转模型
    SZBook *book = [SZBook modelWithJSON:@"  \
    {                                        \
        \"name\": \"Harry Potter\",          \
        \"pages\": 512,                      \
        \"publishDate\": \"2010-01-01\"      \
    }"];
    // 模型转为JSON字符串
    NSString *jsonStr = [book modelToJSONString];
    NSLog(@"Book: %@",jsonStr);
}
//######################################################################//
@interface SZUser : NSObject
@property (nonatomic, assign) uint64_t uid;
@property (nonatomic, copy) NSString *name;
@end

@implementation SZUser
@end

@interface SZRepo : NSObject
@property (nonatomic, assign) uint64_t  rid;
@property (nonatomic, copy)   NSString  *name;
@property (nonatomic, strong) NSDate    *createTime;
@property (nonatomic, strong) SZUser    *owner;
@end

@implementation SZRepo
@end

static void SimpleExample2 () {
    SZRepo *repo = [SZRepo modelWithJSON:@"         \
    {                                               \
        \"rid\": 123456789,                         \
        \"name\": \"YYKit\",                        \
        \"createTime\" : \"2011-06-09T06:24:26Z\",  \
        \"owner\": {                                \
            \"uid\" : 989898,                       \
            \"name\" : \"ibireme\"                  \
        } \
    }"];
    NSString *JsonStr = [repo modelToJSONString];
    NSLog(@"Repo: %@",JsonStr);
}

//######################################################################//
@interface SZPhoto : NSObject
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *desc;
@end

@implementation SZPhoto
@end

@interface SZAlbum : NSObject
@property (nonatomic, copy)   NSString     *name;
@property (nonatomic, strong) NSArray      *photos; // Array<YYPhoto>
@property (nonatomic, strong) NSDictionary *likedUsers; // Key:name(NSString) Value:user(YYUser)
@property (nonatomic, strong) NSSet        *likedUserIds; // Set<NSNumber>
@end

@implementation SZAlbum
//
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"photos" : SZPhoto.class,
             @"likedUsers" : SZUser.class,
             @"likedUserIds" : NSNumber.class};
}
@end
static void ContainerObjectExample() {
    
    SZAlbum *album = [SZAlbum modelWithJSON:@"          \
    {                                                   \
    \"name\" : \"Happy Birthday\",                      \
    \"photos\" : [                                      \
        {                                               \
            \"url\":\"http://example.com/1.png\",       \
            \"desc\":\"Happy~\"                         \
        },                                              \
        {                                               \
            \"url\":\"http://example.com/2.png\",       \
            \"desc\":\"Yeah!\"                          \
        }                                               \
    ],                                                  \
    \"likedUsers\" : {                                  \
        \"Jony\" : {\"uid\":10001,\"name\":\"Jony\"},   \
        \"Anna\" : {\"uid\":10002,\"name\":\"Anna\"}    \
    },                                                  \
    \"likedUserIds\" : [10001,10002]                    \
    }"];
    NSString *jsonStr = [album modelToJSONString];
    NSLog(@"Album: %@", jsonStr);
}

//######################################################################//
@interface SZMessage : NSObject
@property (nonatomic, assign) uint64_t messageId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDate *time;
@end

@implementation SZMessage
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"messageId":@"i",
             @"content":@"c",
             @"time":@"t"};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    uint64_t timestamp = [dic unsignedLongLongValueForKey:@"t" default:0];
    self.time = [NSDate dateWithTimeIntervalSince1970:timestamp / 1000.0];
    return YES;
}
- (void)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    dic[@"t"] = @([self.time timeIntervalSince1970] * 1000).description;
}
@end

static void CustomMapperExample() {
    SZMessage *message = [SZMessage modelWithJSON:@"{\"i\":\"2000000001\",\"c\":\"Hello\",\"t\":\"1437237598000\"}"];
    NSString *messageJSON = [message modelToJSONString];
    NSLog(@"Message: %@", messageJSON);
}

//######################################################################//
@interface SZShadow : NSObject <NSCoding, NSCopying>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, strong) UIColor *color;
@end

@implementation SZShadow
// 归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self modelEncodeWithCoder:aCoder];
}
// 解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self modelInitWithCoder:aDecoder];
}
//
- (id)copyWithZone:(NSZone *)zone
{
    return [self modelCopy];
}
// 判单是否为相同对象
- (BOOL)isEqual:(id)object
{
    return [self modelIsEqual:object];
}
// 获取哈希值
- (NSUInteger)hash
{
    return [self modelHash];
}
@end

static void CodingCopyingHashEqualExample() {
    
    SZShadow *shdow = [SZShadow new];
    shdow.name = @"SHDOW";
    shdow.size = CGSizeMake(10, 10);
    shdow.color = [UIColor lightGrayColor];
    
    SZShadow *shdow2 = [shdow deepCopy];
    BOOL equal = [shdow isEqual:shdow2];
    NSLog(@"shadow equals: %@",equal ? @"YES" : @"NO");
}

//######################################################################//
@interface SZModelVC ()

@end

@implementation SZModelVC

- (void)runExample {
//    SimpleObjectExa();
//    SimpleExample2();
//    ContainerObjectExample();
//    CustomMapperExample();
    CodingCopyingHashEqualExample();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 不设置颜色 PUSH会出现拖影
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *lbl = [UILabel new];
    lbl.size = CGSizeMake(kScreenWidth, 30);
    lbl.centerY = self.view.size.height * 0.5; //- (kiOS7Later?35:0);
    NSLog(@"--------%f",lbl.centerY);
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = kiOS7Later?[UIColor redColor]:[UIColor cyanColor];
    lbl.text = @"SEE SZModel.m";
    [self.view addSubview:lbl];
    [self runExample];
}

@end
