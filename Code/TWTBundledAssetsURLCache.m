//
//  TWTBundledAssetsURLCache.m
//  TWTCommon
//
//  Created by Blake Watters on 9/29/10.
//  Copyright 2010 Two Toasters. All rights reserved.
//

#import "TWTBundledAssetsURLCache.h"

@implementation TWTBundledAssetsURLCache

@synthesize assetMappings = _assetMappings;
@synthesize MIMETypeMappings = _MIMETypeMappings;
@synthesize bundle = _bundle;

- (id)initWithAssetMappings:(NSDictionary*)URLToFilenameMappings MIMETypeMappings:(NSDictionary*)fileExtensionToMIMETypeMappings {
	if (self = [super init]) {
		_assetMappings = [[NSMutableDictionary dictionaryWithDictionary:URLToFilenameMappings] retain];
		_MIMETypeMappings = [[NSMutableDictionary dictionaryWithDictionary:fileExtensionToMIMETypeMappings] retain];
		_cachedResponses = [[NSMutableDictionary alloc] init];
		_bundle = [NSBundle mainBundle];
	}
	
	return self;
}

- (id)init {
	if (self = [super init]) {
		_assetMappings = [[NSMutableDictionary alloc] init];
		_MIMETypeMappings = [[NSMutableDictionary alloc] init];
		_cachedResponses = [[NSMutableDictionary alloc] init];
		_bundle = [NSBundle mainBundle];
	}
	
	return self;
}

- (void)dealloc {
	[_assetMappings release];
	_assetMappings = nil;
	[_MIMETypeMappings release];
	_MIMETypeMappings = nil;
	[_cachedResponses release];
	_cachedResponses = nil;
	[_bundle release];
	_bundle = nil;
	
	[super dealloc];
}

- (NSString *)mimeTypeForURLString:(NSString *)URLString {
	NSString* fileExtension = [URLString pathExtension];
	NSString* MIMEType = [self.MIMETypeMappings objectForKey:fileExtension];
	if (MIMEType) {
		return MIMEType;
	} else {
		return @"application/octet-stream";
	}
}

- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request {
	// Get the URL for the request
	NSString* URLString = [[request URL] absoluteString];
	
	// See if we have a substitution file for this URL
	NSString* substitutionFileName = [self.assetMappings objectForKey:URLString];
	if (NO == substitutionFileName) {
		return [super cachedResponseForRequest:request];
	}
	
	// If we've already created a cache entry for this path, then return it.
	NSCachedURLResponse* cachedResponse = [_cachedResponses objectForKey:URLString];
	if (cachedResponse) {
		return cachedResponse;
	}
	
	// Get the path to the substitution file
	NSString* substitutionFilePath = [self.bundle
									  pathForResource:[substitutionFileName stringByDeletingPathExtension]
									  ofType:[substitutionFileName pathExtension]];
	NSAssert(substitutionFilePath, @"File %@ in substitutionPaths didn't exist", substitutionFileName);
	
	// Load the data
	NSData* data = [NSData dataWithContentsOfFile:substitutionFilePath];
	
	// Create the cacheable response
//	NSLog(@"Using bundled asset %@ for URL %@", substitutionFilePath, URLString);
	NSURLResponse *response = [[[NSURLResponse alloc] initWithURL:[request URL]
														 MIMEType:[self mimeTypeForURLString:URLString]
											expectedContentLength:[data length]
												 textEncodingName:nil] autorelease];
	cachedResponse = [[[NSCachedURLResponse alloc] initWithResponse:response data:data] autorelease];
	
	// Add it to our cache dictionary
	[_cachedResponses setObject:cachedResponse forKey:URLString];
	
	return cachedResponse;
}

- (void)removeCachedResponseForRequest:(NSURLRequest *)request {
	// Get the path for the request
	NSString* URLString = [[request URL] absoluteString];
	
	if ([_cachedResponses objectForKey:URLString]) {
		[_cachedResponses removeObjectForKey:URLString];
	} else {
		[super removeCachedResponseForRequest:request];
	}
}

- (void)removeAllCachedResponses {
	[_cachedResponses release];
	_cachedResponses = [[NSMutableDictionary alloc] init];
	
	[super removeAllCachedResponses];
}

@end
