import 'models/personal_model.dart';

class PersonalDataState {

  PersonalModel personalModel = PersonalModel();
  String userId = '';
  bool loading = true;
  bool isMine = false;

  PersonalDataState() {
    ///Initialize variables
  }

}
