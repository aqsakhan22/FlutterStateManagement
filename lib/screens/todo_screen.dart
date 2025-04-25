import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoprovider/models/Todo.dart';
import 'package:todoprovider/provider/todo_provider.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProvider=Provider.of<TodoProvider>(context);

    return
     Scaffold(
 
     floatingActionButton: FloatingActionButton(

       child:Icon(Icons.add)  ,      
      onPressed: (){
      showDialog(context: context,
      
       builder: (context){
        String todo="";
        return AlertDialog(
           title: Text("Add Todo"),
           content: TextField(
            onChanged: (value){
              todo=value;

    },
            
           ),
           actions: [
             TextButton(onPressed: (){
              Navigator.pop(context);
             }, 
             child: Text("Cancel")),

            TextButton(onPressed: (){
              todoProvider.addTodo(todo);
              Navigator.pop(context);
            }, child: Text("Add Todo"))
           ],
        );
       }
       
       );

     }),
      appBar: AppBar(title: Text("Todo App"),),
      body: todoProvider.isLoading == true ?
      Center(child: CircularProgressIndicator(),)
       :
       ListView.builder(
        itemCount: todoProvider.todo.length,
        itemBuilder: (context,int index){
          final todo=todoProvider.todo[index];
         return ListTile(
           subtitle: InkWell(
            onTap: (){
              todoProvider.deleteTodo(todo.id);
            },
            child: Icon(Icons.delete),
           ) ,
leading: Text("${todo.title}"),

trailing: Checkbox(value: todo.completed,
 onChanged: (bool? value){
  //print("updated on change TODO is ${todo.toJson()}");
   todoProvider.updateTodo(
    Todo(
      id: todo.id,
      title: todo.title,
      completed: value ?? false
    )
   );
 }),
         );
       })
     );
  }
}