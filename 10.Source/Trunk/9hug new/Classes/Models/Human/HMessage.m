#import "HMessage.h"

@implementation HMessage

+(HMessage*)createByDictionary:(NSDictionary*)dict
{
    if (dict == nil) {
        return nil;
    }
    
    NSString* mId = [dict stringForKey:@"id"];
    HMessage* message = [HMessage getMessageById:mId];
    if (!message) {
        message = [HMessage MR_createEntity];
        message.mId = [dict stringForKey:@"id"];
    }
    message.key = [dict stringForKey:@"key"];
//    if ([dict stringForKey:@"photos"] != nil) {
//        message.photos = [dict stringForKey:@"photos"];
//    }
    
    message.agentid = [dict stringForKey:@"agentid"];
    message.type = [dict stringForKey:@"type"];
    message.style = [dict stringForKey:@"style"];
    message.code = [dict stringForKey:@"code"];
    message.attachement1 = [dict stringForKey:@"attachement1"];
    message.attachement2 = [dict stringForKey:@"attachement2"];
    message.text = [dict stringForKey:@"text"];
    message.frameid = [dict stringForKey:@"frameid"];
    message.userid = [dict stringForKey:@"userid"];
    message.generateddate = [NSDate dateFromTimeInterval:[dict stringForKey:@"generateddate"]];
    message.createdated = [NSDate dateFromTimeInterval:[dict stringForKey:@"createdated"]];
    message.sentdate = [NSDate dateFromTimeInterval:[dict stringForKey:@"sentdate"]];
    message.receiverid = [dict stringForKey:@"receiverid"];
    message.receiveddate = [NSDate dateFromTimeInterval:[dict stringForKey:@"receiveddate"]];
    message.reads = [dict stringForKey:@"reads"];
    if ([dict stringForKey:@"fullname"]==nil || [[dict stringForKey:@"fullname"] isEqual:@"<null>"] || [[dict stringForKey:@"fullname"] isKindOfClass:[NSNull class]]) {
        message.fullname = @"";
    }else{
        message.fullname = [dict stringForKey:@"fullname"];
    }
    return message;
}

+(HMessage*)getMessageById:(NSString*)mId
{
    return [HMessage MR_findFirstByAttribute:@"mId" withValue:mId];
}

+(BOOL)downloadedByDictionary:(NSDictionary*)dict
{
    NSString* mId = [dict stringForKey:@"id"];
    HMessage* message = [HMessage getMessageById:mId];
    if (!message) {
        return NO;
    }
    NSString* attachement1 = [dict stringForKey:@"attachement1"];
    if (message.downloadedValue && ![attachement1 isEqualToString:message.attachement1]) {
        return NO;
    }
    
    return YES;
}

-(NSString*)localVideoPath
{
    NSString* fileName = [NSString stringWithFormat:@"Documents/%@.mp4",self.key];
    return [NSHomeDirectory() stringByAppendingPathComponent:fileName];
}
@end
