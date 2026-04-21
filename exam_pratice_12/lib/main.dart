import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; 
import '../firebase_options.dart'; 
import '../screens/welcome_screen.dart';

void main() async {
  // 2. Đảm bảo Flutter Engine đã sẵn sàng
  WidgetsFlutterBinding.ensureInitialized();

  // 3. Khởi tạo Firebase với cấu hình mặc định cho từng nền tảng
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Lỗi khởi tạo Firebase: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PhoneGear Exam',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Khuyên dùng cho giao diện hiện đại
      ),
      home: const WelcomeScreen(),
    );
  }
}