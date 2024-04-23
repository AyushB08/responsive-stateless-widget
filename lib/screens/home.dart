

import "package:flutter/material.dart";
import "package:flutter_stateless_widget/constants/colors.dart";
import "package:flutter_stateless_widget/model/todo.dart";
import "package:flutter_stateless_widget/widgets/todo_item.dart";
import "package:flutter_stateless_widget/main.dart";
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({super.key});
   

  final ValueNotifier<String> filterText = ValueNotifier<String>("");
  final ValueNotifier<String> searchText = ValueNotifier<String>("");
  final todosList = ToDo.todoList();
  final todoController = TextEditingController();
  List<ToDo> foundToDo = [];
  

  Widget build(BuildContext context) {
    final widgetManager = Provider.of<WidgetManager>(context);
    foundToDo = todosList;
    return  Scaffold( 
      backgroundColor: tdBGColor,
      appBar:  buildAppBar(),
      body: Stack(
        children: [
          Container( 
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child:  Column( 
              children: [
                searchBox(),
                Expanded(
                  child: ListView( 
                    children: [ 
                      Container ( 
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text("To-Do List", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500,))
                      ),
                      ValueListenableBuilder<List<ToDoItem>>(
                        valueListenable: widgetManager.widgets,
                        builder: (context, widgets, child) {
                          return Column(
                            children: widgets,
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align( 
            alignment: Alignment.bottomCenter,
            child: Row( 
              children: [ 
                Expanded( 
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5), 
                    margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    decoration: BoxDecoration( 
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 0.0), blurRadius: 10.0, spreadRadius: 0.0)],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(  
                      controller: todoController,
                     
                      decoration: InputDecoration( 
                        hintText: "Add a New Item",
                        border: InputBorder.none
                      )
                    )
                  ),

                ),
                Container ( 
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton ( 
                    child: Text("+", style: TextStyle(fontSize: 40,),),
                    onPressed: () { 
                      widgetManager.addWidget(todoController.text, handleToDoChange, deleteToDoItem);
                    },
                    style: ElevatedButton.styleFrom( 
                      
                     
                      elevation: 10,
                    ),
                  )
                )
              ]

            )
          )
        ],
      )
    );


  }

  Widget searchBox() {
    return ( 
      Container( 
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration( 
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: TextField( 
       
                decoration: InputDecoration( 
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(
                    Icons.search, 
                    color: tdBlack, 
                    size: 20), 
                    prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
                    border: InputBorder.none,
                    hintText: "Search",
                    hintStyle: TextStyle(color: tdGrey),

                ),
                
              ), 
            )
    );
  }

  void handleToDoChange(ToDo todo) {
    
    todo.isDone = !todo.isDone;
 
    
  }

  void deleteToDoItem(String id) {
    
    todosList.removeWhere((item) => item.id == id);
    
  
  }

  void addToDoItem(String toDo) {
   
    todosList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo));
    

    todoController.clear();
    
  }


  void runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList.where((item) => item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }

    
    foundToDo = results;
  
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor, 
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        const Icon(
          Icons.menu, 
          color:tdBlack, 
          size: 30,
          ),

        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/profile.png'),
          ),
        ),
      ]), 
      
      
    );
  }

  
}
