import '../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';
import '../model/todoModel.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  const TodoItem({super.key, required this.todo, required this.onDeleteItem, required this.onToDoChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          //print('Clicked on ToDo item');
          onToDoChanged(todo);
        },
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Color(0xFF464646),
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
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
            color: Color(0xFF464646),
            borderRadius: BorderRadius.circular(5)
          ),
          child: IconButton(
            onPressed: (){
              onDeleteItem(todo.id);
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
