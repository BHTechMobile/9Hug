// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to HMessage.h instead.

#import <CoreData/CoreData.h>


extern const struct HMessageAttributes {
	__unsafe_unretained NSString *agentid;
	__unsafe_unretained NSString *attachement1;
	__unsafe_unretained NSString *attachement2;
	__unsafe_unretained NSString *code;
	__unsafe_unretained NSString *createdated;
	__unsafe_unretained NSString *downloaded;
	__unsafe_unretained NSString *frameid;
	__unsafe_unretained NSString *generateddate;
	__unsafe_unretained NSString *key;
//    __unsafe_unretained NSString *photos;
	__unsafe_unretained NSString *mId;
	__unsafe_unretained NSString *reads;
	__unsafe_unretained NSString *receiveddate;
	__unsafe_unretained NSString *receiverid;
	__unsafe_unretained NSString *sentdate;
	__unsafe_unretained NSString *style;
	__unsafe_unretained NSString *text;
	__unsafe_unretained NSString *type;
	__unsafe_unretained NSString *userid;
    __unsafe_unretained NSString *fullname;
} HMessageAttributes;

extern const struct HMessageRelationships {
} HMessageRelationships;

extern const struct HMessageFetchedProperties {
} HMessageFetchedProperties;





















@interface HMessageID : NSManagedObjectID {}
@end

@interface _HMessage : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (HMessageID*)objectID;





@property (nonatomic, strong) NSString* agentid;



//- (BOOL)validateAgentid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* attachement1;



//- (BOOL)validateAttachement1:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* attachement2;



//- (BOOL)validateAttachement2:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* code;



//- (BOOL)validateCode:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* createdated;



//- (BOOL)validateCreatedated:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* downloaded;



@property BOOL downloadedValue;
- (BOOL)downloadedValue;
- (void)setDownloadedValue:(BOOL)value_;

//- (BOOL)validateDownloaded:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* frameid;



//- (BOOL)validateFrameid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* generateddate;



//- (BOOL)validateGenerateddate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* key;

//@property (nonatomic, strong) NSString* photos;


//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* mId;



//- (BOOL)validateMId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* reads;



//- (BOOL)validateReads:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* receiveddate;



//- (BOOL)validateReceiveddate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* receiverid;



//- (BOOL)validateReceiverid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* sentdate;



//- (BOOL)validateSentdate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* style;



//- (BOOL)validateStyle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* text;



//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* type;



//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* userid;

@property (nonatomic,strong) NSString * fullname;

- (BOOL)fullnameValue;
- (void)setFullnameValue:(BOOL)value_;

//- (BOOL)validateUserid:(id*)value_ error:(NSError**)error_;






@end

@interface _HMessage (CoreDataGeneratedAccessors)

@end

@interface _HMessage (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAgentid;
- (void)setPrimitiveAgentid:(NSString*)value;




- (NSString*)primitiveAttachement1;
- (void)setPrimitiveAttachement1:(NSString*)value;




- (NSString*)primitiveAttachement2;
- (void)setPrimitiveAttachement2:(NSString*)value;




- (NSString*)primitiveCode;
- (void)setPrimitiveCode:(NSString*)value;




- (NSDate*)primitiveCreatedated;
- (void)setPrimitiveCreatedated:(NSDate*)value;




- (NSNumber*)primitiveDownloaded;
- (void)setPrimitiveDownloaded:(NSNumber*)value;

- (BOOL)primitiveDownloadedValue;
- (void)setPrimitiveDownloadedValue:(BOOL)value_;




- (NSString*)primitiveFrameid;
- (void)setPrimitiveFrameid:(NSString*)value;




- (NSDate*)primitiveGenerateddate;
- (void)setPrimitiveGenerateddate:(NSDate*)value;




- (NSString*)primitiveKey;
- (void)setPrimitiveKey:(NSString*)value;


//- (NSString*)primitivePhotos;
//- (void)setPrimitivePhotos:(NSString*)value;


- (NSString*)primitiveMId;
- (void)setPrimitiveMId:(NSString*)value;




- (NSString*)primitiveReads;
- (void)setPrimitiveReads:(NSString*)value;




- (NSDate*)primitiveReceiveddate;
- (void)setPrimitiveReceiveddate:(NSDate*)value;




- (NSString*)primitiveReceiverid;
- (void)setPrimitiveReceiverid:(NSString*)value;




- (NSDate*)primitiveSentdate;
- (void)setPrimitiveSentdate:(NSDate*)value;




- (NSString*)primitiveStyle;
- (void)setPrimitiveStyle:(NSString*)value;




- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;




- (NSString*)primitiveType;
- (void)setPrimitiveType:(NSString*)value;




- (NSString*)primitiveUserid;
- (void)setPrimitiveUserid:(NSString*)value;

- (NSString*)primitiveFullname;
- (void)setPrimitiveFullname:(NSString*)value;



@end
