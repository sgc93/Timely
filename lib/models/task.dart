class Task{
  String content;
  DateTime timestamp;
  bool done;

  Task({
    required this.content,
    required this.timestamp,
    required this.done,
  });

  factory Task.fromMap(Map taskList){
    return Task(
      content: taskList['content'],
      timestamp: taskList['timestamp'],
      done: taskList['done'],
    );
  }

  Map toMap(){
    return {
      'content':  content,
      'timestamp': timestamp,
      'done': done,
    };
  }
}