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
#import "DHAPIMessage.h"
#import "DHBase.h"

/*!
 *  @class DHAPIBase
 *  @abstract API控制器基类，所有的api借口都继承此类
 */
@interface DHAPIBase : DHBase

/*!
 *  请求API时如果断网
 */
AS_NOTIFICATION(NOTIFY_NETWORKING_ERROR)

/*!
 *  GET请求
 *
 *  @abstract GET请求服务器，会将 msg.input 键值对当作参数请求服务器;子类若对请求参数有特殊配置，需要重写本方法
 *  @param msg  消息对象
 *  @param host api主机名
 *  @param path api路径
 */
- (void)getWithMessage:(BeeMessage *)msg host:(NSString *)host path:(NSString *)path;

/*!
 *  POST请求
 *
 *  @abstract POST请求服务器，会将 msg.input 键值对当作参数请求服务器;子类若对请求参数有特殊配置，需要重写本方法
 *  @param msg  消息对象
 *  @param host api主机名
 *  @param path api路径
 */
- (void)postWithMessage:(BeeMessage *)msg host:(NSString *)host path:(NSString *)path;

@end