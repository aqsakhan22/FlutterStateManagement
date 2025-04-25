import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todoprovider/models/Todo.dart';
class ApiService{
 static const String todo_api="https://jsonplaceholder.typicode.com/todos";


 Future<List<Todo>> getTodos() async{
   final response = await http.get(Uri.parse(todo_api));
   if(response.statusCode == 200){
     List<dynamic> data=jsonDecode(response.body);
     return data.map((json) => Todo.fromJson(json)).toList();
   }
   else{
    throw Exception( 'Failes to load todos');
   }

 } 

Future<Todo> createTodo(String title) async{
 final response = await http.post(Uri.parse(todo_api),
  body:jsonEncode(
    {
      'title':title,
       'completed':false
    }
  ),
  headers: {'Content-Type': 'application/json'},
     
 );
 print("todo created ${response.body}");
 if(response.statusCode == 201){
  // response body is string so we have to decode first
  return Todo.fromJson(jsonDecode(response.body));
 }
 else{
  throw Exception('Failed to create Todo');
 }

}


Future<Todo> updateTodo (Todo newtodo) async{
 print("update Todo in apiservice is ${newtodo.toJson()}");
 final response = await http.put(
  Uri.parse('${todo_api}/${newtodo.id}'),
 body:jsonEncode(newtodo.toJson()),
 headers: {'Content-Type': 'application/json'},
 
 );
 print("updated status code is ${response.body}");
  if(response.statusCode == 200){
    return Todo.fromJson(jsonDecode(response.body)) ;
  }
  else{
    throw Exception("NO UPDATED");
  }

}

Future<void> deleteTodo(int id) async{
final response = await http.delete(
  Uri.parse('${todo_api}/${id}'));
   if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }

}
}