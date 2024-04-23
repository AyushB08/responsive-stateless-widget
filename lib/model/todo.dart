class ToDo {
  String? id;
  String? todoText;
  bool isDone;


  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: "1", todoText: "Buy Groceries", isDone: true),
      ToDo(id: "2", todoText: "Finish APCS", ),
      ToDo(id: "3", todoText: "Walk Dog", isDone: true),
      ToDo(id: "4", todoText: "Eat Dinner", isDone: true),
      ToDo(id: "5", todoText: "Call Boss", ),

    ];
  }

}