import 'package:flutter/material.dart';

class ButtomNavigatorWidget extends StatelessWidget {
  final String title;
  final String new_route;
  const ButtomNavigatorWidget(
      {Key? key, required this.title, required this.new_route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                new_route, (Route<dynamic> route) => false);
          },
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.blueAccent,
              fontSize: 18,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
