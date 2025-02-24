import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart' as picker;

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {

  // 🧊 state 
  // _변수 : private 변수
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwChkController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();

  String _gender = "남자";

  // 폼 키
  final _formKey = GlobalKey<FormState>();  // Form 위젯을 제어하기 위한 키

  // 달력 설정
  List<DateTime?> _dateDefaultValue = [ DateTime.now() ];
  final config = picker.CalendarDatePicker2Config(
    // 캘린더 타입 : single, multi, range
    calendarType: picker.CalendarDatePicker2Type.range,
    // 선택한 날자 색상
    selectedDayHighlightColor: Colors.redAccent,
    // 요일 라벨
    weekdayLabels: ['일','월','화','수','목','금','토'],
    // 요일 스타일
    weekdayLabelTextStyle: const TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.bold
    ),
    // 시작 요일 : 0 (일), 1(월)
    firstDayOfWeek: 0,
    // 컨트롤 높이 사이즈
    controlsHeight: 50,
    // 날짜 스타일
    dayTextStyle: const TextStyle(
      color: Colors.green,
    ),
    // 비활성화된 날짜 스타일
    disabledDayTextStyle: const TextStyle(
      color: Colors.grey
    ),
    // 선택가능한 날짜 설정
    // DateTime.now() : 현재 날짜 시간          - 2025/01/27
    // difference()   : 두 날짜 객체 간의 차이
    // DateTime.now().subtract(const Duration(days: 1)) 
    // : 오늘 날짜에서 1일을 뺀 값              - 2025/01/26
    // day.difference( 어제 ) : 선택된 날짜와 어제 날짜 사이의 시간 간격 
    // isNegative : 음수인 확인 (특정 날짜와 어제 날짜 사이의 차이 음수면 true)
    selectableDayPredicate: (day) => !day
                                  .difference(DateTime.now().subtract(const Duration(days: 1)))
                                  .isNegative,


  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: ListView(
        children: [
          const Text("회원가입", style: TextStyle(fontSize: 30.0)),
          Form(
            key: _formKey,
            child: Column(
              children: [
                // 아이디
                TextFormField(
                  autofocus: true,      // 자동 커서 지정
                  decoration: const InputDecoration(
                    labelText: "아이디",
                    hintText: "아이디를 입력해주세요."
                  ),
                  controller: _idController,
                  // 유효성 검사
                  validator: (value) {
                    if( value == null || value.isEmpty ) {
                      return "아이디를 입력해주세요.";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0,),

                // 비밀번호
                TextFormField(
                  obscureText: true,      // 입력 기호로 숨김 여부
                  decoration: const InputDecoration(
                    labelText: "비밀번호",
                    hintText: "비밀번호를 입력해주세요."
                  ),
                  controller: _pwController,
                  // 유효성 검사
                  validator: (value) {
                    if( value == null || value.isEmpty ) {
                      return "비밀번호를 입력해주세요.";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20.0,),
                
                // 비밀번호 확인
                TextFormField(
                  obscureText: true,      // 입력 기호로 숨김 여부
                  decoration: const InputDecoration(
                    labelText: "비밀번호 확인",
                    hintText: "비밀번호 확인를 입력해주세요."
                  ),
                  controller: _pwChkController,
                  // 유효성 검사
                  validator: (value) {
                    if( value == null || value.isEmpty ) {
                      return "비밀번호 확인를 입력해주세요.";
                    }
                    // 비밀번호로 일치하는지 확인
                    if( value != _pwController.text ) {
                      return "비밀번호가 일치하지 않습니다.";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20.0,),

                // 성별
                Row(
                  children: [
                    Text("성별"),
                    Radio(
                      value: "남자",
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = "남자";
                        });
                      }
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _gender = "남자";
                        });
                      },
                      child: Text("남자"),
                    ),
                    Radio(
                      value: "여자",
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = "여자";
                        });
                      }
                    ),
                     GestureDetector(
                      onTap: () {
                        setState(() {
                          _gender = "여자";
                        });
                      },
                      child: Text("여자"),
                    ),
                  ],

                ),

                SizedBox(height: 20.0,),

                // 생년월일
                Column(
                  children: [
                    TextFormField(
                      controller: _birthController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "생년월일",
                        // 뒤쪽 아이콘
                        suffixIcon: GestureDetector(
                          onTap: () async { 
                            print("생년월일 달력 아이콘 클릭...");

                            final result = await showDialog<List<DateTime>>(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: 
                                    picker.CalendarDatePicker2(
                                      // 캘린더 설정
                                      config: picker.CalendarDatePicker2Config(
                                        calendarType: picker.CalendarDatePicker2Type.single, // 단일 날짜 선택
                                        selectedDayHighlightColor: Colors.orange, // 선택된 날짜 강조 색상
                                        weekdayLabels: ['월','화','수','목','금','토','일'],
                                      ), 
                                      value: [],
                                      // 달력에서 선택한 값 변경 시
                                      onValueChanged: (dates) {
                                        print(dates[0]);
                                        if (dates.isNotEmpty) {
                                          Navigator.pop(context, dates); // 선택된 날짜 반환
                                        }
                                      },
                                      
                                    ),
                                );
                              }
                            );// result

                            if( result != null && result.isNotEmpty ) {
                              print(result);
                              // 선택된 날짜 - 2025/01/01
                              final selectedDate = result[0];
                              final formatDate 
                                = "${selectedDate.year}/"
                                  "${selectedDate.month.toString().padLeft(2, '0')}/"
                                  "${selectedDate.day.toString().padLeft(2, '0')}";                            
                              _birthController.text = formatDate;

                            }
                          },
                          child: Icon(Icons.calendar_month),
                        )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),

                // 날짜 선택
                picker.CalendarDatePicker2(
                  config: config,
                  value: [],
                  onValueChanged: (dates) {
                    print(dates);
                    if( dates.length == 2 ) {
                      print("시작일 : ${dates[0]}");
                      print("종료일 : ${dates[1]}");
                    }
                  },
                ),


                SizedBox(height: 30.0,),

                // 회원 가입 버튼
                ElevatedButton(
                  onPressed: () {
                    // 유효성 검사
                    if( _formKey.currentState!.validate() ) {
                      // 유효성 검사 성공
                      print("유효성 검사 성공!");
                      // 폼 제출
                      print("아이디 : ${_idController.text}");
                      print("비밀번호 : ${_pwController.text}");
                      print("비밀번호 확인 : ${_pwChkController.text}");
                      print("성별 : ${_gender}");
                      print("생년월일 : ${_birthController.text}");
                      print("선택 날짜 : ${_dateDefaultValue}");

                    } else {
                      // 유효성 검사 실패
                      print("유효성 검사 실패!");
                    }
                  },
                  child: Text("회원가입")
                )
              ],
            )

          )

        ]
      ),
    );
  }
}