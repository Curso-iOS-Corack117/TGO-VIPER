// Copyright (c) Microsoft Corporation.
// All rights reserved.
//
// This code is licensed under the MIT License.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files(the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and / or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions :
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#if !EXCLUDE_FROM_MSALCPP

#import "MSIDAuthorizationCodeGrantRequest.h"

/**
 Redeem code request.
 
 @see https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-protocols-oauth-code#use-the-authorization-code-to-request-an-access-token
 */
@interface MSIDAADAuthorizationCodeGrantRequest : MSIDAuthorizationCodeGrantRequest

- (instancetype _Nullable )initWithEndpoint:(nonnull NSURL *)endpoint
                                 authScheme:(nonnull MSIDAuthenticationScheme *)authScheme
                                   clientId:(nonnull NSString *)clientId
                               enrollmentId:(nullable NSString *)enrollmentId
                                      scope:(nullable NSString *)scope
                                redirectUri:(nonnull NSString *)redirectUri
                                       code:(nonnull NSString *)code
                                     claims:(nullable NSString *)claims
                               codeVerifier:(nullable NSString *)codeVerifier
                            extraParameters:(nullable NSDictionary *)extraParameters
                                    context:(nullable id<MSIDRequestContext>)context;

@end

#endif