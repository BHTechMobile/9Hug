// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to HMessage.m instead.

#import "_HMessage.h"

const struct HMessageAttributes HMessageAttributes = {
	.agentid = @"agentid",
	.attachement1 = @"attachement1",
	.attachement2 = @"attachement2",
	.code = @"code",
	.createdated = @"createdated",
	.downloaded = @"downloaded",
	.frameid = @"frameid",
	.generateddate = @"generateddate",
	.key = @"key",
//    .photos = @"photos",
	.mId = @"mId",
	.reads = @"reads",
	.receiveddate = @"receiveddate",
	.receiverid = @"receiverid",
	.sentdate = @"sentdate",
	.style = @"style",
	.text = @"text",
	.type = @"type",
	.userid = @"userid",
    .fullname = @"fullname"
};

const struct HMessageRelationships HMessageRelationships = {
};

const struct HMessageFetchedProperties HMessageFetchedProperties = {
};

@implementation HMessageID
@end

@implementation _HMessage

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"HMessage" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"HMessage";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"HMessage" inManagedObjectContext:moc_];
}

- (HMessageID*)objectID {
	return (HMessageID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"downloadedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"downloaded"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

//@dynamic photos;


@dynamic agentid;






@dynamic attachement1;






@dynamic attachement2;






@dynamic code;






@dynamic createdated;






@dynamic downloaded;



- (BOOL)downloadedValue {
	NSNumber *result = [self downloaded];
	return [result boolValue];
}

- (void)setDownloadedValue:(BOOL)value_ {
	[self setDownloaded:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveDownloadedValue {
	NSNumber *result = [self primitiveDownloaded];
	return [result boolValue];
}

- (void)setPrimitiveDownloadedValue:(BOOL)value_ {
	[self setPrimitiveDownloaded:[NSNumber numberWithBool:value_]];
}





@dynamic frameid;






@dynamic generateddate;






@dynamic key;






@dynamic mId;






@dynamic reads;






@dynamic receiveddate;






@dynamic receiverid;






@dynamic sentdate;






@dynamic style;






@dynamic text;






@dynamic type;






@dynamic userid;


@dynamic fullname;

//- (BOOL)fullnameValue {
//	NSNumber *result = [self downloaded];
//	return [result boolValue];
//}

//- (void)setFullnameValue:(NSString*)value_ {
//	[self setFullnameValue:value_];
//}

//- (void)setPrimitiveFullnameValue:(NSString*)value_ {
//	[self setFullnameValue:value_];
//}









@end
