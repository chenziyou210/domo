import 'package:flutter/material.dart';
import '../app_common_widget.dart';

class SignatureWidget extends StatelessWidget {
  SignatureWidget({Key? key, required this.signature}) : super(key: key);

  final String? signature;

  @override
  Widget build(BuildContext context) {
    if(signature == null){
      return Container();
    }
    return CustomText(signature!.isEmpty ? "TA好像忘记签名了" : signature!,
        style: TextStyle(
            fontSize: 12.sp,
            fontWeight: w_400,
            color: Colors.white.withOpacity(0.4)));
  }
}
