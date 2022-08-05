/*
 *  Copyright (C), 2015-2020 , schw
 *  FileName: text_input_formatter
 *  Author: Tonight丶相拥
 *  Date: 2020/12/18
 *  Description: 
 **/

part of appcommon;

class OnlyInputInt extends TextInputFormatter {
  OnlyInputInt([this.maxValue]);
  final int? maxValue;
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // TODO: implement formatEditUpdate
    if (newValue.text.length > 0) {
      if (positiveInteger.firstMatch(newValue.text) != null) {
        if (maxValue != null) {
          int value = int.tryParse(newValue.text) ?? 0;
          if (value > maxValue!) {
            return oldValue;
          }
        }
        return newValue;
      }
      return oldValue;
    }
    return newValue;
    // return TextEditingValue().copyWith(text: "$minInteger",
    //     composing: TextRange(start: 0, end: 1),
    //     selection: oldValue.selection
    // );
  }
}

class OnlyInputNumberAndWorkFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // TODO: implement formatEditUpdate
    if (newValue.text.length > 0) {
      if (onlyInputNumberAndWork.firstMatch(newValue.text) != null) {
        return newValue;
      }
      return oldValue;
    }
    return newValue;
  }
}

//忽略特殊字符
class IgnoreOtherFormatter extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.text.length>0){
      if(ignoreOther.firstMatch(newValue.text)!=null){
        return newValue;
      }
      return oldValue;
    }
    return newValue;
  }
}

/// 只能输入数字和小写字母
class OnlyInputNumberAndLowWorkFormatter extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.text.length>0){
      if(onlyInputNumberAndLowWork.firstMatch(newValue.text)!=null){
        return newValue;
      }
      return oldValue;
    }
    return newValue;
  }
}