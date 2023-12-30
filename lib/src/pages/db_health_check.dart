import 'package:flutter/material.dart';

class DBHealthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        SizedBox(
          width: 300,
          height: 100,
          child: Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              child: const Center(
                child: Text('c1'),
              ),
              onTap: () => debugPrint('c1'),
            ),
          ),
        ),
        SizedBox(
          width: 300,
          height: 100,
          child: Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              child: const Center(
                child: Text('c1'),
              ),
              onTap: () => debugPrint('c1'),
            ),
          ),
        ),
      ],
    );
  }
}
