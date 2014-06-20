//
//  TWPictureDataTransformer.m
//  Thousend Words
//
//  Created by Michał Kozak on 25.03.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import "TWPictureDataTransformer.h"

@implementation TWPictureDataTransformer

+(Class)transformedValueClass{
    return [NSData class];
}
+(BOOL)allowsReverseTransformation{
    return YES;
}

-(id)transformedValue:(id)value{
    return UIImagePNGRepresentation(value);
}
-(id)reverseTransformedValue:(id)value{
    UIImage *image = [UIImage imageWithData:value];
    return image;
}

@end
