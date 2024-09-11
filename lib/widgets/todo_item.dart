
import 'package:flutter/material.dart';
import '../model/todoModel.dart';


// Definizione del widget TodoItem come StatelessWidget
class TodoItem extends StatelessWidget {
  final ToDo todo;// Oggetto ToDo passato al widget
  final onToDoChanged;// Callback per il cambiamento dello stato del ToDo
  final onDeleteItem;// Callback per l'eliminazione del ToDo

  // Costruttore con parametri obbligatori per il ToDo, la callback di eliminazione e la callback di cambiamento
  const TodoItem({super.key, required this.todo, required this.onDeleteItem, required this.onToDoChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {  // Azione da eseguire al click sull'elemento ToDo
          //print('Clicked on ToDo item');
          onToDoChanged(todo);// Chiamata alla callback per il cambiamento dello stato del ToDo
        },
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Color(0xFF7a7a7a),
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_circle_outline,
          color: Color(0xFF000000),
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: Color(0xFF000000),
              decoration: todo.isDone? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Color(0xFF7a7a7a),
            borderRadius: BorderRadius.circular(5)
          ),
          child: IconButton(
            onPressed: (){
              onDeleteItem(todo.id); // Chiamata alla callback per l'eliminazione del ToDo
            },
            color: Color(0xFF000000),
            iconSize: 25,
            icon: Icon(Icons.delete_forever),

          ),
        ),
      ),
    );
  }
}
