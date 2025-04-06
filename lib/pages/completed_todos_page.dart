import 'package:flutter/material.dart';
import '../models/todo.dart';

class CompletedTodosPage extends StatefulWidget {
  final List<Todo> completedTodos;
  final Function(Todo) onDelete;

  const CompletedTodosPage({
    Key? key,
    required this.completedTodos,
    required this.onDelete,
  }) : super(key: key);

  @override
  _CompletedTodosPageState createState() => _CompletedTodosPageState();
}

class _CompletedTodosPageState extends State<CompletedTodosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas concluídas', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xffa703af),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.completedTodos.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Nenhuma tarefa concluída.',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              else
                ...widget.completedTodos.map(
                      (todo) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                    child: ListTile(
                      title: Text(
                        todo.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      subtitle: Text(todo.description),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          widget.onDelete(todo);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffa703af),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(14),
                ),
                child: const Text(
                  'Voltar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
