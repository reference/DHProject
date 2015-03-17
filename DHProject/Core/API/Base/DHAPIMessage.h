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
#import "DHAPIHeader.h"

typedef void (^APIMessageBlock)( BeeMessage * msg );
typedef void (^APIMessageBlockP)( float progress);

/*!
 *  @class DHAPIMessage
 *  @abstract API消息基类
 */
@interface DHAPIMessage : BeeMessage
{
    APIMessageBlock _handleMessageBlock;
    APIMessageBlockP _progressBlock;
}

/*!
 *  处理消息回调block
 */
@property (nonatomic,copy) APIMessageBlock handleMessageBlock;
@property (nonatomic,copy) APIMessageBlockP progressBlock;

/*!
 *  发送请求
 *
 *  @param msg   请求路径
 *  @param block 请求状态block
 *
 *  @return 消息对象
 */
+ (DHAPIMessage *)sendAPIMessage:(NSString *)msg withBlock:(APIMessageBlock)block;
+ (DHAPIMessage *)sendAPIMessage:(NSString *)msg withBlock:(APIMessageBlock)block timeoutSeconds:(NSTimeInterval)seconds;
+ (void)sendAPIMessage:(NSString *)msg
                params:(NSDictionary *)pragma
               sending:(APIMessageBlock)sending
               succeed:(APIMessageBlock)succeed
                failed:(APIMessageBlock)failed
              canceled:(APIMessageBlock)canceled;

@end
