import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef NavigateFunction = void Function();

class Features extends StatelessWidget {
  final Color color;
  final String title;
  final String text;
  NavigateFunction myNavFunc;

  Features({
    super.key,
    required this.color,
    required this.title,
    required this.text,
    required this.myNavFunc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: myNavFunc,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
