import 'package:flutter/material.dart';
import '../models/todo.dart';

class ViewTodoPage extends StatelessWidget {
  final Todo todo;

  const ViewTodoPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Tarefa', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xffa703af),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                todo.title,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                todo.description,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffa703af),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(14),
                ),
                child: Text(
                  'Voltar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
