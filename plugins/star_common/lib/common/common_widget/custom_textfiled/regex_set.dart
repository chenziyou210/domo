/*
 *  Copyright (C), 2015-2020 , schw
 *  FileName: regex_set
 *  Author: Tonight丶相拥
 *  Date: 2020/12/25
 *  Description: 
 **/
part of appcommon;

/// 是否是guid
RegExp isGuid = RegExp(r"^[0-9a-zA-Z]{8}-[0-9a-zA-Z]{4}-[0-9a-zA-Z]{4}-[0-9a-zA-Z]{4}-[0-9a-zA-Z]{12}$");
/// 只能数字和字母
RegExp onlyInputNumberAndWork = RegExp(r"^[ZA-ZZa-z0-9_]+$");
/// 只能输入数字和小写字母
RegExp onlyInputNumberAndLowWork = RegExp(r"^[Za-z0-9_]+$");
/// 忽略特殊字符串
RegExp ignoreOther = RegExp(r"^[\u4E00-\u9FA5A-Za-z0-9_]+$");
/// 电话号码
RegExp isPhoneNumber = RegExp(r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$");
/// 邮箱
RegExp isEmail = RegExp(r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$");
/// url
RegExp isUrl = RegExp(r"^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+");
/// 身份证
RegExp isIdCard = RegExp(r"\d{17}[\d|x]|\d{15}");
/// 中文
RegExp isChinese = RegExp(r"[\u4e00-\u9fa5]");
/// 正整数
RegExp positiveInteger = RegExp(r"^\d+$");


/* -----输入框验证-------- **/

/// FilteringTextInputFormatter.digitsOnly 只能输入数字
/// LengthLimitingTextInputFormatter(6) 限制输入长度
/// FilteringTextInputFormatter.singleLineFormatter 限制单行输入
///
/// "^\d+$"　　//非负整数（正整数 + 0）
//
//
// "^[0-9]*[1-9][0-9]*$"　　//正整数
//
//
// "^((-\d+)|(0+))$"　　//非正整数（负整数 + 0）
//
//
// "^-[0-9]*[1-9][0-9]*$"　　//负整数
//
//
// "^-?\d+$"　　　　//整数
//
//
// "^\d+(\.\d+)?$"　　//非负浮点数（正浮点数 + 0）
//
//
// "^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$"　　//正浮点数
//
//
// "^((-\d+(\.\d+)?)|(0+(\.0+)?))$"　　//非正浮点数（负浮点数 + 0）
//
//
// "^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$"　　//负浮点数
//
//
// "^(-?\d+)(\.\d+)?$"　　//浮点数
//
//
// "^[A-Za-z]+$"　　//由26个英文字母组成的字符串
//
//
// "^[A-Z]+$"　　//由26个英文字母的大写组成的字符串
//
//
// "^[a-z]+$"　　//由26个英文字母的小写组成的字符串
//
//
// "^[A-Za-z0-9]+$"　　//由数字和26个英文字母组成的字符串
//
//
// "^\w+$"　　//由数字、26个英文字母或者下划线组成的字符串
//
//
// "^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$"　　　　//email地址
//
//
// "^[a-zA-z]+://(\w+(-\w+)*)(\.(\w+(-\w+)*))*(\?\S*)?$"　　//url