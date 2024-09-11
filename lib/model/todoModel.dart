// Definizione della classe ToDo che rappresenta un singolo elemento della lista di attività
class ToDo{
  String? id;
  String? todoText;
  bool isDone;

  // Costruttore della classe ToDo
  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false
});

// Metodo statico per creare una lista predefinita di attività
  static List<ToDo> todoList(){
    return[
      ToDo(id: '01', todoText: 'Morning Excercise', isDone: true),
      ToDo(id: '02', todoText: 'Buy Groceries', isDone: true),
      ToDo(id: '03', todoText: 'Check Emails'),
      ToDo(id: '04', todoText: 'Team Meeting'),
      ToDo(id: '05', todoText: 'Dinner with Jenny'),
    ];
  }
}