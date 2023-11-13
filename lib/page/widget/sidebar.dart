import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solusi_penjualan_pangan/bloc/logout/logout_bloc.dart';
import 'package:solusi_penjualan_pangan/page/profile_penjual.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<User>(
        // Use a FutureBuilder to asynchronously load user data from SharedPreferences
        future: getUserData(),
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while data is being fetched
            return CircularProgressIndicator();
          } else {
            // Once data is fetched, build the drawer with the user information
            return ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(snapshot.data?.nama ?? 'User'),
                  accountEmail: Text(snapshot.data?.email ?? ''),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        NetworkImage(snapshot.data?.imageUrl ?? ''),
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF22692D),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserDetailView()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    // Clear user data in SharedPreferences on logout
                    clearUserData();

                    context.read<LogoutBloc>().add(const LogoutEvent());
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<User> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Fetch user data from SharedPreferences
    String userName = prefs.getString('userName') ?? "User";
    String userEmail = prefs.getString('userEmail') ?? "";
    String userImageUrl = prefs.getString('Url') ??
        "https://cdn-icons-png.flaticon.com/512/3135/3135715.png";

    return User(nama: userName, email: userEmail, imageUrl: userImageUrl);
  }

  Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Clear user data in SharedPreferences
    await prefs.remove('nama');
    await prefs.remove('email');
    await prefs.remove('imageUrl');
  }
}

class User {
  final String nama;
  final String email;
  final String imageUrl;

  User({required this.nama, required this.email, required this.imageUrl});
}
