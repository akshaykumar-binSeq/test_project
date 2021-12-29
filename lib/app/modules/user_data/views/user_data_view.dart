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
                        color: Colors.indigo[100],
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                _prefixIcon(Icons.supervised_user_circle),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text('NAME',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15.0,
                                            color: Colors.blue)),
                                    const SizedBox(height: 1),
                                    Text("${control.userData[index].name}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0,
                                            color: Colors.black)),
                                  ],
                                )
                              ]),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                _prefixIcon(Icons.email),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text('EMAIL',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15.0,
                                            color: Colors.blue)),
                                    const SizedBox(height: 1),
                                    Text("${control.userData[index].email}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0,
                                            color: Colors.black)),
                                  ],
                                )
                              ]),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                _prefixIcon(Icons.phone),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text('PHONE',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15.0,
                                            color: Colors.blue)),
                                    const SizedBox(height: 1),
                                    Text("${control.userData[index].mobile}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0,
                                            color: Colors.black)),
                                  ],
                                )
                              ]),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                _prefixIcon(Icons.person),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text('GENDER',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15.0,
                                            color: Colors.blue)),
                                    const SizedBox(height: 1),
                                    Text("${control.userData[index].gender}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0,
                                            color: Colors.black)),
                                  ],
                                )
                              ]),
                              const SizedBox(
                                height: 10,
                              ),
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

  _prefixIcon(IconData iconData) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 48.0, minHeight: 48.0),
      child: Container(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          margin: const EdgeInsets.only(right: 8.0),
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                  bottomRight: Radius.circular(10.0))),
          child: Icon(
            iconData,
            size: 20,
            color: Colors.blue,
          )),
    );
  }
}
