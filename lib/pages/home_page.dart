import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timely/models/task.dart';

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
  Box? _box;

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
      future: Hive.openBox('tasks'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          _box = snapshot.data;
          return _taskList();
        } else if( snapshot.hasError ){
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
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
    // add sample task
    // Task newTask = Task(content: "Finish at least One project.", timestamp: DateTime.now(), done: true);
    // _box?.add(newTask.toMap());
    // get stored tasks
    List tasks = _box!.values.toList();
    return Container(
      child: ListView.builder(
        itemCount: tasks.length, // _tasks.length,
        itemBuilder: (BuildContext context, int index) {
          var task = Task.fromMap(tasks[index]);
          return ListTile(
            title: Text(
              task.content,
              style: TextStyle(
                decoration: task.done ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(task.timestamp.toString()),
            trailing: Icon(
              task.done? Icons.check_box_outlined : Icons.check_box_outline_blank_outlined,
              color: Colors.red,
            ),
            onTap: () {
              task.done = !task.done;
              _box?.putAt(index, task.toMap());
              setState(() {});
            },
            onLongPress: () {
              _box?.deleteAt(index);
              setState(() {});
            },
          );
        },
      ),
    );
  }

  Widget _addTaskButton(){
    return FloatingActionButton(
      onPressed: _newTaskPopUp,
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
              onSubmitted: (_value){
                if(_newTask != null){
                  Task _task = Task(
                    content: _value, 
                    timestamp: DateTime.now(), 
                    done: false,
                  );
                  _box?.add(_task.toMap());

                  setState(() {
                    _newTask = null;
                    Navigator.pop(context);
                  });
                }
              },
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
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      });
  }
}