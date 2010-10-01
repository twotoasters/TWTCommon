//
//  TWTBundledAssetsURLCache.h
//  TWTCommon
//
//  Created by Blake Watters on 9/29/10.
//  Copyright 2010 Two Toasters. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * Provides a simple substitution cache for returning assets
 * from the local app bundle in lieu of loading them from a remote
 * server. Assets that do not have a corresponding local version will
 * be loaded like normal over the wire.
 *
 * Based heavily on code from Matt Gallagher
 * See http://cocoawithlove.com/2010/09/substituting-local-data-for-remote.html
 */
@interface TWTBundledAssetsURLCache : NSURLCache {
	NSMutableDictionary* _cachedResponses;
	NSMutableDictionary* _assetMappings;
	NSMutableDictionary* _MIMETypeMappings;
	NSBundle* _bundle;
}

/**
 * Returns the asset mappings currently registered with the cache. The
 * keys are string URL's and the values are file names that exist within the
 * main bundle
 */
@property (nonatomic, readonly) NSMutableDictionary* assetMappings;

/**
 * Returns the file extension to MIME Type mappings registered with the cache. The
 * keys are file extensions and the values are the textual MIME Types to return for
 * files with the given extension loaded from the cache (i.e. 'png' => 'image/png')
 */
@property (nonatomic, readonly) NSMutableDictionary* MIMETypeMappings;

/**
 * The bundle to load assets from. 
 * 
 * Defaults to [NSBundle mainBundle]
 */
@property (nonatomic, retain) NSBundle* bundle;

/**
 * Initialize a new URL cache with a dictionary of URL to filename mappings specifying assets in the main bundle to
 * return instead of actually loading the mapped URL. The MIME type mappings specifies mappings from file extensions
 * to MIME types (i.e. 'html' => 'text/html', etc).
 */
- (id)initWithAssetMappings:(NSDictionary*)URLToFilenameMappings MIMETypeMappings:(NSDictionary*)fileExtensionToMIMETypeMappings;

@end
