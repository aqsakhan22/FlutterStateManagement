
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoprovider/models/Todo.dart';
import 'package:todoprovider/response/api_service.dart';
class TodoProvider extends ChangeNotifier{
 
  List<Todo> _todos=[];
  bool _isLoading=false;
  List<Todo> get todo => _todos;
  bool get isLoading => _isLoading;
  final ApiService _apiService=ApiService();

  Future<void> fetchTodos() async{
       _isLoading=true;
       notifyListeners();
       try{
        _todos= await _apiService.getTodos();

       }
       catch(e){
        print(e);
       }
       finally{
        _isLoading=false;
        notifyListeners();
       }

  }

  Future<void> addTodo(String title) async{
       
       try{
        final newTodo= await _apiService.createTodo(title);
        _todos.add(newTodo);
        notifyListeners();
       }
       catch(e){
        print(e);
       }
       finally{
        _isLoading=false;
        notifyListeners();
       }

  }

  Future <void> updateTodo(Todo todo) async{
    try{

   final updatedTodo= await _apiService.updateTodo(todo);
    final index= _todos.indexWhere((t) => t.id == updatedTodo.id);
    _todos[index]=updatedTodo;
    print("updated todo is ${_todos}");
    notifyListeners();
    
    }
    catch(e){
print(e);
    }

  }

  Future<void> deleteTodo(int id) async{

    try{ 
      await _apiService.deleteTodo(id);
      _todos.removeWhere((todo) => todo.id == id);
      notifyListeners();

    }
    catch(e){
      print(e);

    }

  }

}