import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'One Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<String> todos = [];

  TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'One Todo',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green, // Set app bar background color to blue
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              maxLines: null,
              controller: todoController,
              decoration: InputDecoration(
                hintText: 'Enter a todo',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                String todoText = todoController.text.trim();
                if (todoText.isNotEmpty) {
                  setState(() {
                    todos.add(
                      todoText,
                    );
                    todoController.clear();
                  });
                } else {
                  // Show alert if todo input is empty
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Alert'),
                        content: Text('Please fill in a todo.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          todos.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(
                            todos[index],
                            style: TextStyle(color: Colors.black),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                color: Colors.grey,
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  _editTodo(index);
                                },
                              ),
                              IconButton(
                                color: Colors.red,
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _deleteTodo(index);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void _editTodo(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String editedTodo = todos[index];
        return AlertDialog(
          title: Text('Edit Todo'),
          content: TextField(
            maxLines: 4,
            onChanged: (value) {
              editedTodo = value;
            },
            controller: TextEditingController(text: todos[index]),
            decoration: InputDecoration(hintText: "Enter new todo"),
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    backgroundColor: Colors.white,
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        todos[index] = editedTodo;
                      });
                      Navigator.of(context).pop();
                    },
                    backgroundColor: Colors.green,
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _deleteTodo(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Todo'),
          content: Text('Are you sure you want to delete this todo?'),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    backgroundColor: Colors.green,
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        todos.removeAt(index);
                      });
                      Navigator.of(context).pop();
                    },
                    backgroundColor: Colors.red,
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

