import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqlite_board_app/models/board.dart';

class BoardService {

  // 데이터 목록 조회
  Future<List<Map<String, dynamic>>> list() async {
    var url = "http://10.0.2.2:8080/boards";
    var list;
    try {
      var response = await http.get(Uri.parse(url));
      print("::::: response - body :::::");
      print(response.body);
      // UTP-8 디코딩
      var utf8Decoded = utf8.decode(response.bodyBytes);
      // JSON 디코딩
      List<dynamic> jsonList = jsonDecode(utf8Decoded);
      // List<dynamic> => List<Map<String, dynamic>>
      list = jsonList.map( (e) => e as Map<String, dynamic> ).toList();
    } catch (e) {
      print(e);
    }
    return list;
  }

  // 데이터 조회
  Future<Map<String, dynamic>?> select(String id) async {
    var url = "http://10.0.2.2:8080/boards/$id";
    var board;
    try {
      var response = await http.get(Uri.parse(url));
      print("::::: response - body :::::");
      print(response.body);
      // UTP-8 디코딩
      var utf8Decoded = utf8.decode(response.bodyBytes);
      // JSON 디코딩
      board = jsonDecode(utf8Decoded);
      // boardList :: List<Map<String, dynamic>>
    } catch (e) {
      print(e);
    }
    return board;
  }

  // 데이터 등록
  Future<int> insert(Board board) async {
    var url = "http://10.0.2.2:8080/boards";
    int result = 0;
    try {
      var response = await http.post(Uri.parse(url), headers: {"content-Type" : "application/json"}, body: jsonEncode( board.toMap() ));
      print("::::: response - body :::::");
      print(response.body);

      if( response.statusCode == 200 || response.statusCode == 201 ) {
        print("게시글 등록 성공!");
        result = 1;
      } else {
        print("게시글 등록 실패!");
        result = 0;

      }
    } catch (e) {
      print(e);
    }
    return result;
    
  }

  // 데이터 수정
  Future<int> update(Board board) async {
    var url = "http://10.0.2.2:8080/boards";
    int result = 0;

    try {
      var response = await http.put(Uri.parse(url), headers: {"content-Type" : "application/json"}, body: jsonEncode( board.toMap() ));
      print("::::: response - body :::::");
      print(response.body);

      if( response.statusCode == 200 || response.statusCode == 204 ) {
        print("게시글 수정 성공!");
        result = 1;
      } else {
        print("게시글 수정 실패!");
        result = 0;

      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  // 데이터 삭제
  Future<int> delete(String id) async {
    var url = "http://10.0.2.2:8080/boards/$id";
    int result = 0;
    try {
      var response = await http.delete(Uri.parse(url));
      print("::::: response - body :::::");
      print(response.body);

      if( response.statusCode == 200 || response.statusCode == 204 ) {
        print("게시글 삭제 성공!");
        result = 1;
      } else {
        print("게시글 삭제 실패!");
        result = 0;

      }
    } catch (e) {
      print(e);
    }
    return result;
  }
}