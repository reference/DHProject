//
//	Copyright (c) Scott Ban
//	https://github.com/reference/DHProject
//
//
//	Permission is hereby granted, free of charge, to any person obtaining a
//	copy of this software and associated documentation files (the "Software"),
//	to deal in the Software without restriction, including without limitation
//	the rights to use, copy, modify, merge, publish, distribute, sublicense,
//	and/or sell copies of the Software, and to permit persons to whom the
//	Software is furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//	IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>

/*!
 *  @class DHAPIHeader
 *  @abstract 请求头
 */
@interface DHAPIHeader : NSObject

/*!
 *  请求的UUID
 */
@property (nonatomic, readonly) NSString * requestUUID;

/*!
 *  单例
 */
AS_SINGLETON(APIHeader);

/*!
 *  请求头用户标识
 *
 *  @return 请求头用户标识
 */
- (NSString *)userAgent;

/*!
 *  配置请求头
 *
 *  @param request http 请求对象
 *
 *  @return 请求对象
 */
+ (BeeRequest *)makeRequestHeaders:(BeeRequest *)request;

/*!
 *  解析返回头
 *
 *  @param request http 请求对象
 *
 *  @return 请求对象
 */
- (BeeRequest *)parseResponseHeaders:(BeeRequest *)request;
@end
