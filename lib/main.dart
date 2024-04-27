import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package
import "package:flutter_stateless_widget/screens/home.dart";
import "package:flutter_stateless_widget/widgets/todo_item.dart";
import "package:flutter_stateless_widget/model/todo.dart";

void main() {
  runApp(const MyApp());

}

class WidgetManager extends ChangeNotifier {
  final list = ToDo.todoList();
  List<ToDoItem> totalWidgets = [];
  WidgetManager() : super() {
    for (ToDo toDo in list) {
      totalWidgets.add(ToDoItem( 
          todo: (ToDo(id: toDo.id, todoText: toDo.todoText)),
          onToDoChanged: changeWidget,
          onDeleteItem: deleteWidget,
      ));
    }
    widgets.value = totalWidgets;
    widgets.notifyListeners();
  }
  ValueNotifier<List<ToDoItem>> widgets = ValueNotifier<List<ToDoItem>>([]);

  

  void addWidget(toDo, handleChange, deleteItem) {
    totalWidgets.insert(0, ToDoItem( 
          todo: (ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo)),
          onToDoChanged: handleChange,
          onDeleteItem: deleteItem,
    ));
    widgets.value = totalWidgets;
    filterWidgets("");
    widgets.notifyListeners();
    
  }

  void changeWidget(id) {
    int index = widgets.value.indexWhere((item) => item.todo.id == id);
    var currentItem = widgets.value[index];
    var newItem = ToDoItem(
    todo: ToDo(
      id: currentItem.todo.id,
      todoText: currentItem.todo.todoText, // Replace this with the new text
      isDone: !currentItem.todo.isDone,
    ),
    onToDoChanged: changeWidget,
    onDeleteItem: deleteWidget,
    );
    widgets.value[index] = newItem;

    index = totalWidgets.indexWhere((item) => item.todo.id == id);
    currentItem = totalWidgets[index];
    
  
    totalWidgets[index] = newItem;
    

 
    widgets.notifyListeners();
  }

  void filterWidgets(String enteredKeyword) {
    
    List<ToDoItem> results = [];
    if (enteredKeyword.isEmpty) {
      widgets.value = totalWidgets;
    } else {
      results = totalWidgets.where((item) => item.todo.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
      widgets.value = results;
    }
    
    widgets.notifyListeners();
  }

   void deleteWidget(String id) {
    
    widgets.value.removeWhere((item) => item.todo.id == id);
    widgets.notifyListeners();

    totalWidgets.removeWhere((item) => item.todo.id == id);
    widgets.notifyListeners();
  
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  

  @override
  Widget build(BuildContext context) { 
  
    return MaterialApp( 
      
      debugShowCheckedModeBanner: false,
      
      title: "To-Do App",
      home: ChangeNotifierProvider(
        create: (context) => WidgetManager(), // Provide WidgetManager instance
        child: Home(),
      ),

    );
  }
}