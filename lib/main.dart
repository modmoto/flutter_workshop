import 'package:flutter/material.dart';

void main() {
  runApp(CounterApp());
}

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoPage(),
    );
  }
}

class TodoPage extends StatelessWidget {
  final List<TodoItem> tasks = [
    TodoItem(
      task: "Task 1",
    ),
    TodoItem(
      task: "Task 2",
    ),
    TodoItem(
      task: "Task 3",
      done: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Todo App"),
      ),
      body: Column(
        children: tasks.map((e) => TodoItemWidget(task: e.task, done: e.done)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add)
      ),
    );
  }
}

class TodoItem {
  final bool done;
  final String task;

  TodoItem({this.done = false, this.task});
}

class TodoItemWidget extends StatelessWidget {
  final bool done;
  final String task;

  const TodoItemWidget({Key key, this.done, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var col = Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          if (done)
            Icon(Icons.done),
          Text(task),
          Spacer(),
          Checkbox(value: done, onChanged: (v) {
          }),
        ],
      )
    );

    return col;
  }
}
