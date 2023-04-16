import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../utils/constants/sizes.dart';
import '../../utils/controllers/profile_controller.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  _AllUsersScreen createState() => _AllUsersScreen();
}

class _AllUsersScreen extends State<AllUsersScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFC0FFE8),
        centerTitle: true,
        leading: IconButton(
            color: Colors.black,
            icon: const Icon(LineAwesomeIcons.angle_left),
            onPressed: () => Get.back()),
        title: const Text(
          'Available Users',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: FutureBuilder(
            future: controller.getAllUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: ((context, index) {
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ListTile(
                              iconColor: Colors.blue,
                              tileColor: Colors.blue.withOpacity(0.1),
                              leading: const Icon(
                                LineAwesomeIcons.user_circle_1,
                                size: 40.0,
                              ),
                              title: Text(
                                "${snapshot.data![index].fullName}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data![index].phoneNo),
                                  Text(snapshot.data![index].email),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10)
                        ],
                      );
                    }),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(child: Text('Something went wrong'));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   index: 2,
      //   height: 60,
      //   backgroundColor: Colors.transparent,
      //   color: const Color.fromARGB(255, 221, 255, 242),
      //   animationDuration: const Duration(milliseconds: 350),
      //   items: const <Widget>[
      //     Icon(
      //       Icons.home,
      //       color: Colors.black,
      //     ),
      //     Icon(
      //       Icons.wifi_tethering,
      //       // icon: const Icon(Icons.wifi_tethering),
      //       color: Colors.black,
      //       // onPressed: () {
      //       //   Navigator.push(context,
      //       //       MaterialPageRoute(builder: (context) => const SearchScreen()));
      //       // }
      //     ),
      //     Icon(
      //       Icons.favorite_border,
      //       // icon: const Icon(Icons.favorite_border),
      //       color: Colors.black,
      //       // onPressed: () {
      //       //   Navigator.push(context,
      //       //       MaterialPageRoute(builder: (context) => const UpdateProfileScreen()));
      //       // }
      //     ),
      //     Icon(
      //       Icons.settings,
      //       // icon: const Icon(Icons.settings),
      //       color: Colors.black,
      //       // onPressed: () {
      //       //   Navigator.push(context,
      //       //       MaterialPageRoute(builder: (context) => const SettingsScreen()));
      //       // }
      //     ),
      //   ],
      // ),
    );
  }
}
