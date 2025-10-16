import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:university_student_geodata/core/app_export.dart';
import 'package:university_student_geodata/core/extensions.dart';
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
  final _secureStorage = const FlutterSecureStorage();

  // Mock credentials for testing
  final List<Map<String, String>> _mockCredentials = [
    {"email": "student@kca.ac.ke", "password": "student123", "type": "student"},
    {"email": "CS1234", "password": "password123", "type": "student"},
    {"email": "faculty@kca.ac.ke", "password": "faculty123", "type": "faculty"},
    {"email": "admin@kca.ac.ke", "password": "admin123", "type": "admin"}
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Set status bar style
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

  Future<void> _handleLogin(String email, String password, String role) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Check mock credentials
      final credential = _mockCredentials.firstWhere(
        (cred) =>
            (cred["email"]?.toLowerCase() == email.toLowerCase()) &&
            (cred["password"] == password) && (cred["type"] == role),
        orElse: () => <String, String>{},
      );

      if (credential.isNotEmpty) {
        // *** MOCK TOKEN STORAGE ***
        // In a real app, you would get this token from your backend.
        const mockToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IlN0dWRlbnQgVXNlciIsImlhdCI6MTUxNjIzOTAyMn0.dummy_token_for_testing';
        await _secureStorage.write(key: 'auth_token', value: mockToken);
        // **************************

        // Success - provide haptic feedback
        HapticFeedback.lightImpact();

        // Navigate to dashboard
        if (mounted) {
          switch (credential['type']) {
            case 'student':
              Navigator.pushNamed(context, '/dashboard-screen');
              break;
            case 'faculty':
              Navigator.pushNamed(context, '/lecturer-dashboard');
              break;
            case 'admin':
              Navigator.pushNamed(context, '/admin-dashboard');
              break;
            default:
              Navigator.pushNamed(context, '/dashboard-screen');
          }
        }
      } else {
        // Invalid credentials
        setState(() {
          _errorMessage =
              'Invalid email/student ID or password. Please check your credentials and try again.';
        });
        HapticFeedback.mediumImpact();
      }
    } catch (e) {
      setState(() {
        _errorMessage =
            'Network error. Please check your connection and try again.';
      });
      HapticFeedback.mediumImpact();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _handleSsoLogin() {
    // Simulate SSO login
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('SSO login feature coming soon'),
        duration: const Duration(seconds: 2),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }

  void _handleRegisterTap() {
    // Navigate to registration or show info
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

                  // University Logo Section
                  const UniversityLogoWidget(),

                  SizedBox(height: 4.h),

                  // Error Message
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
                    isScrollable: true, // Make the tabs horizontally scrollable
                    tabs: const [
                      Tab(text: 'Student'),
                      Tab(text: 'Lecturer'),
                      Tab(text: 'Admin/Staff'),
                    ],
                  ),
                  SizedBox(
                    height: 280, // Giving the TabBarView a fixed height
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        LoginFormWidget(
                          onLogin: (email, password) => _handleLogin(email, password, 'student'),
                          isLoading: _isLoading,
                          userTypeLabel: 'Student',
                        ),
                        LoginFormWidget(
                          onLogin: (email, password) => _handleLogin(email, password, 'faculty'),
                          isLoading: _isLoading,
                          userTypeLabel: 'Lecturer',
                        ),
                        LoginFormWidget(
                          onLogin: (email, password) => _handleLogin(email, password, 'admin'),
                          isLoading: _isLoading,
                          userTypeLabel: 'Admin/Staff',
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 2.h),

                  // SSO Login Section
                  SsoLoginWidget(
                    onSsoLogin: _handleSsoLogin,
                    isLoading: _isLoading,
                  ),

                  const SizedBox(height: 24.0),
                  // Register Link
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
