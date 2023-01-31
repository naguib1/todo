
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/cubit_todo/cubit_todo.dart';
import 'package:untitled/shared/cubit_todo/states_todo.dart';
class HomeLyout extends StatelessWidget {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  var titlecontrol = TextEditingController();
  var timecontrol = TextEditingController();
  var datecontrol = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(
        create: (BuildContext context) => Appcubit()..creatdatabase(),
        child:
        BlocConsumer<Appcubit, APPstates>(
          listener: (BuildContext context, state) {
            if (state is AppInsertDatabase)
              {
                Navigator.pop(context);
              }

          },
          builder: (BuildContext context, state)
             {
               Appcubit cubit= Appcubit.get(context);
               return Scaffold(
                key: scaffoldkey,
                appBar: AppBar(
                  backgroundColor: Colors.purple[400],
                  title: Text(
                    '${
                        cubit
                        .tittle[cubit
                        .currentIndex]}',
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.purple[400],
                  onPressed: () async
                  {
                    if (cubit.isBottomsheetSown) {
                      if (formkey.currentState.validate()) {
                        cubit.insertToDatabase(
                            titlel: titlecontrol.text,
                            time: timecontrol.text,
                            date: datecontrol.text,
                        );
                      }
                    }
                    else {
                      scaffoldkey.currentState
                          .showBottomSheet(
                            (context) =>
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Form(
                                key: formkey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 70,
                                      child: defoult_formfiled(
                                        inputtype: TextInputType.text,
                                        emailcontroller: titlecontrol,
                                        email_addres: "task title ",
                                        iconprifix: Icons.title,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'title must not be empty ';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      height: 70,
                                      child: defoult_formfiled(
                                        ontap: () {
                                          showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                              .then((value) {
                                            timecontrol.text =
                                                value.format(context);
                                            print(value.format(context)
                                                .toString());
                                          });
                                        },
                                        inputtype: TextInputType.datetime,
                                        emailcontroller: timecontrol,
                                        email_addres: "task time ",
                                        iconprifix: Icons.watch_later_outlined,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'time must not be empty ';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      height: 70,
                                      child: defoult_formfiled(
                                        ontap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.parse(
                                                '2023-05-03'),

                                          ).then((value) {
                                            datecontrol.text =
                                                DateFormat.yMMMd().format(
                                                    value);
                                          });
                                        },
                                        inputtype: TextInputType.datetime,
                                        emailcontroller: datecontrol,
                                        email_addres: "task date ",
                                        iconprifix: Icons.calendar_month,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'date must not be empty ';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextButton(
                                        onPressed: (){

                                          if (cubit.isBottomsheetSown) {
                                            if (formkey.currentState.validate()) {
                                              cubit.insertToDatabase(
                                                titlel: titlecontrol.text,
                                                time: timecontrol.text,
                                                date: datecontrol.text,
                                              );
                                            }
                                          }
                                        },
                                        child:
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: Colors.purple[400],
                                          ),
                                          width: 100,
                                          height: 45,
                                          child:
                                          Center(child: Text('add new task',style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,

                                          ),)),

                                        )

                                    )


                                  ],),
                              ),
                            ),
                        elevation: 30.0,

                        backgroundColor: Colors.white

                      )
                          .closed
                          .then((value) {

                            cubit.changeBottomsheetstate(isShow: false, icon:Icons.edit );
                      });
                      cubit.changeBottomsheetstate(isShow: true, icon:Icons.add );
                    }
                  },
                  child: Icon(
                      cubit.fabicon

                  ),
                ),
                body: ConditionalBuilder(
                  condition: state is! AppGetLodingDatabase,
                  builder: (context) =>
                 cubit
                      .scrrens[cubit
                      .currentIndex],
                  fallback: (context) =>
                      Center(child: CircularProgressIndicator()),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  elevation: 500,
                  fixedColor: Colors.white,
                  backgroundColor: Colors.purple[500],
                  type: BottomNavigationBarType.fixed,
                  currentIndex:

                      cubit.currentIndex,
                  onTap: (index) {
                    cubit.changeindex(index);
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.list),
                        label: "tasks",
                      backgroundColor: Colors.blueAccent
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.check_circle_outlined),
                        label: "Done",
                        backgroundColor: Colors.blueAccent
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.archive_outlined),
                        label: "Archived",
                        backgroundColor: Colors.blueAccent
                    ),

                  ],
                ),
              );}
        ),
      );
  }
}
