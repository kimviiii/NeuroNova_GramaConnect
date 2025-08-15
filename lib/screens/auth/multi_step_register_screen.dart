import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/theme.dart';

class MultiStepRegisterScreen extends StatefulWidget {
  const MultiStepRegisterScreen({super.key});

  @override
  State<MultiStepRegisterScreen> createState() => _MultiStepRegisterScreenState();
}

class _MultiStepRegisterScreenState extends State<MultiStepRegisterScreen> {
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  // Controllers for all form fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nicController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Location data
  String? _selectedDistrict;
  String? _selectedDivisionalSecretariat;
  String? _selectedGramaNiladhariDivision;

  // Location options
  final Map<String, Map<String, List<String>>> _locationData = {
    'Colombo': {
      'Colombo': [
        'Colombo Central',
        'Slave Island',
        'Kollupitiya',
        'Bambalapitiya',
        'Narahenpita',
        'Kirulapone',
        'Wellawatta',
        'Dehiwala North',
        'Dehiwala South',
        'Mount Lavinia',
        'Ratmalana',
        'Moratuwa East',
        'Moratuwa West',
        'Piliyandala',
        'Kesbewa'
      ],
      'Borella': [
        'Borella North',
        'Borella South',
        'Cinnamon Gardens',
        'Maradana East',
        'Maradana West'
      ],
      'Maradana': [
        'Maradana Central',
        'Dematagoda',
        'Grandpass North',
        'Grandpass South',
        'Kotahena East',
        'Kotahena West',
        'Modara',
        'Mutwal'
      ]
    }
  };

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nicController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _nextStep() {
    print('🔍 _nextStep called, current step: $_currentStep');
    
    if (_currentStep < 2) {
      bool isValid = _validateCurrentStep();
      print('🔍 Step $_currentStep validation result: $isValid');
      
      if (isValid) {
        print('✅ Moving to next step');
        setState(() {
          _currentStep++;
        });
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        // Show validation error message
        String errorMessage = _getValidationErrorMessage();
        print('❌ Validation error: $errorMessage');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      print('🚀 Submitting registration');
      _submitRegistration();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _validateCurrentStep() {
    print('🔍 Validating step $_currentStep');
    
    switch (_currentStep) {
      case 0:
        bool nameValid = _nameController.text.isNotEmpty;
        bool emailValid = _emailController.text.isNotEmpty && _emailController.text.contains('@');
        bool phoneValid = _phoneController.text.isNotEmpty;
        bool nicValid = _nicController.text.isNotEmpty;
        bool addressValid = _addressController.text.isNotEmpty;
        
        print('📝 Name: ${_nameController.text} (valid: $nameValid)');
        print('📧 Email: ${_emailController.text} (valid: $emailValid)');
        print('📞 Phone: ${_phoneController.text} (valid: $phoneValid)');
        print('🆔 NIC: ${_nicController.text} (valid: $nicValid)');
        print('🏠 Address: ${_addressController.text} (valid: $addressValid)');
        
        return nameValid && emailValid && phoneValid && nicValid && addressValid;
      case 1:
        print('🗺️ District: $_selectedDistrict');
        print('🏛️ Divisional Secretariat: $_selectedDivisionalSecretariat');
        print('🏘️ GN Division: $_selectedGramaNiladhariDivision');
        
        return _selectedDistrict != null &&
               _selectedDivisionalSecretariat != null &&
               _selectedGramaNiladhariDivision != null;
      case 2:
        bool passwordValid = _passwordController.text.isNotEmpty;
        bool passwordsMatch = _passwordController.text == _confirmPasswordController.text;
        
        print('🔒 Password valid: $passwordValid');
        print('🔒 Passwords match: $passwordsMatch');
        
        return passwordValid && passwordsMatch;
      default:
        return false;
    }
  }

  String _getValidationErrorMessage() {
    switch (_currentStep) {
      case 0:
        if (_nameController.text.isEmpty) return 'Please enter your full name';
        if (_emailController.text.isEmpty) return 'Please enter your email';
        if (!_emailController.text.contains('@')) return 'Please enter a valid email';
        if (_phoneController.text.isEmpty) return 'Please enter your phone number';
        if (_nicController.text.isEmpty) return 'Please enter your NIC number';
        if (_addressController.text.isEmpty) return 'Please enter your address';
        return 'Please fill all required fields';
      case 1:
        if (_selectedDistrict == null) return 'Please select a district';
        if (_selectedDivisionalSecretariat == null) return 'Please select a divisional secretariat';
        if (_selectedGramaNiladhariDivision == null) return 'Please select a Grama Niladhari division';
        return 'Please complete location selection';
      case 2:
        if (_passwordController.text.isEmpty) return 'Please enter a password';
        if (_confirmPasswordController.text.isEmpty) return 'Please confirm your password';
        if (_passwordController.text != _confirmPasswordController.text) return 'Passwords do not match';
        return 'Please complete password setup';
      default:
        return 'Please complete this step';
    }
  }

  Future<void> _submitRegistration() async {
    if (!_validateCurrentStep()) return;

    final userData = {
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim().toLowerCase(),
      'phone': _phoneController.text.trim(),
      'nic': _nicController.text.trim(),
      'address': _addressController.text.trim(),
      'district': _selectedDistrict,
      'divisional_secretariat': _selectedDivisionalSecretariat,
      'grama_niladhari_division': _selectedGramaNiladhariDivision,
      'password': _passwordController.text,
      'role': 'citizen'
    };

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.registerWithFullData(userData);

    if (success && mounted) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage ?? 'Registration failed'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: _currentStep > 0
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.primary),
                onPressed: _previousStep,
              )
            : IconButton(
                icon: Icon(Icons.close, color: AppColors.primary),
                onPressed: () => Navigator.of(context).pop(),
              ),
        title: Text(
          'Create Account',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Progress indicator
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: List.generate(3, (index) {
                  return Expanded(
                    child: Container(
                      height: 4,
                      margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
                      decoration: BoxDecoration(
                        color: index <= _currentStep
                            ? AppColors.primary
                            : AppColors.muted.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              ),
            ),
            
            // Step content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildPersonalInfoStep(),
                  _buildLocationStep(),
                  _buildAccountSetupStep(),
                ],
              ),
            ),
            
            // Bottom navigation
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: authProvider.isLoading ? null : _nextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: authProvider.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              _currentStep < 2 ? 'Continue' : 'Create Account',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Information',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please provide your personal details',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.muted,
            ),
          ),
          const SizedBox(height: 24),
          
          _buildTextField(
            controller: _nameController,
            label: 'Full Name *',
            icon: Icons.person,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Full name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _emailController,
            label: 'Email Address *',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _phoneController,
            label: 'Phone Number *',
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Phone number is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _nicController,
            label: 'NIC Number *',
            icon: Icons.credit_card,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'NIC number is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _addressController,
            label: 'Address *',
            icon: Icons.location_on,
            maxLines: 2,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Address is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLocationStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location Details',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select your administrative divisions',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.muted,
            ),
          ),
          const SizedBox(height: 24),
          
          _buildDropdownField(
            value: _selectedDistrict,
            items: _locationData.keys.toList(),
            label: 'District *',
            icon: Icons.map,
            onChanged: (value) {
              setState(() {
                _selectedDistrict = value;
                _selectedDivisionalSecretariat = null;
                _selectedGramaNiladhariDivision = null;
              });
            },
          ),
          const SizedBox(height: 16),
          
          _buildDropdownField(
            value: _selectedDivisionalSecretariat,
            items: _selectedDistrict != null
                ? _locationData[_selectedDistrict]!.keys.toList()
                : [],
            label: 'Divisional Secretariat *',
            icon: Icons.business,
            onChanged: (value) {
              setState(() {
                _selectedDivisionalSecretariat = value;
                _selectedGramaNiladhariDivision = null;
              });
            },
          ),
          const SizedBox(height: 16),
          
          _buildDropdownField(
            value: _selectedGramaNiladhariDivision,
            items: _selectedDistrict != null && _selectedDivisionalSecretariat != null
                ? _locationData[_selectedDistrict]![_selectedDivisionalSecretariat]!
                : [],
            label: 'Grama Niladhari Division *',
            icon: Icons.location_city,
            onChanged: (value) {
              setState(() {
                _selectedGramaNiladhariDivision = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSetupStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Setup',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your secure password',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.muted,
            ),
          ),
          const SizedBox(height: 24),
          
          _buildTextField(
            controller: _passwordController,
            label: 'Password *',
            icon: Icons.lock,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _confirmPasswordController,
            label: 'Confirm Password *',
            icon: Icons.lock_outline,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    bool obscureText = false,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.muted),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.muted.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required List<String> items,
    required String label,
    required IconData icon,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.muted),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.muted.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}
