import 'dart:convert';
import 'package:elevate_flutter_filtration_task/API/api_constant.dart';
import 'package:elevate_flutter_filtration_task/Model/categorysource.dart';
import 'package:http/http.dart' as http;

class ApiManager{
  static Future<List<CategorySource>> getSource()async{
    Uri url=Uri.https(
      ApiConstant.baseUrl, ApiConstant.sourceUrl
    );
    try{
      var response= await http.get(url);
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => CategorySource.fromJson(json)).toList();
    }catch(e){
      throw e;
    }

  }
}