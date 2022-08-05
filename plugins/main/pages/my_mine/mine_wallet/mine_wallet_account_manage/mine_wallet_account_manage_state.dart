import 'package:star_common/generated/bank_list_entity.dart';
import 'package:hjnzb/pages/my_mine/mine_wallet/mine_wallet_logic.dart';

/// @description:
/// @author
/// @date: 2022-06-15 17:35:12
class MineWalletAccountManageState {
  MineWalletAccountManageState() {
    ///Initialize variables
  }
  WalletAccount? accountType;

  int maxAccountCount = 5;

  ///银行卡列表
  List<BankListData>? bankList;
  List<BindWalletListEntity>? walletList;
}
