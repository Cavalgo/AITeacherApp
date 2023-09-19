import 'package:flutter/material.dart';

PreferredSizeWidget chatAppBar({
  required BuildContext context,
}) {
  return AppBar(
    leading: IconButton(
      onPressed: () {},
      icon: const Icon(Icons.arrow_back),
    ),
    title: const Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(
            'assets/images/virtualAssistant.png',
          ),
        ),
        SizedBox(
          width: 12.5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Carlos Vallejo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              'ChatGPT',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        )
      ],
    ),
    actions: [
      Container(
        margin: const EdgeInsets.only(right: 10),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.add,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
    ],
  );
}
