import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hjnzb/pages/choose_area_code/area_code_model.dart';
import 'package:hjnzb/pages/choose_area_code/city_logic.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';


class CityListPage extends StatefulWidget {
  @override
  _CityListPageState createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  final CityLogic logic = CityLogic();

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.dp),
      child: Column(
        children: List.generate(
          logic.state.hotCityList.length,
          (index) => getDefaultCode(logic.state.hotCityList, index),
        ),
      ),
    );
  }

  Widget getDefaultCode(List<AreaCodeModel> hotCityList, int index) {
    int size = hotCityList.length;
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: 50.dp,
          child: CustomText(
              "${hotCityList[index].name!}+${hotCityList[index].tel}",
              fontSize: 16.sp,
              fontWeight: w_400,
              color: Colors.white),
        ),
        index < size
            ? CustomDivider(
                color: AppMainColors.separaLineColor6,
              )
            : Container()
      ],
    ).gestureDetector(onTap: () {
      Navigator.pop(context, hotCityList[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CityLogic>(
        init: logic,
        builder: (logic) {
          return Obx(
            () => Scaffold(
              resizeToAvoidBottomInset: false,
              body: Column(
                children: [
                  DefaultAppBar(
                    centerTitle: true,
                    leading: IconButton(
                      icon: Image.asset(
                        R.comAppbarBack,
                        width: 24.dp,
                        height: 24.dp,
                      ),
                      onPressed: () => Get.back(),
                    ),
                    title: CustomText("选择国家或地区",
                        fontSize: 18.sp, color: Colors.white),
                  ),
                  _searchBar(),
                  SizedBox(
                    height: 16.dp,
                  ),
                  Visibility(child: _buildHeader(), visible: logic.state.txtSearch.isNotEmpty,),
                  Visibility(child: AzListView(
                    data: logic.state.cityList,
                    itemCount: logic.state.cityList.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) return _buildHeader();
                      AreaCodeModel model = logic.state.cityList[index];
                      return getListItem(context, model);
                    },
                    padding: EdgeInsets.zero,
                    susItemBuilder: (BuildContext context, int index) {
                      AreaCodeModel model = logic.state.cityList[index];
                      String tag = model.getSuspensionTag();
                      if ("dd" == tag) {
                        return Container();
                      }
                      return getSusItem(context, tag);
                    },
                    indexBarData: logic.state.listChars,
                  ).expanded(), visible: logic.state.txtSearch.isEmpty,)
                ],
              ),
            ),
          );
        });
  }

  Widget getListItem(BuildContext context, AreaCodeModel model,
      {double susHeight = 50}) {
    return Column(
      children: [
        ListTile(
          title: Text(
            "${model.name!} +${model.tel}",
            style: TextStyle(
                fontWeight: w_400, fontSize: 16.sp, color: Colors.white),
          ),
          onTap: () {
            Navigator.pop(context, model);
          },
        ),
        CustomDivider(
          color: AppMainColors.separaLineColor6,
        )
      ],
    );
  }

  Widget getSusItem(BuildContext context, String tag, {double susHeight = 50}) {
    return Container(
      height: susHeight,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 16.0),
      color: AppMainColors.separaLineColor6,
      alignment: Alignment.centerLeft,
      child: Text(
        '$tag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.white70,
        ),
      ),
    );
  }

  _searchBar() {
    return Row(
      children: [
        Container(
          height: 32.dp,
          margin: EdgeInsets.symmetric(horizontal: 16.dp),
          decoration: BoxDecoration(
              color: Color(0x0FFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(24.dp)),
              border: Border.all(color: Color(0x1AFFFFFF), width: 1.dp)),
          child: Row(
            children: [
              SizedBox(
                width: 12.dp,
              ),
              Image.asset(
                R.icSearch,
                width: 16.dp,
                height: 16.dp,
              ),
              SizedBox(
                width: 12.dp,
              ),
              Flexible(
                child: CustomTextField(
                  onChange: (txt) {
                    logic.search(txt);
                  },
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  hintText: '搜索所在地区',
                  controller: logic.state.txtController,
                  hintTextStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: Color(0x33FFFFFF)),
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: Color(0xFFFFFFFF)),
                ),
              )
            ],
          ),
        ).expanded()
      ],
    );
  }
}
