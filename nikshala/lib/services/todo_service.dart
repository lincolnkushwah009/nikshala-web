import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikshala/config/config.dart';
import 'package:nikshala/providers/todo_provider/todo_provider.dart';
import 'package:nikshala/screens/components/dialogs.dart';
import 'package:provider/provider.dart';

class TodoServices {
  //add todo notes function
  Future<void> addTodoNotes(
      BuildContext context, String noteId, String notes) async {
    try {
      await Provider.of<TodoProvider>(context, listen: false)
          .addTodoNotes(context, noteId, notes);
    } catch (e) {
      await Dialogs.alert(context, AppConfig.errorColor, e.toString());
    }
  }
}
