#import "_HMessage.h"

@interface HMessage : _HMessage {}

+(HMessage*)createByDictionary:(NSDictionary*)dict;
+(HMessage*)getMessageById:(NSString*)mId;
+(BOOL)downloadedByDictionary:(NSDictionary*)dict;
-(NSString*)localVideoPath;

@end
