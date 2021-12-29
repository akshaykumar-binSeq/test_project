import 'package:get/get.dart';
import 'package:user_data_from_api/app/data/model/data_model.dart';
import 'package:user_data_from_api/app/data/resources/database_provider/data_sql.dart';

class UserDataController extends GetxController {
  List<UserDetails> _userData = [];
  var userData = [].obs;
  var loadingData = true.obs;

  getLocalUserData() async {
    loadingData.value = true;
    DatabaseSql databaseSql;
    databaseSql = DatabaseSql();
    await databaseSql.openDatabaseSql();
    _userData = await databaseSql.getData();

    userData.clear();

    for (var food in _userData) {
      userData.add(food);
    }

    loadingData.value = false;
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getLocalUserData();
  }

  @override
  void onReady() {
    super.onReady();
    getLocalUserData();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
