//خدمة التوثيق هي المسؤولة عن إدارة عمليات تسجيل الدخول والخروج والحفاظ على جلسة المستخدم (Session Management).

import 'local_storage_service.dart';
class AuthService {
  final LocalStorageService localStorageService;
  AuthService(this.localStorageService);

  Future<void> login(String token) async {
    await localStorageService.saveString('auth_token', token);
  }

  Future<void> logout() async {
    await localStorageService.remove('auth_token');
  }

  Future<bool> isLoggedIn() async {
    final token = await localStorageService.getString('auth_token');
    return token != null;
  }
}
