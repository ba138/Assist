import 'package:assist/Models/user_model.dart';
import 'package:assist/auth/controller/auth_controller.dart';
import 'package:assist/history/screens/history_screen.dart';
import 'package:assist/pallete.dart';
import 'package:assist/utills/loader_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavBar extends ConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<UserModel>(
      stream: ref.watch(authControllerProvider).getCurrentUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loader();
        }
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  snapshot.data!.name,
                  style: const TextStyle(
                    fontFamily: 'Cera Pro',
                    color: Colors.black,
                  ),
                ),
                accountEmail: Text(
                  snapshot.data!.email,
                  style: const TextStyle(
                    fontFamily: 'Cera Pro',
                    color: Colors.black,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data!.profilePic)),
                decoration:
                    const BoxDecoration(color: Pallete.thirdSuggestionBoxColor),
              ),
              ListTile(
                leading: const Icon(
                  Icons.history,
                  color: Colors.black,
                ),
                title: const Text(
                  'History',
                  style: TextStyle(fontFamily: 'Cera Pro'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => const HistoryScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.add_business_outlined,
                  color: Colors.black,
                ),
                title: const Text(
                  'About',
                  style: TextStyle(fontFamily: 'Cera Pro'),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.contact_page_outlined,
                  color: Colors.black,
                ),
                title: const Text(
                  'Contact',
                  style: TextStyle(fontFamily: 'Cera Pro'),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout_outlined,
                  color: Colors.black,
                ),
                title: const Text(
                  'LogOut',
                  style: TextStyle(fontFamily: 'Cera Pro'),
                ),
                onTap: () {
                  ref.watch(authControllerProvider).logOut(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
