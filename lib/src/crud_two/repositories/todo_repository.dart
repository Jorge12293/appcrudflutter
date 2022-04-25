

import 'dart:convert';

import 'package:appcrudflutter/src/crud_two/models/todo.dart';
import 'package:appcrudflutter/src/crud_two/repositories/repository.dart';
import 'package:http/http.dart' as http;

class TodoRepository implements Repository{

  String dataUrl = 'https://jsonplaceholder.typicode.com';


  @override
  Future<String> deleteTodo(Todo todo) async{
    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    var result = 'false';
    
    await http.delete(url)
      .then((value){
      print(value.body); 
      return result = 'true';
    });
  
    return result;
  }

  @override
  Future<List<Todo>> getTodoList() async{
    List<Todo> todoList =[];

    var url = Uri.parse('$dataUrl/todos');
    var response = await http.get(url);
    print('Status Code : ${response.statusCode}');
    var body = jsonDecode(response.body);
    
    for (var i = 0; i < body.length; i++) {
      todoList.add(Todo.fromJson(body[i]));
    } 
    return todoList;
  }

  @override
  Future<String> patchCompleted(Todo todo) async{

    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    String resData = '';
    
    await http.patch(
      url,
      body: {'completed':(todo.completed).toString()},
      headers: {'Authorization':'your_token'},
    ).then((response){
      Map<String,dynamic> result = jsonDecode(response.body);
      resData=result['completed'];
      return resData;
    });
  
    return resData;
    
  }

  @override
  Future<String> postTodo(Todo todo) async{
    print(todo.toJson());
    var url = Uri.parse('$dataUrl/todos/');
    String result = '';
    var response = await http.post(url,body: todo.toJson());
    print(response.statusCode);
    print(response.body);
    return 'true';
  }

  @override
  Future<String> putCompleted(Todo todo) async{
    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    String resData = '';
    
    await http.put(
      url,
      body: {'completed':(todo.completed).toString()},
      headers: {'Authorization':'your_token'},
    ).then((response){
      Map<String,dynamic> result = jsonDecode(response.body);
      print(result);
      resData=result['completed'];
      return resData;
    });
  
    return resData;
  }

}