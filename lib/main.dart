import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
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

class TodoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoPageState();
}

class TodoPageState extends State<TodoPage> {
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
        children: tasks.asMap().entries.map((e) => TodoItemWidget(
          task: e.value,
          onSelect: (bool newVal) {
            var index = e.key;
            var task = e.value;

            setState(() {
              tasks.replaceRange(index, index + 1, [TodoItem(
                done: newVal,
                task: task.task
              )]);
            });
        },
          onDelete: () {
            setState(() {
              tasks.remove(e.value);
            });
          })).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newTask = await showTaskCreationDialog(context);

          if (newTask != null) {
            setState(() {
              tasks.add(newTask);
            });
          }
        },
        child: Icon(Icons.add)
      ),
    );
  }

  Future showTaskCreationDialog(BuildContext context) {
    var textController = TextEditingController();

    return showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text("Enter your Todo"),
            content: TextField(
              controller: textController,
            ),
            actions: [
              OutlineButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
              RaisedButton(
                child: Text("Create"),
                onPressed: () async {
                  Navigator.of(context).pop(TodoItem(
                      task: textController.text
                  ));
                })
            ],
          );
        });
  }
}

class TodoItem {
  final bool done;
  final String task;

  TodoItem({this.done = false, this.task});
}

class TodoItemWidget extends StatelessWidget {
  final TodoItem task;
  final ValueChanged<bool> onSelect;
  final Function onDelete;

  const TodoItemWidget({Key key, this.task, this.onSelect, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var col = Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          if (task.done)
            Icon(Icons.done),
          Text(task.task),
          Spacer(),
          Checkbox(value: task.done, onChanged: onSelect),
          IconButton(icon: Icon(Icons.delete), onPressed: onDelete),
        ],
      )
    );

    return col;
  }
}
