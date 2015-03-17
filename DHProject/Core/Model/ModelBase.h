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
//  模型基类
//
#import "DB.h"

@protocol ModelBaseDelegate <NSObject>
@optional

/*!
 *@method insert:
 *@abstract 向数据库插入一条数据
 *@return void
 */
- (void)insert;

/*!
 *@method deleteRowsByIds:
 *@abstract 根据id批量删除记录
 *@param ids  `NSString`对象的数组
 *@return void
 */
+ (void)deleteRowsByIds:(NSArray *)ids;

/*!
 *@method fillWithDictionary:
 *@abstract 填充数据
 *@param dictionary  数据字典
 */
- (void)fillWithDictionary:(NSDictionary *)dictionary;

@end

@interface ModelBase : NSObject <ModelBaseDelegate>
@end
