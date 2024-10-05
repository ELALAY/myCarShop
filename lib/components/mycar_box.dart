import 'package:flutter/material.dart';

class MyCarbox extends StatefulWidget {
  const MyCarbox({super.key});

  @override
  State<MyCarbox> createState() => _MyCarboxState();
}

class _MyCarboxState extends State<MyCarbox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      width: 400,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('lib/images/2008.jpg'),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('270000 MAD'),
                Text('Peugot'),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share_outlined,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite, color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }
}
