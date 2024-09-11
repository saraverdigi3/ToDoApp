import 'package:flutter/cupertino.dart';
import 'package:to_do_app/model/todoModel.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/widgets/todo_item.dart';

// Definizione del widget Home come StatefulWidget
class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();// Creazione dello stato del widget Home
}

// Definizione della classe _HomeState che gestisce lo stato del widget Home
class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();// Lista iniziale dei ToDo
  final _todoController = TextEditingController();// Controller per il campo di testo
  List<ToDo> _foundToDo = [];// Lista dei ToDo trovati (per la ricerca)


  @override
  void initState() {
    // Metodo chiamato all'inizializzazione del widget
    _foundToDo = todosList;// Inizializzazione della lista dei ToDo trovati con tutti i ToDo
    super.initState();// Chiamata al metodo initState della superclasse
  }

  @override
  Widget build(BuildContext context) { // Metodo build per costruire l'interfaccia utente
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
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
                          'Things To Do',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Color(0xFF7a7a7a)),
                        ),
                      ),
                      for (ToDo todoo in _foundToDo.reversed)// Ciclo per ogni ToDo trovato (in ordine inverso)
                        TodoItem(
                          todo: todoo,// Passaggio del ToDo al widget TodoItem
                          onToDoChanged: _handleToDoChange,// Callback per il cambiamento dello stato del ToDo
                          onDeleteItem: _deleteToDoItem,// Callback per l'eliminazione del ToDo
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

  // Gestione del cambiamento dello stato del ToDo
  //si utilizza setState() per notificare il cambio di stato dell'oggetto
  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone; //se isDone e' true diventa false
    });
  }

  // Eliminazione di un ToDo in base all'id
  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  // Aggiunta di un nuovo ToDo
  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
          id: DateTime  // Generazione di un id unico grazie al timestamp (in microsecondi) che garantisce l'unicita' dell'id
              .now()
              .microsecondsSinceEpoch
              .toString(),
          todoText: toDo));
    });
    _todoController.clear();//resetta il contenuto del controller
  }

  // Filtraggio dei ToDo in base a una parola chiave
  void _runFilter(String enteredKeyword) {
    List<ToDo> results = []; //inizializzo nuova lista vuota di tipo ToDo
    if (enteredKeyword.isEmpty) { //se la parola chiave è vuota viene impostata uguale a todosList e non si usano filtri
      results = todosList;
    } else { //altrimenti viene filtrata la lista e La condizione verifica se todoText dell'elemento ToDo contiene la parola chiave
      results = todosList
          .where((item) =>
          item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();//converto i risultati in una lista e li assegno a results
    }
    setState(() {//imposto _foundToDo con i risultati del filtro (results), e aggiorno la lista filtrata visualizzata nella UI.
      _foundToDo = results;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF111111),
      elevation: 0,
    iconTheme: IconThemeData(
    size: 40, // Imposta la dimensione dell'icona
    color: Color(0xFF7a7a7a)), // Imposta il colore desiderato
      title: Row(
        children: [
          SizedBox(width: 150, ), // Spazio tra l'icona del menu e la search bar
          SizedBox(
            width: 150,
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
                    color: Color(0xFF3A3A3A),
                    size: 20,
                  ),
                  prefixIconConstraints: BoxConstraints(
                      maxHeight: 20, minWidth: 25),
                  border: InputBorder.none,

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
