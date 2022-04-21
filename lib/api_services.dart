import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:search_delegate_app/user_model.dart';

class FetchUser{
  var data= [];
  String fetchUrl="https://jsonplaceholder.typicode.com/users";
  List<Userlist> results=[];

  Future<List<Userlist>> getUserList() async {
    
    var url = Uri.parse(fetchUrl);
    var response= await http.get(url);
    try {
      if(response.statusCode==200){
        data = json.decode(response.body);
        results=data.map((e) => Userlist.fromJson(e)).toList();
        print(results);
      }else{
        print('api error');
        print(response.statusCode);
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }
}