import 'package:get/get.dart';
import 'package:user_data_from_api/app/data/model/data_model.dart';
import 'package:user_data_from_api/app/data/resources/api_provider/api_provider.dart';
import 'package:user_data_from_api/app/data/resources/database_provider/data_sql.dart';
import 'package:user_data_from_api/app/modules/user_data/controllers/user_data_controller.dart';

class HomeController extends GetxController {
  final localControl = Get.put(UserDataController());

  List<UserDetails>? usersData;
  var userDatas = [].obs;

  Future getUserDataList() async {
    List<UserDetails>? userData = await ApiProvider().getUserDataList();
    if (userData != null) {
      usersData = userData;
      userDatas.value = usersData!;
      addDataLocal(usersData!);
    } else {
      print("User data is null");
    }
  }

  addDataLocal(List<UserDetails> userData) async {
    DatabaseSql databaseSql = DatabaseSql();
    await databaseSql.openDatabaseSql();
    await databaseSql.deleteAllData();
    if (userData.isNotEmpty) {
      for (var map in userData) {
        await databaseSql.insertData(map);
      }
    }

    await databaseSql.getData();
    await localControl.getLocalUserData();
  }

  addUserData(name, email, phone, gender) async {
    Map data = {
      "name": name,
      "email": email,
      "mobile": phone,
      "gender": gender
    };
    await ApiProvider().createUserData(data);
    await getUserDataList();
  }

  updataUsersData(name, email, phone, gender, id) async {
    Map data = {
      "name": name,
      "email": email,
      "mobile": phone,
      "gender": gender
    };
    await ApiProvider().updateUserData(data, id);
    await getUserDataList();
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getUserDataList();
  }

  @override
  void onReady() {
    super.onReady();
    getUserDataList();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
