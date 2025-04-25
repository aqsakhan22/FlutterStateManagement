import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoprovider/provider/array_provider.dart';

class ArrayPractice extends StatelessWidget {
  const ArrayPractice({super.key});

  @override
  Widget build(BuildContext context) {
    final array_provider=Provider.of<ArrayProvider>(context);
    
    return Scaffold(

      floatingActionButton: FloatingActionButton(onPressed: (){
        showDialog(
          context: context,
         builder: (context){
          String todo="";

          return AlertDialog(
            contentPadding: EdgeInsets.all(0.0),
            titlePadding: EdgeInsets.all(0.0),
           title: Container(
            alignment: Alignment.center,
              color: Colors.blue[300],
              child:Text("ADD DATA",style: TextStyle(color: Colors.white),),
            ) ,
           content: Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10.0),
           
           child: TextField(
             onChanged: (value){
             todo=value;

             },
           ),
           ),
            actions: [

              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Cancel")),
              TextButton(onPressed: (){
                array_provider.addData(todo);
                Navigator.pop(context);
              
              }, child: Text("Add"))
            ],
          );
         });
        
      },child: Icon(Icons.add),),
      appBar: AppBar(title: Text("Task Diary",
      style: TextStyle(color:Colors.white,),),backgroundColor: Colors.blue[300],),
      body: 
       array_provider.isLoading == true
       ?
      Center(child:CircularProgressIndicator())
      : 
      
      ListView.builder(
        itemCount: array_provider.data.length,
        itemBuilder: (context,int index){

        return Padding(
          
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: ListTile(
           
          tileColor: Colors.blue[300] ,
          leading: Text("${array_provider.data[index]}",
          style: TextStyle(color:Colors.white),),
             
          trailing: 
         Row(children: [
          IconButton(onPressed: (){
            array_provider.deleteData(index);
          }, icon: Icon(Icons.delete)),


          IconButton(onPressed: (){
            array_provider.updateData(index,"updated Data");
          }, icon: Icon(Icons.edit))
         ],)
          
          )
        );
      })

      
    );
  }
}