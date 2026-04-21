import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id; // Thêm ID để dễ quản lý dữ liệu sau này
  final String email;
  final String? password; // Password chỉ dùng để truyền dữ liệu tạm thời, không lưu lên Cloud
  final String nameSchool;
  final DateTime? createdAt; 

  UserModel({
    this.id,
    required this.email,
    this.password,
    required this.nameSchool,
    this.createdAt,
  });

  /// POST
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name_school': nameSchool, 
      'created_at': createdAt ?? FieldValue.serverTimestamp(), 
    };
  }

  /// GET
  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      id: documentId,
      email: map['email'] ?? '',
      nameSchool: map['name_school'] ?? '',
      password: null, 
      createdAt: (map['created_at'] as Timestamp?)?.toDate(),
    );
  }
}