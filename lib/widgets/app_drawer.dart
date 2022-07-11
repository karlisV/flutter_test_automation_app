import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../screens/auth_screen.dart';

import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  String userEmail() {
    return FirebaseAuth.instance.currentUser!.email!;
  }

  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text(userEmail()),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            trailing: const Icon(Icons.exit_to_app),
            leading: const Text("Logout"),
            onTap: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
