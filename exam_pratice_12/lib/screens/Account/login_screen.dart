import 'package:flutter/material.dart';
import '/models/user_model.dart';
import '/services/auth_service.dart';
import '../Account/register_screen.dart';
import 'package:exam_pratice_12/widgets/buildInput_widget.dart';
import 'package:flutter/gestures.dart';
import '../welcome_screen.dart';
import '../notification_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  bool _isPasswordVisible = true;
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty) {
      _showSnackBar('Chưa điền email');
      return;
    }

    if (password.isEmpty) {
      _showSnackBar('Chưa điền mật khẩu');
      return;
    }

    UserModel userLogin = UserModel(
      email: email,
      password: password,
      nameSchool: "",
    );
    String? result = await _authService.login(userLogin);

    if (result == null) {
      _showSnackBar("Đăng nhập thành công");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NotificationScreen()),
      );
      //PageRoute
    } else {
      _showSnackBar(result ?? "Lỗi");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //back + title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen(),
                            ),
                          );
                        }
                      },
                    ),
                    Text(
                      "Đăng nhập",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 5),

                //Picture
                Center(
                  child: Image.asset(
                    'assets/login.png',
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Chào mừng bạn",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        "Đăng nhập để tiếp tục",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17, color: Colors.grey[70]),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  "Nhập email của bạn",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                BuildinputWidget(
                  hint: "Email",
                  icon: Icons.email,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 10),

                Text(
                  "Nhập mật khẩu",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                BuildinputWidget(
                  hint: "Mật khẩu",
                  icon: Icons.lock,
                  controller: _passwordController,
                  isPassword: true,
                  show: _isPasswordVisible,
                  toggle: () =>
                      setState(() => _isPasswordVisible = !_isPasswordVisible),
                ),

                SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "Đăng nhập",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Quên mật khẩu",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40),

                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Chưa có tài khoản ?",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      children: [
                        TextSpan(
                          text: "Đăng ký tài khoản",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            decoration: TextDecoration.underline,
                          ),

                          /// Link route
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
