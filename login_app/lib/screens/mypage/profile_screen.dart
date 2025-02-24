import 'package:flutter/material.dart';
import 'package:login_app/models/user.dart';
import 'package:login_app/notifications/snackbar.dart';
import 'package:login_app/provider/user_provider.dart';
import 'package:login_app/screens/home_screen.dart';
import 'package:login_app/services/user_service.dart';
import 'package:login_app/widgets/commom_bottom_navigation_bar.dart';
import 'package:login_app/widgets/custom_button.dart';
import 'package:login_app/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  User? _user;
  UserService userService = UserService();

  @override
  void initState() {
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {

    UserProvider userProvider = Provider.of<UserProvider>(context, listen: true);

    // 로그인 상태 확인
    // - 로그인이 안되어 있으면,
    if( !userProvider.isLogin ) {
      // ➡ 로그인 페이지로 리다이렉트
      WidgetsBinding.instance.addPostFrameCallback( (_) {
        // 남아있는 스택이 있는지 확인
        if( Navigator.canPop(context) ) {
          Navigator.pop(context);
        }
        Navigator.pushNamed(context, "/auth/login");
      });

      return const HomeScreen();
    }

    // 👩‍💼 로그인 상태
    String? _username = userProvider.userInfo.username ?? '없음';

    // 사용자 정보 조회 요청
    if( _user == null ) {
      userService.getUser(_username).then((value) {
        print(value);
        setState(() {
          _user = User.fromMap(value);
        });
        // 텍스트 폼 필드에 출력
        _usernameController.text = _user?.username ?? _username;
        _nameController.text = _user?.name ?? '';
        _emailController.text = _user?.email ?? '';
      });
    }
 
    return Scaffold(
      resizeToAvoidBottomInset: false,  // 키패드 OverFlow 방지
      appBar: AppBar(
        title: Text("마이"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: 
          Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: 
                    Text(
                      "프로필 수정",
                      style: 
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold), 
                    )
                ),
                const SizedBox(height: 20,),
                // 아이디
                TextFormField(
                  controller: _usernameController,
                  validator: (value) {},
                  decoration: const InputDecoration(
                    labelText: '아이디',
                    hintText: '아이디를 입력해주세요.',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _user?.username = value;
                    });
                  },
                ),
                const SizedBox(height: 16,),
                // 이름
                TextFormField(
                  controller: _nameController,
                  validator: (value) {},
                  decoration: const InputDecoration(
                    labelText: '이름',
                    hintText: '이름을 입력해주세요.',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _user?.name = value;
                    });
                  },
                ),
                const SizedBox(height: 16,),
                // 이메일
                TextFormField(
                  controller: _emailController,
                  validator: (value) {},
                  decoration: const InputDecoration(
                    labelText: '이메일',
                    hintText: '이메일을 입력해주세요.',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _user?.email = value;
                    });
                  },
                ),
                const SizedBox(height: 20,),
                CustomButton(
                  text: "회원 탈퇴", 
                  isFullWidth: true,
                  backgroundColor: Colors.redAccent,
                  onPressed: () {
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("회원 탈퇴"),
                          content: Text("정말로 탈퇴하시겠습니까?"),
                          actions: <Widget>[
                            TextButton(
                              child: Text("취소"),
                              onPressed: () {
                                Navigator.pop(context);
                              }, 
                            ),
                            TextButton(
                              child: Text("확인"),
                              onPressed: () {
                                Navigator.pop(context);
                                // 회원 탈퇴 요청
                                userService.deleteUser(_username).then((value) {
                                  if(value) {
                                    // 회원 탈퇴 성공
                                    // - 로그아웃 처리
                                    userProvider.logout();
                                    // - 홈 화면으로 이동
                                    Navigator.pushReplacementNamed(context, '/');
                                  }
                                });
                              }, 
                            ),
                          ],
                        );
                      }
                    );
                  }
                )
              ],
            ),
          ),
      ),
      bottomSheet: CustomButton(
        text: '회원 정보 수정',
        isFullWidth: true, 
        onPressed: () async {
          if( _formKey.currentState!.validate() ) {
            // 👩‍🔧 회원정보 수정 요청
            bool result = await userService.updateUser(
              {
                'username' : _username,
                'name' : _user!.name,
                'email' : _user!.email
              }
            );
            if( result ) {
              Snackbar(
                text: "회원정보 수정에 성공하였습니다.",
                icon: Icons.check_circle,
                backgroundColor: Colors.green
              ).showSnackbar(context);
              
              // provider 에 수정된 사용자 정보 업데이트
              userProvider.userInfo = User(
                username: _username,
                name: _user!.name,
                email: _user!.email
              );
            }
          }
        }
      ),
      endDrawer: CustomDrawer(),
      bottomNavigationBar: CommomBottomNavigationBar(
        currentIndex: 4
      ),
    );
  }
}