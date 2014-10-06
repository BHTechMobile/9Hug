//
//  SListViewCell.m
//  SPhoto
//
//  Created by SunJiangting on 12-8-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SListViewCell.h"

#import "UIImageView+WebCache.h"

@implementation SListViewCell
@synthesize separatorView = _separatorView1;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super init];
    if (self) {
        // Initialization code
        self.reuseIdentifier = reuseIdentifier;
        _separatorView1 = [[UIView alloc] init];
        [self addSubview:_separatorView1];
        
        _imgBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 100)];
                          //Image:[UIImage imageNamed:@"bgr_me_profile_number_background@2x.png"]];
        
        [self addSubview:_imgBackground];
    }
    return self;
}

-(void)setImageUrl:(NSString*)imageURL{
    
    [_imgBackground setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"holder.png"] options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(error.code == 404){
            NSLog(@"Error: Image not found");
        }
    }];
}

@end
