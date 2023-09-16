import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late double _deviceWidth, _deviceHeight;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight * 0.15,
        title: const Text(
          'Timely',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: _taskList(),
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _taskList(){
    return Container(
      child: ListView(
        children: [
          Card(
            child: ListTile(
              title: const Text('Go to church'),
              subtitle: Text(DateTime.now().toString()),
              trailing: const Icon(
                Icons.check_box_outlined,
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _addTaskButton(){
    return FloatingActionButton(
      onPressed: (){},
      child: const Icon(
        Icons.add,
      ),
    );
  }
}