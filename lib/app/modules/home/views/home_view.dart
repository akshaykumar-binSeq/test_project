import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user_data_from_api/app/data/resources/api_provider/api_provider.dart';
import 'package:user_data_from_api/app/modules/user_data/views/user_data_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final control = Get.put(HomeController());
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // control.getUserDataList();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('User Details'),
            centerTitle: true,
            bottom: const TabBar(
              indicatorWeight: 4.0,
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.blueGrey,
              labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              tabs: [
                Tab(
                  //height: 60,
                  iconMargin: EdgeInsets.only(top: 10.0, bottom: 8.0),
                  icon: Icon(
                    Icons.widgets,
                    size: 18,
                  ),
                  child: Expanded(
                    child: Text("User API"),
                  ),
                ),
                Tab(
                  //height: 60,
                  iconMargin: EdgeInsets.only(top: 10.0, bottom: 8.0),
                  icon: Icon(
                    Icons.widgets,
                    size: 18,
                  ),
                  child: Expanded(
                    child: Text("User Local"),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(children: [_userDataList(context), UserDataView()])),
    );
  }

  _userDataList(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () async {
            _addUser(context).show();
            await control.getUserDataList();
          },
          icon: const Icon(Icons.add),
        ),
        Obx(() => (control.userDatas.isNotEmpty)
            ? Obx(
                () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: control.userDatas.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Column(
                          children: [
                            Text(
                              "Name: ${control.userDatas[index].name}",
                              style: const TextStyle(color: Colors.black),
                            ),
                            Text("email: ${control.userDatas[index].email}"),
                            Text("mobile: ${control.userDatas[index].mobile}"),
                            Text("Gender: ${control.userDatas[index].gender}"),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      _updateUser(context,
                                              "${control.usersData![index].id}")
                                          .show();
                                      //await control.getUserDataList();
                                    },
                                    icon: const Icon(Icons.update)),
                                IconButton(
                                    onPressed: () async {
                                      await ApiProvider().deleteUserData(
                                          "${control.usersData![index].id}");
                                      await control.getUserDataList();
                                    },
                                    icon: const Icon(Icons.delete_forever)),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              )
            : const Center(child: CircularProgressIndicator())),
      ],
    );
  }

  Alert _addUser(BuildContext context) {
    return Alert(
        context: context,
        title: "Add User Data",
        content: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: ("Name"),
                ),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.mail),
                  labelText: ("Email"),
                ),
              ),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone),
                  labelText: ("Mobile"),
                ),
              ),
              TextFormField(
                controller: genderController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: ("Gender"),
                ),
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              Navigator.pop(context);
              Alert(
                type: AlertType.success,
                context: context,
                title: "User Added",
                buttons: [
                  DialogButton(
                    child: const Text(
                      "COOL",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                    width: 120,
                  )
                ],
              ).show();
              if (_key.currentState!.validate()) {
                control.addUserData(nameController.text, emailController.text,
                    phoneController.text, genderController.text);
              }
            },
            child: const Text(
              "Continue",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.red,
          )
        ]);
  }

  // Alert _addUser(BuildContext context) {
  //   return
  // }

  Alert _updateUser(BuildContext context, String id) {
    return Alert(
        context: context,
        title: "Update User Data",
        content: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: ("Name"),
                ),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.mail),
                  labelText: ("Email"),
                ),
              ),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone),
                  labelText: ("Mobile"),
                ),
              ),
              TextFormField(
                controller: genderController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: ("Gender"),
                ),
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              Navigator.pop(context);
              Alert(
                type: AlertType.success,
                context: context,
                title: "User Updated",
                buttons: [
                  DialogButton(
                    child: const Text(
                      "COOL",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                    width: 120,
                  )
                ],
              ).show();
              if (_key.currentState!.validate()) {
                control.updataUsersData(
                    nameController.text,
                    emailController.text,
                    phoneController.text,
                    genderController.text,
                    id);
              }
              await control.getUserDataList();
            },
            child: const Text(
              "Update",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.red,
          )
        ]);
  }
}
