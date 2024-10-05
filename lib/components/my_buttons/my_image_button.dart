import 'package:flutter/material.dart';

class MyImageButton extends StatefulWidget {
  final String icon;
  final String action;
  const MyImageButton({super.key, required this.icon, required this.action});

  @override
  State<MyImageButton> createState() => _MyImageButtonState();
}

class _MyImageButtonState extends State<MyImageButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80.0,
          width: 100.0,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border:Border.all(color: Colors.pink, width: 5),
          ),
          child: Image.asset(
            'lib/Images/${widget.icon}.gif',
            // color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(widget.action,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            )),
      ],
    );
  }
}
