import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserDetailsScreen extends StatefulWidget {
  final String userId; // รับ userId จากหน้าก่อนหน้า

  const UserDetailsScreen({required this.userId});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final response = await http.get(
        Uri.parse('http://203.158.223.154/hunterproject/member_api.php?action=get_user&user_id=${widget.userId}'),
      );

      if (response.statusCode == 200) {
        setState(() {
          userData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('ไม่สามารถดึงข้อมูลผู้ใช้ได้');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาด: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ข้อมูลผู้ใช้')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userData == null
              ? Center(child: Text('ไม่พบข้อมูลผู้ใช้'))
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ชื่อผู้ใช้: ${userData!['username']}', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Text('อีเมล: ${userData!['email']}', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Text('ชื่อเต็ม: ${userData!['full_name']}', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Text('เบอร์โทรศัพท์: ${userData!['phone']}', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
    );
  }
}