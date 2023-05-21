import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/constant/constants.dart';
import 'package:recipe/home_screen_page/data_layer/body_repository.dart';

final tabIndexProvider = StateProvider<int>((ref) => 0);

class UserProfile extends ConsumerWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This method will be called after the first frame will be drawn
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   ref.read(profileUrlProvider.notifier).state =
    //       '$baseUrl${ref.read(url.notifier).state}';
    // });

    final tabIndex = ref.watch(tabIndexProvider.state);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<Object>(
              future: getData(),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Tooltip(
                              message: "LogOut",
                              child: InkWell(
                                onTap: () {
                                  GoRouter.of(context).go('/login');
                                },
                                child: const Icon(
                                  Icons.logout,
                                  color: Colors.black,
                                  size: 30.0,
                                ),
                              ),
                            ),
                            const Text(
                              'RecipeBox',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'delius',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.amber.shade700,
                                  backgroundImage: NetworkImage(
                                      '$baseUrl${snapshot.data![0]['profile_image']}'),
                                ),
                                const SizedBox(width: 10.0)
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 50.0,
                              backgroundImage: NetworkImage(
                                  '$baseUrl${snapshot.data![0]['profile_image']}'),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${snapshot.data![0]['first_name']} ${snapshot.data![0]['last_name']}',
                                  style: const TextStyle(
                                    fontFamily: 'delius',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  '@${snapshot.data![0]['user_name']}',
                                  style: const TextStyle(
                                      fontFamily: 'delius',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                      color: smallTextColor),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey[350],
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 5.0),
                          margin: const EdgeInsets.only(right: 20.0),
                          width: double.maxFinite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    ref.read(tabIndexProvider.notifier).state =
                                        0;
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    decoration: BoxDecoration(
                                      color: tabIndex.state == 0
                                          ? const Color(0xff5165EA)
                                          : Colors.grey[350],
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Text(
                                      "View Profile",
                                      style: TextStyle(
                                          fontFamily: 'delius',
                                          fontWeight: FontWeight.bold,
                                          color: tabIndex.state == 0
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    ref.read(tabIndexProvider.notifier).state =
                                        1;
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    decoration: BoxDecoration(
                                      color: tabIndex.state == 1
                                          ? const Color(0xff5165EA)
                                          : Colors.grey[350],
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                          fontFamily: 'delius',
                                          fontWeight: FontWeight.bold,
                                          color: tabIndex.state == 1
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 13.0,
                        ),
                        ViewProfile(user: snapshot.data![0]),
                        const SizedBox(
                          height: 20.0,
                        )
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: (MediaQuery.of(context).size.height / 2) - 40),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}

class ViewProfile extends StatelessWidget {
  const ViewProfile({Key? key, required this.user}) : super(key: key);

  final user;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20.0),
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.grey.shade400.withOpacity(0.4),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
            color: Colors.grey[350],
            child: ListTile(
              leading: const Text("User Name:",
                  style: TextStyle(
                      fontFamily: 'delius',
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              title: Text(
                '@${user['user_name']}',
                style: TextStyle(
                    fontFamily: 'delius',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.teal.shade900),
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Card(
            color: Colors.grey[350],
            child: ListTile(
              leading: const Text("First Name:",
                  style: TextStyle(
                      fontFamily: 'delius',
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              title: Text(
                '${user['first_name']}',
                style: TextStyle(
                    fontFamily: 'delius',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.teal.shade900),
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Card(
            color: Colors.grey[350],
            child: ListTile(
              leading: const Text("Last Name:",
                  style: TextStyle(
                      fontFamily: 'delius',
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              title: Text(
                '${user['last_name']}',
                style: TextStyle(
                    fontFamily: 'delius',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.teal.shade900),
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Card(
            color: Colors.grey[350],
            child: ListTile(
              leading: const Text("Email:",
                  style: TextStyle(
                      fontFamily: 'delius',
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              title: Text(
                '${user['email']}',
                style: TextStyle(
                    fontFamily: 'delius',
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.teal.shade900),
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Card(
            color: Colors.grey[350],
            child: ListTile(
              leading: const Text("Joined Date:",
                  style: TextStyle(
                      fontFamily: 'delius',
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              title: Text(
                '${user['date_joined']}'.substring(0, 10),
                style: TextStyle(
                    fontFamily: 'delius',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.teal.shade900),
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }
}
