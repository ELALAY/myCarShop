import 'package:flutter/material.dart';

import '../components/mycar_box.dart';
import 'new_car_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find your car'),
      ),
      drawer: const Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                // person icon
                Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(25.0)),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white30,
                    )),
                const SizedBox(
                  width: 25,
                ),
                // Hello world!
                const Text(
                  'Hi Aymane',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const MyCarbox(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navNewCarScreen,
        child: const Icon(Icons.car_crash_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined), label: 'Account'),
      ]),
    );
  }

  void navNewCarScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const NewCarFormScreen(); // replace with your settings screen
    }));
  }
}
