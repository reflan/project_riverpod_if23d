import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:project_riverpod/providers/home_provider.dart';
import 'package:project_riverpod/screens/dashboard_screen.dart';
import 'package:project_riverpod/screens/mahasiswa/mahasiswa_add_screen.dart';
import 'package:project_riverpod/screens/mahasiswa/mahasiswa_screen.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeController = ref.watch(HomeProvider);

    return DashboardAdmin();
  }
}

final indexProvider = StateProvider<int>((ref) => 0);

class DashboardAdmin extends ConsumerWidget {
  const DashboardAdmin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _index = ref.watch(indexProvider);

    List<Map> _fragment = [
      {
        'title': 'Halaman Utama',
        'view': DashboardScreen(),
        'add': MahasiswaAddScreen(),
      },
      {
        'title': 'Data Mahasiswa',
        'view': MahasiswaScreen(),
        'add': MahasiswaAddScreen(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(_fragment[_index]['title']),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => _fragment[_index]['add'],
                ),
              );
            },
            icon: Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      body: _fragment[_index]['view'],
      drawer: drawer(ref, context), // fitur menu di samping
    );
  }

  Widget drawer(WidgetRef ref, BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.teal),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.account_circle, size: 80, color: Colors.white),
                Text(
                  "Reflan Nuari",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Admin',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              ref.read(indexProvider.notifier).state = 0;
              Navigator.pop(context);
            },
            leading: Icon(Icons.home),
            title: Text("Halaman Utama"),
            trailing: Icon(Icons.navigate_next),
            iconColor: Colors.teal,
            textColor: Colors.teal,
          ),
          ListTile(
            onTap: () {
              ref.read(indexProvider.notifier).state = 1;
              Navigator.pop(context);
            },
            leading: Icon(Icons.people),
            title: Text("Mahasiswa"),
            trailing: Icon(Icons.navigate_next),
            iconColor: Colors.teal,
            textColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
