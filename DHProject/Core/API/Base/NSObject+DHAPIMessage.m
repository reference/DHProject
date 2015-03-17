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

#import "NSObject+DHAPIMessage.h"

@implementation NSObject (DHAPIMessage)

- (DHAPIMessage *)APIMessage:(NSString *)msg {
    return [self APIMessage:msg timeoutSeconds:60.0f];
}

- (DHAPIMessage *)APIMessage:(NSString *)msg timeoutSeconds:(NSTimeInterval)seconds {
    DHAPIMessage *apiMsg = [DHAPIMessage new];
    apiMsg.message = msg;
    apiMsg.seconds = seconds > 0 ? seconds : 60.0f;
    apiMsg.responder = self;
    return apiMsg;
}

- (DHAPIMessage *)sendAPIMessage:(NSString *)msg {
    return (DHAPIMessage *)[[self APIMessage:msg] send];
}

- (DHAPIMessage *)sendAPIMessage:(NSString *)msg timeoutSeconds:(NSTimeInterval)seconds {
    return (DHAPIMessage *)[[self APIMessage:msg timeoutSeconds:seconds] send];
}


- (DHAPIMessage *)sendAPIMessage:(NSString *)msg only:(BOOL)only
{
    if (!msg)return nil;
    
    if (only)
    {
        NSArray * msgs = [[BeeMessageQueue sharedInstance] allMessages];
        for (BeeMessage * m in msgs)
        {
            if ([m is:msg])
            {
                return (DHAPIMessage *)m;
            }
        }
    }
    
    return [self sendAPIMessage:msg];
}

@end
