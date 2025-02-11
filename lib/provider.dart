import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoProvider with ChangeNotifier {
  List<String> _items = [];

  List<String> get items => _items;

  void loadTodos() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _items = sp.getStringList('todos') ?? [];

    notifyListeners();
  }

  void addTodo(String toDo) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    items.add(toDo);
    sp.setStringList('todos', items);
    notifyListeners();
  }

  void removeTodos(int index) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    items.removeAt(index);
    sp.setStringList('todos', items);
    notifyListeners();
  }

  void editTodo(int index, String newToDo) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    items[index] = newToDo;
    sp.setStringList('todos', items);
    notifyListeners();
  }
}
