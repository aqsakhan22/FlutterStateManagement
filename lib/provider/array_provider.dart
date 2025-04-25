import 'package:flutter/material.dart';

class ArrayProvider extends ChangeNotifier{
    List<dynamic> _data=[];
     List<dynamic> get data => _data; 
     bool _isLoading=false;
     bool get isLoading => _isLoading;
     bool _isUpdate=false;
     bool get isUpdate => _isUpdate;
    
    Future<void> addData(String title) async{
             _isLoading=true;
          _data.add(title);
          _isLoading=false;
          notifyListeners();
    }
    Future<void> getData() async{

    }
    Future<void> updateData(int index,String title) async{
      _isUpdate=true;
     _data[index]=title;
  notifyListeners();
    }
      
    Future<void> deleteData(int index) async{
      _data.removeAt(index);
      notifyListeners();
    }
}