<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

$host = 'localhost';
$dbname = 'member_system';
$username = 'hunter';
$password = 'Hunter1524!';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'การเชื่อมต่อฐานข้อมูลล้มเหลว', 'message' => $e->getMessage()]);
    exit();
}

// รับ Action จาก Request
$action = $_GET['action'] ?? '';

switch($action) {
    // สมัครสมาชิก
    case 'register':
        $data = json_decode(file_get_contents("php://input"), true);
        
        // ตรวจสอบข้อมูลที่ส่งมา
        if (!isset($data['username']) || !isset($data['email']) || !isset($data['password'])) {
            http_response_code(400);
            echo json_encode(['error' => 'ข้อมูลไม่ครบ']);
            exit();
        }

        // เข้ารหัสผ่าน
        $hashedPassword = password_hash($data['password'], PASSWORD_BCRYPT);

        $stmt = $pdo->prepare("INSERT INTO users (username, email, password, full_name, phone) VALUES (?, ?, ?, ?, ?)");
        
        try {
            $stmt->execute([
                $data['username'], 
                $data['email'], 
                $hashedPassword,
                $data['full_name'] ?? null,
                $data['phone'] ?? null
            ]);
            
            http_response_code(201);
            echo json_encode([
                'message' => 'สมัครสมาชิกสำเร็จ', 
                'user_id' => $pdo->lastInsertId()
            ]);
        } catch(PDOException $e) {
            http_response_code(500);
            echo json_encode(['error' => 'สมัครสมาชิกไม่สำเร็จ', 'details' => $e->getMessage()]);
        }
        break;

    // ดึงรายชื่อสมาชิก
    case 'list':
        try {
            $stmt = $pdo->query("SELECT id, username, email, full_name, phone, created_at FROM users");
            $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($users);
        } catch(PDOException $e) {
            http_response_code(500);
            echo json_encode(['error' => 'ดึงข้อมูลสมาชิกไม่สำเร็จ', 'details' => $e->getMessage()]);
        }
        break;

    // แก้ไขข้อมูลสมาชิก
    case 'update':
        $data = json_decode(file_get_contents("php://input"), true);
        $id = $data['id'] ?? null;

        if (!$id) {
            http_response_code(400);
            echo json_encode(['error' => 'ต้องระบุ ID สมาชิก']);
            exit();
        }

        $stmt = $pdo->prepare("UPDATE users SET full_name = ?, phone = ? WHERE id = ?");
        
        try {
            $stmt->execute([
                $data['full_name'] ?? null, 
                $data['phone'] ?? null,
                $id
            ]);
            
            if ($stmt->rowCount() > 0) {
                echo json_encode(['message' => 'แก้ไขข้อมูลสำเร็จ']);
            } else {
                http_response_code(404);
                echo json_encode(['error' => 'ไม่พบสมาชิก']);
            }
        } catch(PDOException $e) {
            http_response_code(500);
            echo json_encode(['error' => 'แก้ไขข้อมูลไม่สำเร็จ', 'details' => $e->getMessage()]);
        }
        break;

    // ลบสมาชิก
    case 'delete':
        $id = $_GET['id'] ?? null;

        if (!$id) {
            http_response_code(400);
            echo json_encode(['error' => 'ต้องระบุ ID สมาชิก']);
            exit();
        }

        $stmt = $pdo->prepare("DELETE FROM users WHERE id = ?");
        
        try {
            $stmt->execute([$id]);
            
            if ($stmt->rowCount() > 0) {
                echo json_encode(['message' => 'ลบสมาชิกสำเร็จ']);
            } else {
                http_response_code(404);
                echo json_encode(['error' => 'ไม่พบสมาชิก']);
            }
        } catch(PDOException $e) {
            http_response_code(500);
            echo json_encode(['error' => 'ลบสมาชิกไม่สำเร็จ', 'details' => $e->getMessage()]);
        }
        break;

    default:
        http_response_code(400);
        echo json_encode(['error' => 'ไม่พบ Action ที่ระบุ']);
        break;
}
?>