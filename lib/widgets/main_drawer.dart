import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.teal),
            child: Center(
              child: Text("Menu",
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
          ),
          ListTile(
            title: const Text("Home"),
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
          ListTile(
            title: const Text("Projects"),
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/projects'),
          ),
          ListTile(
            title: const Text("Tasks"),
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/tasks'),
          ),
        ],
      ),
    );
  }
}
