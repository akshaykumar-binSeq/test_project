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
            backgroundColor: Colors.blue[900],
            title: const Text('USER DETAILS'),
            centerTitle: true,
            bottom: const TabBar(
              indicatorWeight: 4.0,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.blueGrey,
              labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              tabs: [
                Tab(
                  //height: 60,
                  iconMargin: EdgeInsets.only(top: 10.0, bottom: 8.0),
                  icon: Icon(
                    Icons.cloud,
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
                    Icons.sd_storage,
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
        Container(
          color: Colors.green[100],
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              const Text(
                " ADD USER DATA ",
                style: TextStyle(fontSize: 14),
              ),
              IconButton(
                onPressed: () async {
                  _addUser(context).show();
                  await control.getUserDataList();
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        Obx(() => (control.userDatas.isNotEmpty)
            ? Obx(
                () => Expanded(
                  child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: control.userDatas.length,
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
                                    Text("${control.userDatas[index].name}",
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
                                    Text("${control.userDatas[index].email}",
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
                                    Text("${control.userDatas[index].mobile}",
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
                                    Text("${control.userDatas[index].gender}",
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
                              Container(
                                width: MediaQuery.of(context).size.width,
                                color: Colors.blue[400],
                                child: Row(
                                  children: [
                                    const Text("  UPDATE DETAIL",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.0,
                                            color: Colors.black)),
                                    IconButton(
                                        onPressed: () async {
                                          _updateUser(context,
                                                  "${control.usersData![index].id}")
                                              .show();
                                          //await control.getUserDataList();
                                        },
                                        icon: const Icon(Icons.update)),
                                    const Text("  DELETE DATA",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.0,
                                            color: Colors.black)),
                                    Obx(
                                      () => (control.isLoading.value)
                                          ? const CircularProgressIndicator()
                                          : IconButton(
                                              onPressed: () async {
                                                control.isLoading.value = true;
                                                await ApiProvider().deleteUserData(
                                                    "${control.usersData![index].id}");
                                                await control.getUserDataList();
                                                control.isLoading.value = false;
                                              },
                                              icon: const Icon(
                                                  Icons.delete_forever)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              )
            : const Center(child: CircularProgressIndicator())),
      ],
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
