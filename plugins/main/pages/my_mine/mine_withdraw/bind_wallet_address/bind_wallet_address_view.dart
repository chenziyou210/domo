import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/http/cache.dart';
import 'bind_wallet_address_logic.dart';
import 'bind_wallet_address_state.dart';

/// @description:
/// @author
/// @date: 2022-06-17 13:27:41
class BindWalletAddressPage extends StatelessWidget {
  final BindWalletAddressLogic logic = Get.put(BindWalletAddressLogic());
  final BindWalletAddressState state = Get.find<BindWalletAddressLogic>().state;

  BindWalletAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(16, 16, 16, 1),
        appBar: DefaultAppBar(
          centerTitle: true,
          title: Text(
            "添加钱包地址",
            style: TextStyle(color: Colors.white, fontSize: 18.sp),
          ),
        ),
        body: GetBuilder<BindWalletAddressLogic>(
            init: logic,
            global: false,
            builder: (c) {
              return Container(
                color: Color.fromRGBO(16, 16, 16, 1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    header(),
                    renderBody(c, context),
                    SizedBox(
                      height: 8.dp,
                    ),
                    footerView(context)
                  ],
                ),
              );
            }));
  }

  Widget header() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          children: [
            Text(
              "类型",
              style:
                  TextStyle(color: AppMainColors.whiteColor70, fontSize: 14.sp),
            ),
          ],
        ));
  }

  Widget renderBody(BindWalletAddressLogic c, BuildContext context) {
    var crossAxisCount = 3;
    var childAspectRatio = 2.47;
    var h = ((MediaQuery.of(context).size.width - 40) / crossAxisCount) /
        childAspectRatio;
    return GridView.builder(
      shrinkWrap: true,
      itemCount: c.state.walletAddress.length,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(h / 2)),
              color: c.state.walletAddress[index].isSeladet == true
                  ? Color.fromRGBO(255, 30, 175, 0.1)
                  : AppMainColors.whiteColor6,
              border: new Border.all(
                  width: 1,
                  color: c.state.walletAddress[index].isSeladet == true
                      ? AppMainColors.mainColor30
                      : Colors.transparent)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ExtendedImage.network(c.state.walletAddress[index].iconUrl ?? "",
                  width: 24, height: 24, fit: BoxFit.fill),
              SizedBox(
                width: 6,
              ),
              CustomText(c.state.walletAddress[index].name ?? "",
                  fontSize: 12.sp,
                  color: c.state.walletAddress[index].isSeladet == true
                      ? AppMainColors.mainColor
                      : AppMainColors.whiteColor70)
            ],
          ),
        ).gestureDetector(onTap: () {
          logic.seleWallet(index);
        });
      },
    );
  }

  Widget footerView(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "钱包地址",
                style: TextStyle(
                    color: AppMainColors.whiteColor70, fontSize: 14.sp),
              ),
            ],
          ),
          SizedBox(
            height: 8.dp,
          ),
          CustomTextField(
            hintText: "请输入钱包地址",
            hintTextStyle:
                TextStyle(color: AppMainColors.whiteColor20, fontSize: 14.sp),
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
            controller: logic.state.controller,
            inputFormatter: [
              LengthLimitingTextInputFormatter(16),
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]|[0-9]")),
            ],
            onChange: (text) {
              logic.iputText(text);
            },
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: AppMainColors.whiteColor6,
            height: 0.5,
          ),
          SizedBox(
            height: 30,
          ),
          Opacity(
            opacity: (logic.state.controller.text.length > 3 &&
                    logic.state.seleData.isSeladet == true)
                ? 1
                : 0.3,
            child: Container(
              decoration: BoxDecoration(
                  color: AppMainColors.mainColor,
                  borderRadius: BorderRadius.all(Radius.circular(20.dp)),
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(255, 101, 200, 1),
                    AppMainColors.mainColor
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              margin: EdgeInsets.all(16),
              height: 40.dp,
              width: MediaQuery.of(context).size.width - 32 * 2,
              child: TextButton(
                onPressed: () {
                  logic.bindWalletAddress();
                },
                child: Text(
                  "绑定",
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              ),
            ),
          ),
          Text(
            "*请妥善填写信息，绑定后不可更改",
            style:
                TextStyle(color: AppMainColors.whiteColor70, fontSize: 14.sp),
          )
        ],
      ),
    );
  }
}
