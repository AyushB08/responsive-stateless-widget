import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package
import "package:flutter_stateless_widget/screens/home.dart";
import "package:flutter_stateless_widget/widgets/todo_item.dart";
import "package:flutter_stateless_widget/model/todo.dart";

void main() {
  runApp(const MyApp());

}

class WidgetManager extends ChangeNotifier {
  ValueNotifier<List<ToDoItem>> widgets = ValueNotifier<List<ToDoItem>>([]);


  void addWidget(toDo, handleChange, deleteItem) {
    widgets.value.add( 
      ToDoItem(
                          todo: (ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo)),
                          onToDoChanged: handleChange,
                          onDeleteItem: deleteItem,
                        ),
    );
    widgets.notifyListeners(); // Notify listeners of state change
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