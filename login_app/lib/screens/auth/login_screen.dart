import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_app/notifications/snackbar.dart';
import 'package:login_app/provider/user_provider.dart';
import 'package:login_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  bool _rememberId = false;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // 안전한 저장소
  final storage = const FlutterSecureStorage();
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  // 저장된 아이디 가져오기 (아이디 저장 시)
  void _loadUsername() async {
    _username = await storage.read(key: 'username');
    if ( _username != null ) {
      _usernameController.text = _username!;
    }
  }
  @override
  Widget build(BuildContext context) {
    // Provider 선언
    // listen
    // - true : 변경 사항을 수신 대기 ⭕ (구독)
    // - false : 변경 사항을 수신 대기 ❌ (구독 안함)
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,    // 키패드 OverFlow
      appBar: AppBar(
        leading: SizedBox.shrink(),
        actions: [IconButton(icon: Icon(Icons.close), onPressed: () {
          Navigator.pop(context);
        })],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                    height: 100,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                // 아이디 입력
                TextFormField(
                  controller: _usernameController,
                  validator: (value) {},
                  decoration: const InputDecoration(
                    labelText: '아이디',
                    hintText: '아이디를 입력해주세요.',
                    prefixIcon: Icon(Icons.person_outline_rounded),
                    border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                // 비밀번호 입력
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {},
                  decoration: InputDecoration(
                      labelText: '비밀번호',
                      hintText: '비밀번호를 입력해주세요.',
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder()),
                  obscureText: !_isPasswordVisible,
                ),
                // 아이디 저장 & 자동 로그인
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                        value: _rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        }),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _rememberMe = !_rememberMe;
                        });
                      },
                      child: Text("자동로그인"),
                    ),
                    Checkbox(
                        value: _rememberId,
                        onChanged: (bool? value) {
                          setState(() {
                            _rememberId = value!;
                          });
                        }),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _rememberId = !_rememberId;
                        });
                      },
                      child: Text("아이디 저장"),
                    ),
                  ],
                ),
                CustomButton(
                  text: "로그인",
                  onPressed: () async {
                    // 유효성 검사
                    if ( !_formKey.currentState!.validate() ) {
                      return;
                    }
                    final username = _usernameController.text;
                    final password = _passwordController.text;

                    // 🔐 로그인 요청
                    await userProvider.login(
                      username, password,
                      rememberId: _rememberId,
                      rememberMe: _rememberMe
                    );

                    if ( userProvider.isLogin ) {
                      print('로그인 성공');

                      Snackbar(
                        text: '로그인에 성공했습니다.', 
                        icon: Icons.check_circle,
                        backgroundColor: Colors.green,
                      ).showSnackbar(context);
                      // 메인으로 이동
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/');
                      return;
                    }
                    print('로그인 실패');
                    Snackbar(
                        text: '로그인에 실패했습니다.', 
                        icon: Icons.error,
                        backgroundColor: Colors.red,
                      ).showSnackbar(context);
                  }
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(onPressed: () {}, child: Text('아이디 찾기')),
                    TextButton(onPressed: () {}, child: Text('비밀번호 찾기')),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: "회원가입",
                  backgroundColor: Colors.black87,
                  onPressed: () {
                    Navigator.pushNamed(context, "/auth/join");
                  }
                )
              ],
            )
          ),
      ),
    );
  }
}
