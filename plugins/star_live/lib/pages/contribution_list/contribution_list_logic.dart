import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/http/http_channel.dart';

import 'contribution_list_state.dart';

class ContributionListLogic extends GetxController {
  final ContributionListState state = ContributionListState();

  @override
  void onInit() {
    super.onInit();
  }

  ContributionListLogic() {
    ///Initialize variables
  }

  @override
  void onReady() {
    super.onReady();
  }

  void setUserId(String value) {
    state.userId = value;
    requestPage();
  }

  Future requestPage({void Function(String)? failure, void Function()? success}) {
    return HttpChannel.channel
        .contribute(dateType: state.tabIndex.value+1, userId: state.userId)
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            List lst = value.data['data']['data'];
            List<ContributeDataEntity> announcement =
                lst.map((e) => ContributeDataEntity.fromJson(e)).toList();
            state.setData(announcement);
            update();
            success?.call();

          },
          failure: (e) {
            failure?.call(value.err);
          }));
  }
}
