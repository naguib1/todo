
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/shared/cubit_todo/cubit_todo.dart';
import 'package:untitled/shared/cubit_todo/states_todo.dart';
import '../../shared/components/components.dart';
class  ArchiveTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit,APPstates>(
      listener:(context, state){} ,
      builder: (context, state){
        var tasks= Appcubit.get(context).archivetasks;
        return
          tasksbilder(
              tasks: tasks
          );
      },
    );
  }
}