import 'package:get/get.dart';
import 'package:star_common/router/router_config.dart';
import 'package:star_live/pages/custom_service/contact_service_page.dart';
import 'package:star_live/pages/live_room/live_room_new.dart';
import 'package:star_live/pages/live_room/mine_backpack/mine_backpack_view.dart';
import 'package:star_live/pages/live_room/mine_backpack/views/mine_edit_nickname_page.dart';
import 'package:star_live/pages/live_room/mine_my_level/mine_my_level_view.dart';
import 'package:star_live/pages/live_room/mine_my_level/views/mine_level_privilege_page.dart';
import 'package:star_live/pages/live_room/mine_my_level/views/mine_level_regulation_page.dart';
import 'package:star_live/pages/live_room_preview/live_room_preview.dart';
import 'package:star_live/pages/live_room_preview/live_room_preview_new.dart';
import 'package:star_live/pages/personal_information/my_fans/my_fans_view.dart';
import 'package:star_live/pages/personal_information/personal_data/personal_data_view.dart';
import 'package:star_live/pages/rank_main/rank_main_view.dart';
import 'package:star_live/pages/recharge/diamonds/diamonds_view.dart';
import '../business/homepage/home_search_view/home_search_view_view.dart';
import '../business/homepage/home_web_view/home_web_view_view.dart';
import '../business/login_recode/login_recode_view.dart';
import '../pages/account_security/account_security.dart';
import '../pages/advertising.dart';
import '../pages/balance_recharge/balance_recharge.dart';
import '../pages/black_list/black_list.dart';
import '../pages/change_log_in_password/change_log_in_password.dart';
import '../pages/charge/charge.dart';
import '../pages/chats_list/chats_list.dart';
import '../pages/choose_area_code/citylist_page.dart';
import '../pages/conversation/conversation.dart';
import '../pages/game/webview_game_page.dart';
import '../pages/message/views/message_system_page.dart';
import '../pages/muting_list/muting_list.dart';
import '../pages/my_mine/mine_active/mine_active_view.dart';
import '../pages/my_mine/mine_edit_info/mine_edit_info_view.dart';
import '../pages/my_mine/mine_edit_info/views/mine_edit_signature_page.dart';
import '../pages/my_mine/mine_game_record/mine_game_record_view.dart';
import '../pages/my_mine/mine_game_record/views/mine_game_bet_page.dart';
import '../pages/my_mine/mine_income_expenditure_details/mine_income_expenditure_details_view.dart';
import '../pages/my_mine/mine_noble_page/mine_noble_page_view.dart';
import '../pages/my_mine/mine_phone_approve/mine_phone_approve_view.dart';
import '../pages/my_mine/mine_phone_approve/views/mine_phone_bind_page.dart';
import '../pages/my_mine/mine_wallet/mine_wallet_view.dart';
import '../pages/my_mine/mine_withdraw/mine_withdraw_view.dart';
import '../pages/my_mine/my_mine_setting/my_mine_setting_view.dart';
import '../pages/tab/tabbar_control/tabbar_control_view.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.tab,
      page: () => TabbarControlPage(),
    ),
    GetPage(
      name: AppRoutes.livingPreviewNew,
      page: () => LiveRoomPreviewNewPage(),
    ),
    GetPage(
      name: AppRoutes.blackList,
      page: () => BlackList(),
    ),
    GetPage(
      name: AppRoutes.preview,
      page: () => LiveRoomPreviewPage(),
    ),
    GetPage(
      name: AppRoutes.conversation,
      page: () => ConversationPage(),
    ),
    GetPage(
      name: AppRoutes.conversationList,
      page: () => ChatsListPage(),
    ),
    GetPage(
      name: AppRoutes.balanceRecharge,
      page: () => BalanceRechargePage(),
    ),
    GetPage(
      name: AppRoutes.advertising,
      page: () => AdvertisingPage(),
    ),
    GetPage(
      name: AppRoutes.mutingList,
      page: () => MutingList(),
    ),
    GetPage(
      name: AppRoutes.accountSecurity,
      page: () => AccountSecurityPage(),
    ),
    GetPage(
      name: AppRoutes.changeLogInPassword,
      page: () => ChangeLogInPasswordPage(),
    ),
    GetPage(
      name: AppRoutes.userById,
      page: () => PersonalDataPage(arguments: Get.arguments),
    ),
    GetPage(
      name: AppRoutes.logInNew,
      page: () => Login_recodePage(),
    ),
    // GetPage(
    //   name: AppRoutes.logInNew,
    //   page: () => LogInNewPage(),
    // ),
    GetPage(
      name: AppRoutes.mineEditNicknamePage,
      page: () => MineEditNicknamePage(),
    ),
    GetPage(
      name: AppRoutes.mineSetting,
      page: () => MyMineSettingPage(),
    ),
    GetPage(
      name: AppRoutes.mineActive,
      page: () => MineActivePage(),
    ),
    GetPage(
      name: AppRoutes.mineNoble,
      page: () => MineNoblePage(),
    ),

    GetPage(
      name: AppRoutes.mineIncomeExpenditureDetailsPage,
      page: () => MineIncomeExpenditureDetailsPage(),
    ),

    GetPage(
      name: AppRoutes.mineGameRecordPage,
      page: () => MineGameRecordPage(),
    ),
    GetPage(
      name: AppRoutes.mineBackpackPage,
      page: () => MineBackpackPage(),
    ),
    GetPage(
      name: AppRoutes.minePhoneApprovePage,
      page: () => MinePhoneApprovePage(),
    ),
    GetPage(
      name: AppRoutes.mineMyLevelPage,
      page: () => MineMyLevelPage(),
    ),
    GetPage(
      name: AppRoutes.mineEditInfo,
      page: () => MineEditInfoPage(),
    ),
    GetPage(
      name: AppRoutes.mineWallet,
      page: () => MineWalletPage(),
    ),
    GetPage(
      name: AppRoutes.rankIntegration,
      page: () => RankMainPage(),
    ),
    GetPage(
      name: AppRoutes.audiencePage,
      page: () => AudienceNewPage(arguments: Get.arguments),
    ),
    GetPage(
      name: AppRoutes.mineWithdraw,
      page: () => MineWithdrawPage(),
    ),
    GetPage(
      name: AppRoutes.homeSearchPage,
      page: () => HomeSearchViewPage(),
    ),
    GetPage(
      name: AppRoutes.homeWebPage,
      page: () => HomeWebViewPage(arguments: Get.arguments),
    ),
    GetPage(
      name: AppRoutes.mineLevelPrivilegePage,
      page: () => MineLevelPrivilegePage(),
    ),
    GetPage(
      name: AppRoutes.contactServicePage,
      page: () => ContactServicePage(arguments: Get.arguments),
    ),
    GetPage(
      name: AppRoutes.messageSystemPage,
      page: () => MessageSystemPage(),
    ),
    GetPage(
      name: AppRoutes.mineGameBetPage,
      page: () => MineGameBetPage(),
    ),
    GetPage(
      name: AppRoutes.minePhoneBindPage,
      page: () => MinePhoneBindPage(),
    ),
    GetPage(
      name: AppRoutes.mineLevelRegulationPage,
      page: () => MineLevelRegulationPage(),
    ),
    GetPage(
      name: AppRoutes.webviewGame,
      page: () => WebViewGamePage(arguments: Get.arguments),
    ),
    GetPage(
      name: AppRoutes.chargePage,
      page: () => ChargePage(arguments: Get.arguments),
    ),
    GetPage(
      name: AppRoutes.redeemDiamonds,
      page: () => DiamondsPage(code: Get.arguments!['code']),
    ),
    GetPage(
      name: AppRoutes.mineEditSignaturePage,
      page: () => MineEditSignaturePage(),
    ),
    GetPage(
      name: AppRoutes.CityListPage,
      page: () => CityListPage(),
    ),
  ];
}
