import 'package:get/get.dart';
import 'package:user_data_from_api/app/data/model/data_model.dart';
import 'package:user_data_from_api/app/data/resources/api_provider/api_provider.dart';

class HomeController extends GetxController {
  List<UserDetails>? usersData;
  var userDatas = [].obs;

  Future getUserDataList() async {
    List<UserDetails>? userData = await ApiProvider().getUserDataList();
    if (userData != null) {
      usersData = userData;
      userDatas.value = usersData!;
    } else {
      print("User data is null");
    }
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
