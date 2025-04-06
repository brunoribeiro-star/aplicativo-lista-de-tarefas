import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/todo.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onTap;
  final void Function(bool?) onCheck;

  const TodoListItem({
    super.key,
    required this.todo,
    required this.onDelete,
    required this.onEdit,
    required this.onTap,
    required this.onCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(todo.title + todo.dateTime.toString()),
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onEdit(),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Editar',
            borderRadius: BorderRadius.circular(8),
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Excluir',
            borderRadius: BorderRadius.circular(8),
          ),
        ],
      ),
      child: ListTile(
        leading: Checkbox(
          value: todo.isDone,
          onChanged: onCheck,
        ),
        title: Text(todo.title),
        subtitle: Text(todo.description),
        onTap: onTap,
      ),
    );
  }
}
