import 'package:http/http.dart' as http;
import 'dart:convert';

class MemberService {
  final String baseUrl = 'http://203.158.223.154/hunterproject/member_api.php';

  // ฟังก์ชันสมัครสมาชิก
  Future<dynamic> register({
    required String username,
    required String email,
    required String password,
    required String fullname, // เพิ่ม fullname
    required String phonenumber, // เพิ่ม phonenumber
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl?action=register'),
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
          'full_name': fullname, // ส่ง fullname ไปยัง API
          'phone': phonenumber, // ส่ง phonenumber ไปยัง API
        }),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('สมัครสมาชิกไม่สำเร็จ');
      }
    } catch (e) {
      print('เกิดข้อผิดพลาด: $e');
      rethrow;
    }
  }
}