import 'package:flutter/material.dart';
import '../models/todo.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;
  final Function(String, String) onSave;

  const EditTodoPage({
    super.key,
    required this.todo,
    required this.onSave,
  });

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todo.title);
    descriptionController = TextEditingController(text: widget.todo.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void handleSave() {
    final updatedTitle = titleController.text;
    final updatedDescription = descriptionController.text;

    if (updatedTitle.isNotEmpty) {
      widget.onSave(updatedTitle, updatedDescription);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Tarefa', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xffa703af),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: handleSave,
              icon: Icon(Icons.save, color: Colors.white,),
              label: Text('Salvar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffa703af),
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
