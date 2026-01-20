import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_app/screens/admin_screen.dart';
import 'package:flutter_auth_app/screens/user_screen.dart';
import 'package:get/get.dart';
import '../repo/auth_repo.dart';
import '../controllers/user_controller.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxBool loading = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxnString error = RxnString();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    emailController.addListener(() {
      email.value = emailController.text;
    });
    passwordController.addListener(() {
      password.value = passwordController.text;
    });
  }

  Future<void> login() async {
    loading.value = true;
    error.value = null;

    try {
      await authRepo.login(email.value.trim(), password.value.trim());

      final role = userController.role.value;
      if (role == 'admin') {
        Get.off(() => const AdminDashboard());
      } else {
        Get.off(() => const UserDashboard());
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          error.value = 'Please enter a valid email address.';
          break;
        case 'user-disabled':
          error.value = 'This account has been disabled. Contact support.';
          break;
        case 'user-not-found':
          error.value = 'No user found with this email.';
          break;
        case 'wrong-password':
          error.value = 'Incorrect password. Please try again.';
          break;
        case 'too-many-requests':
          error.value = 'Too many login attempts. Please try again later.';
          break;
        case 'operation-not-allowed':
          error.value = 'Email/Password login is not enabled. Contact support.';
          break;
        case 'network-request-failed':
          error.value = 'Network error. Check your internet connection.';
          break;
        default:
          error.value = 'Login failed. Please try again later.';
      }
    } catch (e) {
      error.value = 'An unexpected error occurred. Please try again.';
    } finally {
      loading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
