import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/shared/cubit_todo/states_todo.dart';
import '../../modules/archived_tasks/archived_tasks_screen.dart';
import '../../modules/done_tasks/done_tasks_screen.dart';
import '../../modules/new_tasks/new_tasks_screen.dart';
class Appcubit extends Cubit<APPstates>
{
  Appcubit() : super(appIntialstate());
  static Appcubit get(context)=> BlocProvider.of(context);
  int currentIndex=0;
  Database database;
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivetasks = [];
  bool isBottomsheetSown = false;
  IconData fabicon = Icons.edit;
  List<Widget> scrrens=[
    NewTasks(),
    DoneTasks(),
    ArchiveTasks(),
  ];
  List<String> tittle =[
    'New tasks',
    'Done tasks',
    'Archive tasks',
  ];
  void changeindex  (index)
  {
    currentIndex=index;
     emit(appchangebottomnavbarstate());

  }
  void creatdatabase()
  {
    openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database , version){
          print('database is create ');
          database.execute('create table tasks (id integer primary key , title text , date text ,time text , status text  )').then((value) {

            print('table created ');

          }).catchError((error){
            print('error : ${error.toString()}');
          });
        },
        onOpen: (database){
          getdatafromDatabase(database);
          print('database is open ');
        }
    ).then((value) {

      database=value;
      emit(AppcreateDatabase());
    });
  }
  Future insertToDatabase (
      {
        @required String titlel,
        @required String time,
        @required String date,
      }
      )async
  {

    return await database.transaction((txn) {
      txn.rawInsert(
          'insert into tasks (title , date , time , status )values("$titlel"," $date ","$time","new")'
      ).then((value) {
        print('$value record created sucessfuly');
        emit(AppInsertDatabase());
        getdatafromDatabase(database);
      }).catchError((error){
        print('error : ${error.toString()}');
      });
    });
  }
  void getdatafromDatabase(database)
  {
    newtasks=[];
    donetasks=[];
    archivetasks=[];


    emit(AppGetLodingDatabase());
    database.rawQuery('select * from tasks').then((value) {
      value.forEach((element) {
        if (element['status']== 'new')
          newtasks.add(element);
          else if (element['status']== 'done')
          donetasks.add(element);
          else
          archivetasks.add(element);


      });
      emit(AppGetDatabase());
    });
  }
  void Updatedata (
  {
  @required String status,
  @required int id ,
}
)
  {
     database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id ]

    ).then((value){

       getdatafromDatabase(database);
    emit(AppUpdateDatabase());

     });

  }
  void Deletedata (
      {

        @required int id ,
      }
      )
  {
    database.rawDelete(
        'DELETE FROM tasks WHERE id = ?', [id]
    ).then((value){
      getdatafromDatabase(database);
      emit(AppDeleteDatabase());

    });

  }
  void changeBottomsheetstate({
  @required bool isShow ,
  @required IconData icon,
})
  {
    isBottomsheetSown=isShow;
    fabicon=icon;
    emit(appchangebottomsheetstate());
  }
}