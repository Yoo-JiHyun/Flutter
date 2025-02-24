import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:sqlite_board_app/models/board.dart';

class BoardService {

  // 데이터 목록 조회
  Future<List<Map<String, dynamic>>> list() async {
    Dio dio = Dio();
    var url = "http://10.0.2.2:8080/boards";
    dynamic list;
    try {
      Response response = await dio.get(url);
      print("::::: response - body :::::");
      print(response.data);
      // response.data :: List<dynamic>
      // => List
      // => List<Map<String, dynamic>>
      list = (response.data as List)
                      .map( (e) => e as Map<String, dynamic>) // 타입 변환
                      .toList();
      print(list);
      return list;
    } catch (e) {
      print(e);
    }
    return list;
  }

  // 데이터 조회
  Future<Map<String, dynamic>?> select(String id) async {
    Dio dio = Dio();
    var url = "http://10.0.2.2:8080/boards/$id";
    var board;
    try {
      var response = await dio.get(url);
      print("::::: response - body :::::");
      print(response.data);
      board = response.data;
    } catch (e) {
      print(e);
    }
    return board;
  }

  // 데이터 등록
  Future<int> insert(Board board) async {
    Dio dio = Dio();
    var url = "http://10.0.2.2:8080/boards";
    int result = 0;
    try {
      var response = await dio.post(url, data: board.toMap());
      print("::::: response - body :::::");
      print(response.data);
      print(response.statusCode);

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
    Dio dio = Dio();
    var url = "http://10.0.2.2:8080/boards";
    int result = 0;

    try {
      var response = await dio.put(url, data: board.toMap());
      print("::::: response - body :::::");
      print(response.data);

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
    Dio dio = Dio();
    var url = "http://10.0.2.2:8080/boards/$id";
    int result = 0;
    try {
      var response = await dio.delete(url);
      print("::::: response - body :::::");
      print(response.data);

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