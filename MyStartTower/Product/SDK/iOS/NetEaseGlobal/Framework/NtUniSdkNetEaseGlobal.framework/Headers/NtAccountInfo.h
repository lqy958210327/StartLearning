//
//  NtAccountInfo.h
//  NtUniSdkLine
//
//  Created by UniSDK on 14-9-16.
//  Copyright (c) 2014年 Game-NetEase. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, NtRelationType) {
    NT_RELATION_TYPE_SELF       = 0,  ///< 用户本身
    NT_RELATION_TYPE_Friend     = 1,  ///< 关注
    NT_RELATION_TYPE_Follower   = 2,   ///< 粉丝
    NT_RELATION_TYPE_Bilateral  = 3   ///< 双向关注
};


/**
 *  @brief  用户信息
 */
@interface NtAccountInfo : NSObject


@property(nonatomic,copy) NSString *accountId,*idType,*nickname,*icon,*remark,*statusMessage,*gender;
@property(nonatomic,assign) double rankScore; //分数
@property(nonatomic,assign) long rank;      //排名
@property(nonatomic,assign) BOOL inGame;
@property(nonatomic, assign) NtRelationType relationType;

/**
 *  @brief  将NtAccountInfo对象转成json格式的字符串
 *  @return json格式字符串
 */
- (NSString *)jsonString;

@end
