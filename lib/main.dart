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
    
    print("soooooo");
    var item = widgets.value.firstWhere(
      (item) => item.todo.id == id
     // Return null if no item with matching id is found
    );
    item.todo.isDone = !item.todo.isDone;
 
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