import 'package:flutter/material.dart';
import '/models/user_model.dart';
import '/services/auth_service.dart';
import '/widgets/school_dropdown.dart';
import '/services/school_service.dart';
import 'package:flutter/gestures.dart';
import '../Account/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  String? selectedSchool;
  List<String> schools = [];

  final AuthService _authService = AuthService();
  final SchoolService _schoolService = SchoolService();

  bool showPass = false;
  bool showConfirm = false;

  @override
  void initState() {
    super.initState();
    initSchools();
  }

  void initSchools() async {
    schools = await _schoolService.loadSchools();
    setState(() {});
  }

  void _register() async {
    if (_passwordController.text != _confirmController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Mật khẩu không khớp")));
      return;
    }

    UserModel user = UserModel(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      nameSchool: selectedSchool ?? "",
    );

    String? result = await _authService.register(user);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(result ?? "Đăng ký thành công")));
  }

  Widget buildInput({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
    bool show = false,
    VoidCallback? toggle,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black12),
      ),
      child: TextField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        obscureText: isPassword ? !show : false,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          prefixIcon: Icon(icon),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(show ? Icons.visibility : Icons.visibility_off),
                  onPressed: toggle,
                )
              : null,
        ),
      ),
    );
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
                // Back + title
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
                            MaterialPageRoute(builder: (context) => LoginScreen())
                          );
                        }
                      },
                    ),
                 
                    Text(
                      "Đăng ký",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 20),

                Text(
                  "Điền thông tin sau",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 20),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      "Nhập email",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 8),

                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "* ",
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                          TextSpan(
                            text: "Email để đổi mật khẩu",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                buildInput(
                  hint: "Nhập email hoặc username",
                  icon: Icons.person,
                  controller: _emailController,
                ),

                Text(
                  "Mật khẩu",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 5),

                buildInput(
                  hint: "Nhập mật khẩu",
                  icon: Icons.lock,
                  controller: _passwordController,
                  isPassword: true,
                  show: showPass,
                  toggle: () => setState(() => showPass = !showPass),
                ),

                Text(
                  " Xác nhận mật khẩu",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 5),
                buildInput(
                  hint: "Nhập lại mật khẩu",
                  icon: Icons.lock,
                  controller: _confirmController,
                  isPassword: true,
                  show: showConfirm,
                  toggle: () => setState(() => showConfirm = !showConfirm),
                ),

                Text(
                  "Trường học",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 5),
                // Dropdown
                SchoolDropdown(
                  schools: schools,
                  selected: selectedSchool,
                  onChanged: (value) {
                    setState(() {
                      selectedSchool = value;
                    });
                  },
                ),

                SizedBox(height: 25),

                // Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "Đăng ký",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Điều khoản",
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
                      text: "Đã có tài khoản? ",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      children: [
                        TextSpan(
                          text: "Đăng nhập ngay",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            decoration: TextDecoration.underline
                          ),

                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                              );
                            }
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
