import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:university_student_geodata/core/app_export.dart';
import 'package:university_student_geodata/core/extensions.dart';
import 'package:university_student_geodata/services/api_service.dart'; // Import ApiService
import 'login/widgets/login_form_widget.dart';
import 'login/widgets/register_link_widget.dart';
import 'login/widgets/sso_login_widget.dart';
import 'login/widgets/university_logo_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;
  String? _errorMessage;
  final ApiService _apiService = ApiService(); // Instantiate ApiService

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin(String username, String password) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    FocusScope.of(context).unfocus();

    // Get the role based on the selected tab
    final String role = ['student', 'faculty', 'admin'][_tabController.index];

    // Call the real API service
    final result = await _apiService.login(username, password);

    if (result['success']) {
      HapticFeedback.lightImpact();

      if (mounted) {
        // IMPORTANT: For real role-based navigation,
        // the API should return the user's role.
        // We are using the tab index for now.
        switch (role) {
          case 'student':
            Navigator.pushReplacementNamed(context, '/dashboard-screen');
            break;
          case 'faculty':
            Navigator.pushReplacementNamed(context, '/lecturer-dashboard');
            break;
          case 'admin':
            Navigator.pushReplacementNamed(context, '/admin-dashboard');
            break;
        }
      }
    } else {
      setState(() {
        _errorMessage = result['error'] ?? 'An unknown error occurred.';
      });
      HapticFeedback.mediumImpact();
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleSsoLogin() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('SSO login feature coming soon'),
        duration: const Duration(seconds: 2),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }

  void _handleRegisterTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
            'Please contact university administration for registration'),
        duration: const Duration(seconds: 3),
        backgroundColor: AppTheme.lightTheme.colorScheme.secondary,
      ),
    );
  }

  void _dismissError() {
    setState(() {
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizerUtil.init(context);
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  SizedBox(height: 6.h),
                  const UniversityLogoWidget(),
                  SizedBox(height: 4.h),
                  if (_errorMessage != null) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12.0),
                      margin: const EdgeInsets.only(bottom: 24.0),
                      decoration: BoxDecoration(
                        color: AppTheme.errorColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: AppTheme.errorColor.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: AppTheme.errorColor,
                            size: 20,
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: Text(
                              _errorMessage!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppTheme.errorColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          IconButton(
                            onPressed: _dismissError,
                            icon: const Icon(
                              Icons.close,
                              color: AppTheme.errorColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabs: const [
                      Tab(text: 'Student'),
                      Tab(text: 'Lecturer'),
                      Tab(text: 'Admin/Staff'),
                    ],
                  ),
                  SizedBox(
                    height: 280,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        LoginFormWidget(
                          onLogin: _handleLogin,
                          isLoading: _isLoading,
                          userTypeLabel: 'Student',
                        ),
                        LoginFormWidget(
                          onLogin: _handleLogin,
                          isLoading: _isLoading,
                          userTypeLabel: 'Lecturer',
                        ),
                        LoginFormWidget(
                          onLogin: _handleLogin,
                          isLoading: _isLoading,
                          userTypeLabel: 'Admin/Staff',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  SsoLoginWidget(
                    onSsoLogin: _handleSsoLogin,
                    isLoading: _isLoading,
                  ),
                  const SizedBox(height: 24.0),
                  RegisterLinkWidget(
                    onRegisterTap: _handleRegisterTap,
                  ),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
