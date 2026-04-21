import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import 'package:dropdown_search/dropdown_search.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> register (UserModel user) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: user.email, 
        password: user.password!,
      );

      await _firestore.collection('user').doc(userCredential.user!.uid)
      .set(user.toMap());

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Lỗi: Không xác định!";
    }
  }

  Future<String?> login (UserModel user) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: user.email, 
        password: user.password!
      );

      return null;
    } on FirebaseAuthException catch (e)  {
      if (e.code == 'user-not-found') return 'Email chưa được đăng ký';
      if (e.code == 'wrong-password') return 'Sai mật khẩu';
      if (e.code == 'invalid-email') return 'Định dạng email không đúng';

      return e.message;
    }
  }
}