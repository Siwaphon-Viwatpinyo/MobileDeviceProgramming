import 'package:flutter/material.dart';
import 'member_service.dart';
import 'user_details_screen.dart';
import 'member_list_screen.dart'; // นำเข้า MemberListScreen

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _memberService = MemberService();

  // Controllers สำหรับ TextField
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullnameController = TextEditingController();
  final _phoneController = TextEditingController();

  void _registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        final result = await _memberService.register(
          username: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          fullname: _fullnameController.text,
          phonenumber: _phoneController.text,
        );

        // ไปยังหน้าจอ UserDetailsScreen พร้อม userId
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailsScreen(userId: result['user_id']),
          ),
        );
      } catch (e) {
        // แสดง Error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เกิดข้อผิดพลาด: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('สมัครสมาชิก')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(labelText: 'ชื่อผู้ใช้'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกชื่อผู้ใช้';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'อีเมล'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกอีเมล';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'รหัสผ่าน'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกรหัสผ่าน';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _fullnameController,
                      decoration: InputDecoration(labelText: 'ชื่อเต็ม'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกชื่อเต็ม';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(labelText: 'เบอร์โทรศัพท์'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกเบอร์โทรศัพท์';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _registerUser,
                      child: Text('สมัครสมาชิก'),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemberListScreen()),
                );
              },
              child: Text('ดูรายชื่อสมาชิก'),
            ),
          ],
        ),
      ),
    );
  }
}