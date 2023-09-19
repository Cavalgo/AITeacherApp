import 'dart:developer';

import 'package:ai_chat_voice/Widgets/generic_alet_diaglo.dart';
import 'package:ai_chat_voice/bloc/auth_bloc/auth_bloc.dart';
import 'package:ai_chat_voice/bloc/auth_bloc/auth_event.dart';
import 'package:ai_chat_voice/services/authentication/fb_auth_service.dart';
import 'package:ai_chat_voice/views/home_page/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/firestore/fs_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _userName = '';
  late FirestoreProvider _fsProvider;
  @override
  void initState() {
    _fsProvider = FirestoreProvider();
    _userName = FBAuthService().myUser!.name;
    super.initState();
    _init();
  }

  Future<void> _init() async {
    log('message');
    await _fsProvider.initilize();
    await _fsProvider.getConversaionAIsHistory();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.lightGreen,
          title: Text(
            'Welcome ${_userName ?? ''} 👋!',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 3),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    size: 27,
                    color: Colors.red,
                  )),
            )
          ],
          //Bottom
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: TabBar(
              onTap: (selectedTabIndex) {
                log(selectedTabIndex.toString());
              },
              indicatorColor: Colors.deepPurple,
              labelColor: Colors.deepPurple,
              isScrollable: true,
              indicatorPadding: const EdgeInsets.only(bottom: 4),
              unselectedLabelColor: Colors.white.withAlpha(150),
              tabs: getCategories(),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage('assets/images/virtualAssistant.png'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Carlos Vallejo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'carlos@gmail.com',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    const Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                onTap: () async {},
              ),
              const Divider(),
              ListTile(
                title: Row(
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                      child: Icon(
                        Icons.logout,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                onTap: () async {
                  bool? userDecision = await showGenericAlertDialog(
                    context: context,
                    title: "Logout?",
                    content: "Are you sure you want to\nlogout?",
                    buttonsAndWhatTheyReturn: [
                      {'NO': false},
                      {'YES': true},
                    ],
                  );
                  if (userDecision == true) {
                    context.read<AuthBloc>().add(const AuthEventLogOut());
                  }
                },
              ),
            ],
          ),
        ),
        //**************** Body ****************/
        body: Container(
          margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
          child: TabBarView(
            children: [
              FutureBuilder(
                future: _fsProvider.getConversaionAIsHistory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final data = snapshot.data!;
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                data[index].pictureLink,
                              ),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.3),
                                BlendMode.darken,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                data[index].description,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const Text('2'),
              const Text('3'),
              const Text('4'),
              const Text('5'),
            ],
          ),
        ),
      ),
    );
  }
}
