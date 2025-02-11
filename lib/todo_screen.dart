import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _todoController = TextEditingController();

  @override
  @override
  void initState() {
    super.initState();
    Provider.of<TodoProvider>(context, listen: false).loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks to Do"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Add Todo"),
                  content: TextField(
                    controller: _todoController,
                    decoration:
                        InputDecoration(hintText: "Enter your todo item"),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel")),
                    TextButton(
                        onPressed: () {
                          provider.addTodo(_todoController.text);

                          Navigator.pop(context);
                          _todoController.clear();
                          print("this");
                        },
                        child: Text("Add todo")),
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, provider, index) {
          return provider.items.isEmpty
              ? Center(child: Text("No Todos Available"))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: IconButton(
                            onPressed: () {
                              _todoController.text = provider.items[index];
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Edit Todo"),
                                      content: TextField(
                                        controller: _todoController,
                                        decoration: InputDecoration(),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Cancel")),
                                        TextButton(
                                            onPressed: () {
                                              provider.editTodo(
                                                  index, _todoController.text);
                                              _todoController.clear();
                                              Navigator.pop(context);
                                            },
                                            child: Text("Edit Todo")),
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(Icons.edit),
                          ),
                          title: Text(
                            provider.items[index],
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                provider.removeTodos(index);
                              },
                              icon: Icon(Icons.delete)),
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
