import 'package:flutter/material.dart';

class UserMessage extends StatelessWidget {
  final Map<String, String> message;
  const UserMessage({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (message['role'] == 'system') {
          return UnconstrainedBox(
            alignment: Alignment.topLeft,
            child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 15),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                  minWidth: MediaQuery.of(context).size.width * 0.2,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBFAFA),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ).copyWith(topLeft: const Radius.circular(0)),
                ),
                child: Flex(
                  mainAxisSize: MainAxisSize.min,
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      child: Text(
                        message['message']!,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                )),
          );
        } else {
          return UnconstrainedBox(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 15),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
                minWidth: MediaQuery.of(context).size.width * 0.2,
              ),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ).copyWith(topRight: const Radius.circular(0)),
              ),
              child: Flex(
                mainAxisSize: MainAxisSize.min,
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    child: Text(
                      message['message']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
