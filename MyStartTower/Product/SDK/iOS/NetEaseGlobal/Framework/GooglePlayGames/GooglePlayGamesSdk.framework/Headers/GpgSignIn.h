/*
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <AuthenticationServices/AuthenticationServices.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import <SafariServices/SafariServices.h>

@class GpgPlayer;
@class GpgSignIn;

typedef NS_ENUM(NSInteger, GpgErrorType) {
  kGpgErrorCanceled = -1,
  kGpGErrorAccountSignIn = -2,
  kGpgErrorProfileLoad = -3,
  kGpgErrorProfileCreation = -4,
  kGpgErrorGetEndPoint = -5,
};

@protocol GpgSignInDelegate <NSObject>

- (void)onSignIn:(GpgPlayer *)player withError:(NSError *)error;
- (void)onSignOut;

@end

@interface GpgPlayer : NSObject

@property(nonatomic, readonly, copy) NSString *playerId;
@property(nonatomic, readonly, copy) NSString *displayName;
@property(nonatomic, readonly, copy) NSURL *avatarImageUrl;
@property(nonatomic, readonly, copy) NSString *accessToken;
@property(nonatomic, readonly, copy) NSString *serverAuthCode;

- (instancetype)initWithPlayerId:(NSString *)playerId
                     displayName:(NSString *)displayName
                  avatarImageUrl:(NSURL *)avatarImageUrl
                     accessToken:(NSString *)accessToken
                  serverAuthCode:(NSString *)serverAuthCode;
@end

@interface GpgSignIn : NSObject <GIDSignInDelegate,
                                 SFSafariViewControllerDelegate,
                                 ASWebAuthenticationPresentationContextProviding>

/// The object to be notified when authentication is finished.
@property(nonatomic, weak) id<GpgSignInDelegate> delegate;

/// The view controller used to present `SFSafariViewContoller` on iOS 9 and 10.
@property(nonatomic, weak) UIViewController *presentingViewController;

/// DEPRECATED. This property should ONLY be used when migrating existing Google Sign-In users to
/// Google Play Games sign-in.
///
/// Whether to enable the legacy sign-in mode, default is NO. When set to YES, the silent sign-in
/// (GPGSginIn.restorePreviousSignIn) will not fail if
/// 1. GAMES scope is missing or
/// 2. player profile is missing
/// The GpgSignInDelegate.onSignIn will be called with player and error both set to 'nil''. Caller
/// should check [GIDSignIn sharedInstance].currentUser for the information about Google signed-in
/// user.
///
/// This property should be set before calling 'signin'.
@property(nonatomic, assign) BOOL enableLegacyMode;

/// The unique application ID of the game.
/// @property(nonatomic, copy) NSString *projectNumber;

/// Returns a shared `GpgSignIn` instance.
+ (GpgSignIn *)sharedInstance;

/// This method should be called from your `UIApplicationDelegate`'s `application:openURL:options`
/// and `application:openURL:sourceApplication:annotation` method(s).
///
/// @param url The URL that was passed to the app.
/// @return `YES` if `GpgSignIn` handled this URL.
- (BOOL)handleURL:(NSURL *)url;

/// Checks if there is a previously authenticated user saved in keychain.
///
/// @return `YES` if there is a previously authenticated user saved in keychain.
- (BOOL)hasPreviousSignIn;

/// The authentication object for the current Play player, or `nil` if there is currently no valid
/// player. For the general signed-in user data, please query [GIDSignIn
/// sharedInstance].currentUser.
- (GpgPlayer *)currentPlayer;

/// Attempts to restore a previously authenticated user without interaction.
///
/// The delegate will be called at the end of this process indicating success or failure.  The
/// current values of `GpgSignIn`'s configuration properties will not impact the restored user.
- (void)restorePreviousSignIn;

/// Starts an interactive sign-in flow using `GpgSignIn`'s configuration properties.
///
/// The delegate will be called at the end of this process.  Any saved sign-in state will be
/// replaced by the result of this flow.  Note that this method should not be called when the app
/// is starting up, (e.g in `application:didFinishLaunchingWithOptions:`); instead use the
/// `restorePreviousSignIn` method to restore a previous sign-in.
- (void)signIn:(BOOL)skipPlayerProfileIfMissing;

/// Marks current user as being in the signed out state.
- (void)signOut;

@end
