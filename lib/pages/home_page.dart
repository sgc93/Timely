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
  String? _newTask;

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
      body: _displayTask(),
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _displayTask(){
    return FutureBuilder(
      future: _fetchImageData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if( snapshot.hasError ){
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          return _taskList();
        }
      },
    );
  }

  Future<String> _fetchImageData() {
    return Future.delayed( const Duration(seconds: 3), (){
        return 'The image is take on 24th, july';
      });
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
      onPressed: _displayTask,
      child: const Icon(
        Icons.add,
      ),
    );
  }

  void _newTaskPopUp(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text('add new task'),
          content: Card(
            child: TextField(
              onSubmitted: (_value){},
              onChanged: (_value){
                setState((){
                  _newTask = _value;
                });
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: (){
                print('New task is added: $_newTask');
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      });
  }
}