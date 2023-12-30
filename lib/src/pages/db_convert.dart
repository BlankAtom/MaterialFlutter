import 'package:flutter/material.dart';

class DBConvertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.file_present),
            title: Text("todo.txt"),
            onTap: ()  {
              debugPrint('dodo');
            },
            trailing: Text('Hl'),
          ),
          ListTile(
            leading: Icon(Icons.file_present),
            title: Text("todo.txt"),
            onTap: ()  {
              debugPrint('dodo');
            },
            subtitle: Text('subtitle'),
            trailing: Text('trailing'),
          )
        ],
      )
    );
  }

}

class dir_item {
  final String name;
  final String lastUpdateTime;

  dir_item(this.name, this.lastUpdateTime);
}