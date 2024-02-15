import 'package:flutter/material.dart';
import 'package:getx/controllers/users/user_controller.dart';
import 'package:getx/models/users/user_model.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/auth/authentication.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Authentication authentication = Get.put(Authentication());
  final userController = UserController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Color.fromARGB(157, 183, 0, 255),
            Color.fromARGB(218, 55, 0, 255),
            Color.fromARGB(255, 0, 140, 255),
          ])),
        ),
        FutureBuilder<UserModel?>(
            future: userController.user(),
            builder: (context, snapshot) {
              UserModel? user = snapshot.data;
              if (user != null) {
                UserModel userData = user;
                final imageUrl = userData.imageProfile;
                return RefreshIndicator(
                  onRefresh: () {
                    return userController.user();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 50, left: 20, right: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.025,
                            ),
                            Text(
                              userData.nama,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 24),
                            ),
                            Text(
                              userData.noInduk,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                            Text(
                              userData.noHp,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  fontSize: 16),
                            )
                          ],
                        ),
                        CircleAvatar(
                          radius: 50,
                          backgroundColor:
                              const Color.fromARGB(255, 255, 11, 243),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://bank-bosnikintsiapapua.com/sis/assets/img/profile/siswa/$imageUrl',
                            ),
                            radius: 48,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }),
        Padding(
          padding: const EdgeInsets.only(
            top: 180,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.height * 0.02, vertical: size.width * 0.05),
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      _dialogBuilder(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.logout_outlined,
                                color: Color.fromARGB(255, 255, 11, 243)),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            const Text(
                              'Keluar',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 11, 243),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          color: Color.fromARGB(255, 255, 11, 243),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Logout'),
            content: const Text(
              'Apakah anda ingin keluar dari aplikasi!',
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Tidak'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Ya'),
                onPressed: () {
                  authentication.removeToken();
                },
              ),
            ],
          );
        });
  }
}
