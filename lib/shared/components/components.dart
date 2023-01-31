import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/shared/cubit_todo/cubit_todo.dart';
Widget defoult_buton({
   Color col=Colors.blue,
   double width=double.infinity ,
  @required Function function,
  @required String text})=> Container(
  width: width,
  child: MaterialButton(
    onPressed:function(),
      child: Text(text.toUpperCase(),style: TextStyle(
          color: Colors.white
      ),)),
  decoration: BoxDecoration(
      color:col ,
      borderRadius: BorderRadius.circular(20)
  ),
);
Widget defoult_formfiled ({
  @required TextInputType inputtype ,
  @required TextEditingController emailcontroller,
  @required String email_addres ,
   @required IconData iconprifix ,
  @required Function validator ,
   Function onchanged ,
   Function onsubitted ,
  Function ontap  ,
   IconData iconsuff,
  bool obscureText =false ,
   Function suffpressed ,
})=>TextFormField(
  onChanged: onchanged ,
  validator: validator,
  keyboardType: inputtype,
  controller:emailcontroller,
  onFieldSubmitted: onsubitted,
  decoration:
  InputDecoration(

      border: OutlineInputBorder(),
      prefixIcon: Icon(iconprifix),
      suffix: IconButton(
          onPressed:suffpressed ,
          icon: Icon(iconsuff)),
      labelText: email_addres,
  ),
  obscureText: obscureText,
onTap: ontap ,
);
Widget bildtaskitem(Map model,context)=>
    Dismissible(
      key: Key(model['id'].toString()) ,
      onDismissed:(direction){
        Appcubit.get(context).Deletedata(id: model['id']);
      } ,
      child: Padding(
  padding: const EdgeInsets.all(10),
  child:
  Container(
    decoration: BoxDecoration(
        color: Colors.purple[300],
      borderRadius: BorderRadius.horizontal(left: Radius.circular(35))

    ),

    width: 20,
    child: Row(
      mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor:Colors.indigo[300] ,
            foregroundColor: Colors.black,
            radius: 35,
            child: Text(' ${model['time']}'),
          ),
          SizedBox(
            width: 20,

          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(' ${model['title']}',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  color: Colors.black,

                ),),
                Text(' ${model['date']}',style: TextStyle(

                  fontSize: 16,
                  color: Colors.white70,
                ),)


              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  child: IconButton(

                    color: Colors.green,
                    onPressed: (){

                      Appcubit.get(context).Updatedata(
                          status: 'done',
                          id: model['id']);
                    },
                    icon: Icon(Icons.check_box),
                  ),
                  width: 33,
                ),
                Container(
                  width: 33,
                  child: IconButton(

                    color: Colors.lightBlue,
                    onPressed: (){
                      Appcubit.get(context).Updatedata(
                          status: 'archive',
                          id: model['id']);

                    },
                    icon: Icon(Icons.archive_outlined),

                  ),
                ),
                Container(
                  width: 33,
                  child: IconButton(

                    color: Colors.grey,
                    onPressed: (){
                      Appcubit.get(context).Deletedata(id: model['id']);

                    },
                    icon: Icon(Icons.delete_forever),

                  ),
                ),

              ],
            ),
          )

        ],

    ),
  ),
),
    );
Widget tasksbilder ({
@required List<Map> tasks,

})=> ConditionalBuilder(
  condition: tasks.length>0,
  builder:(context)=>  ListView.separated(
    itemBuilder: ( context, index)=>bildtaskitem(tasks[index],context),
    separatorBuilder:( context, index)=>
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            width: double.infinity,
            height: 0.1,
          ),
        ) ,
    itemCount: tasks.length,
  ),
  fallback: (context)=>Center(
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.library_add,

            color: Colors.purple[400],
            size: 100,
          ),
          SizedBox(
            height: 20,
          ),
          Text('No tasks yet , please Add some tasks ',style: TextStyle(
            color: Colors.purple[400],
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),)
        ],
      ),
    ),
  ),
);