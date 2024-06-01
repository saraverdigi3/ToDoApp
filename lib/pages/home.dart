import 'package:flutter/cupertino.dart';
import 'package:to_do_app/model/todoModel.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo = [];

  @override
  void initState() {
    // TODO: implement initState
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      appBar: _buildAppBar(),
      drawer: _buildDrawer(), // Aggiungi il Drawer qui
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                //searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          'All ToDo',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Color(0xFF7a7a7a)),
                        ),
                      ),
                      for (ToDo todoo in _foundToDo.reversed)
                        TodoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
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
                    margin:
                    const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Color(0xFF7a7a7a),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),

                          //blurRadius: 10,
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                          hintText: 'Add a new todo item',
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 40, color: Color(0xFF7a7a7a)),
                    ),
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF343434),
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
          id: DateTime
              .now()
              .microsecondsSinceEpoch
              .toString(),
          todoText: toDo));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) =>
          item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF111111),
      elevation: 0,
      title: Row(
        children: [
          SizedBox(width: 80), // Spazio tra l'icona del menu e la search bar
          SizedBox(
            width: 200,
            height: 40,

            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Color(0xFF7a7a7a),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: tdBlack,
                    size: 20,
                  ),
                  prefixIconConstraints: BoxConstraints(
                      maxHeight: 20, minWidth: 25),
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.black87, fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF111111),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Color(0xFF7a7a7a),
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // Aggiungi qui la navigazione alle impostazioni
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              // Aggiungi qui la logica di logout
            },
          ),
        ],
      ),
    );
  }
}
