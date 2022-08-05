import 'package:star_common/generated/bank_list_entity.dart';

/// @description:
/// @author
/// @date: 2022-06-07 15:55:38
class SeletMyBankState {
  SeletMyBankState() {
    ///Initialize variables
  }

  int showIndex = 0;
  List<BankListData> bankList = [];
  List<BindWalletListEntity> walletList = [];
}
