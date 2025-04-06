import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/pages/view_todo_page.dart';
import '../widgets/todo_list_item.dart';
import 'package:todo_list/pages/edit_todo_page.dart';
import 'package:todo_list/pages/completed_todos_page.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<Todo> todos = [];
  List<Todo> completedTodos = [];
  Todo? deletedTodo;
  int? deletedTodoPos;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lista de Tarefas', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          backgroundColor: Color(0xffa703af),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Título da tarefa',
                    hintText: 'Ex. Estudar Flutter',
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Descrição',
                    hintText: 'Ex. Ver aula 3 sobre widgets',
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    String title = titleController.text;
                    String description = descriptionController.text;

                    if (title.isEmpty) return;

                    setState(() {
                      Todo newTodo = Todo(
                        title: title,
                        description: description,
                        dateTime: DateTime.now(),
                      );
                      todos.add(newTodo);
                    });
                    titleController.clear();
                    descriptionController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Color(0xffa703af),
                    padding: EdgeInsets.all(14),
                  ),
                  child: Icon(Icons.add, size: 30, color: Colors.white),
                ),
                SizedBox(height: 16),
                Flexible(
                  child: SlidableAutoCloseBehavior(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (int i = 0; i < todos.length; i++)
                          TodoListItem(
                            todo: todos[i],
                            onDelete: () {
                              deletedTodo = todos[i];
                              deletedTodoPos = i;
                              setState(() {
                                todos.removeAt(i);
                              });
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Tarefa "${deletedTodo!.title}" foi removida com sucesso!',
                                    style: TextStyle(color: Color(0xff060708)),
                                  ),
                                  backgroundColor: Colors.white,
                                  action: SnackBarAction(
                                    label: 'Desfazer',
                                    textColor: const Color(0xffa703af),
                                    onPressed: () {
                                      setState(() {
                                        todos.insert(
                                          deletedTodoPos!,
                                          deletedTodo!,
                                        );
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                            onEdit: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EditTodoPage(
                                    todo: todos[i],
                                    onSave: (updatedTitle, updatedDescription) {
                                      setState(() {
                                        todos[i].title = updatedTitle;
                                        todos[i].description = updatedDescription;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                            onCheck: (checked) {
                              if (checked == true) {
                                setState(() {
                                  completedTodos.add(todos[i]);
                                  todos.removeAt(i);
                                });
                              }
                            },
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ViewTodoPage(todo: todos[i]),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Você possui ${todos.length} tarefas pendentes',
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: showDeleteTodosConfirmationDialog,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Color(0xffa703af),
                        padding: EdgeInsets.all(15),
                      ),
                      child: Text(
                        'Limpar tudo',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CompletedTodosPage(
                          completedTodos: completedTodos,
                          onDelete: (todo) {
                            setState(() {
                              completedTodos.remove(todo);
                            });
                          },
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.all(15),
                  ),
                  child: Text(
                    'Ver concluídas',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDeleteTodosConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Limpar tudo?'),
        content: Text('Você tem certeza que deseja apagar todas as tarefas?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(foregroundColor: Color(0xffa703af)),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteAllTodos();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('Limpar tudo'),
          ),
        ],
      ),
    );
  }

  void deleteAllTodos() {
    setState(() {
      todos.clear();
    });
  }
}
