//
//  EnmuDefines.h
//  GoDate
//
//  Created by lei zhang on 13-7-29.
//  Copyright (c) 2013年 www.b5m.com. All rights reserved.
//

#ifndef EnumDefines_h
#define EnumDefines_h


// section index marco
enum eTableViewSectionIndex {
    eSectionIndex00 = 0,
    eSectionIndex01 ,
    eSectionIndex02 ,
    eSectionIndex03 ,
    eSectionIndex04 ,
    eSectionIndex05 ,
    eSectionIndex06 ,
    eSectionIndex07 ,
    eSectionIndex08 ,
    eSectionIndex09 ,
    eSectionIndex10 ,
    
    eSectionIndex11 ,
    eSectionIndex12 ,
    eSectionIndex13 ,
    eSectionIndex14 ,
    eSectionIndex15 ,
    eSectionIndex16 ,
    eSectionIndex17 ,
    eSectionIndex18 ,
    eSectionIndex19 ,
    eSectionIndex20 ,
    eSectionIndex21
};

//row index marco
enum eTableViewRowIndex {
    eTableViewRowIndex00 = 0,
    eTableViewRowIndex01 ,
    eTableViewRowIndex02 ,
    eTableViewRowIndex03 ,
    eTableViewRowIndex04 ,
    eTableViewRowIndex05 ,
    eTableViewRowIndex06 ,
    eTableViewRowIndex07 ,
    eTableViewRowIndex08 ,
    eTableViewRowIndex09 ,
    eTableViewRowIndex10 ,
    
    eTableViewRowIndex11 ,
    eTableViewRowIndex12 ,
    eTableViewRowIndex13 ,
    eTableViewRowIndex14 ,
    eTableViewRowIndex15 ,
    eTableViewRowIndex16 ,
    eTableViewRowIndex17 ,
    eTableViewRowIndex18 ,
    eTableViewRowIndex19 ,
    eTableViewRowIndex20 ,
    eTableViewRowIndex21
};

// section index marco
enum stateButtonType {
    buttonTypeFirst = 1,
    buttonTypeSecond
};


typedef enum {
    kAST_SupportCamera = 0,
    kAST_UnsupportCamera,
    kAST_QuitLogin,
    kAST_CleanCache,
}ActionSheetType;

typedef enum
{
    eWishDetailTypeNew          = 101,
    eWishDetailTypeWillSelect   = 102,
    eWishDetailTypeSeleted      = 103,
//    eWishDetailTypePayed        = 104,
    eWishDetailTypeDone         = 201,
    eWishDetailTypeFailed       = 202,
    eWishDetailTypeClose        = 203,
    eWishDetailTypeReject       = 204,
    
} eWishDetailType;

enum {
    eWepActionsNone             = 0,
    eWebActionsOpenInSafari     = 1 << 0,
    eWebActionsWeiBo            = 1 << 1,
    eWebCopyLink                = 1 << 2
};

typedef NSUInteger eWebActions;

// upload picture type marco
enum UploadPictureType {
    eUploadPicTypePhoto = 0,
    eUploadPicTypeAvator,
    eUploadPicTypeChangeAvator,
    eUploadPictypeCertificate
};

enum MessageType {
    eMessageTypeSingleImageText = 1,
    eMessageTypeMultiImageText,
    eMessageTypeTxt,
    eMessageTypeImage,
    eMessageTypeVioce,
    eMessageTypeVideo,
    eMessageTypeAction,
    eMessageTypePosition,
    eMessageTypeSceneChatGoodsList = 9,
    eMessageTypeSceneChatBook = 21,
    eMessageTypeSceneChatInvite = 22,
    eMessageTypeSceneChatDestory = 23
    };


enum MeetingMijiButtonType {
    eButtonTypeMeeting = 0,
    eButtonTypeNearby,
    eButtonTypeTopHotList,
    eButtonTypeWishes,
    eButtonTypeChannel,
    eButtonTypeOther
};


typedef enum {
    JSMessagesViewTimestampPolicyAll = 0,
    JSMessagesViewTimestampPolicyAlternating,
    JSMessagesViewTimestampPolicyEveryThree,
    JSMessagesViewTimestampPolicyEveryFive,
    JSMessagesViewTimestampPolicyCustom
} JSMessagesViewTimestampPolicy;


#endif

