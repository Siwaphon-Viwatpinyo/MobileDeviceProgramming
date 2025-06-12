import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MemberListScreen extends StatefulWidget {
  @override
  _MemberListScreenState createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  List<dynamic> members = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMembers();
  }

  Future<void> _fetchMembers() async {
    try {
      final response = await http.get(
        Uri.parse('http://203.158.223.154/hunterproject/member_api.php?action=get_all_members'),
      );

      if (response.statusCode == 200) {
        setState(() {
          members = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('ไม่สามารถดึงรายชื่อสมาชิกได้');
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
      appBar: AppBar(title: Text('รายชื่อสมาชิก')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : members.isEmpty
              ? Center(child: Text('ไม่มีสมาชิกในระบบ'))
              : ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member = members[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(member['full_name']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('อีเมล: ${member['email']}'),
                            Text('เบอร์โทรศัพท์: ${member['phone']}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}