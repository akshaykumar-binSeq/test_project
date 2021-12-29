import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_data_controller.dart';

class UserDataView extends GetView<UserDataController> {
  final control = Get.put(UserDataController());

  UserDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    control.getLocalUserData();
    return Scaffold(
      body: Obx(() => (control.userData.isNotEmpty)
          ? SingleChildScrollView(
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: control.userData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        child: Column(children: [
                      Text(
                        "Name: ${control.userData[index].name}",
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text("email: ${control.userData[index].email}"),
                      Text("mobile: ${control.userData[index].mobile}"),
                      Text("Gender: ${control.userData[index].gender}"),
                    ]));
                  }),
            )
          : const Center(
              child: Text(
              "User data is empty",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ))),
    );
  }
}
