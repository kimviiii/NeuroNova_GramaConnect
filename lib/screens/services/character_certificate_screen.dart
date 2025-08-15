import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/api_service.dart';
import '../../utils/theme.dart';

class CharacterCertificateScreen extends StatefulWidget {
  const CharacterCertificateScreen({super.key});

  @override
  State<CharacterCertificateScreen> createState() =>
      _CharacterCertificateScreenState();
}

class _CharacterCertificateScreenState
    extends State<CharacterCertificateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _applicantNameController = TextEditingController();
  final _nicNumberController = TextEditingController();
  final _purposeController = TextEditingController();
  final _employmentDetailsController = TextEditingController();
  final _residenceAddressController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _periodOfResidenceController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _applicantNameController.dispose();
    _nicNumberController.dispose();
    _purposeController.dispose();
    _employmentDetailsController.dispose();
    _residenceAddressController.dispose();
    _contactNumberController.dispose();
    _periodOfResidenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text(
          'Character Certificate',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset(
                'assets/images/logo.png',
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Card(
            color: Colors.white,
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Character Certificate Application',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Apply for an official character certificate (police clearance)',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Applicant Details Section
                  _buildSectionHeader('Applicant Details'),
                  _buildTextField(
                    controller: _applicantNameController,
                    label: 'Full Name',
                    icon: Icons.person,
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Full name is required' : null,
                  ),
                  _buildTextField(
                    controller: _nicNumberController,
                    label: 'NIC Number',
                    icon: Icons.credit_card,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'NIC number is required'
                        : null,
                  ),
                  _buildTextField(
                    controller: _contactNumberController,
                    label: 'Contact Number',
                    icon: Icons.phone,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Contact number is required'
                        : null,
                  ),

                  const SizedBox(height: 20),

                  // Purpose Section
                  _buildSectionHeader('Purpose of Certificate'),
                  _buildTextField(
                    controller: _purposeController,
                    label: 'Purpose (e.g., Employment, Immigration, Education)',
                    icon: Icons.work,
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Purpose is required' : null,
                  ),
                  _buildTextField(
                    controller: _employmentDetailsController,
                    label: 'Employment/Purpose Details (Optional)',
                    icon: Icons.description,
                    maxLines: 2,
                  ),

                  const SizedBox(height: 20),

                  // Residence Information Section
                  _buildSectionHeader('Residence Information'),
                  _buildTextField(
                    controller: _residenceAddressController,
                    label: 'Current Residence Address',
                    icon: Icons.home,
                    maxLines: 2,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Current address is required'
                        : null,
                  ),
                  _buildTextField(
                    controller: _periodOfResidenceController,
                    label: 'Period of Residence (e.g., 5 years)',
                    icon: Icons.calendar_today,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Period of residence is required'
                        : null,
                  ),

                  const SizedBox(height: 40),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _submitApplication,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Submit Application',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.black87, fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.grey[600]),
          labelStyle: TextStyle(color: Colors.grey[600]),
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.accent, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        validator: validator,
      ),
    );
  }

  void _submitApplication() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final token = authProvider.token;

        print('🔍 Debug: Token available: ${token != null}');
        print('🔍 Debug: User authenticated: ${authProvider.isAuthenticated}');

        if (token == null) {
          throw Exception('Not authenticated');
        }

        final applicationData = {
          'applicantName': _applicantNameController.text.trim(),
          'nicNumber': _nicNumberController.text.trim(),
          'purpose': _purposeController.text.trim(),
          'employmentDetails': _employmentDetailsController.text.trim(),
          'residenceAddress': _residenceAddressController.text.trim(),
          'contactNumber': _contactNumberController.text.trim(),
          'periodOfResidence': _periodOfResidenceController.text.trim(),
        };

        print(
            '🔍 Submitting character certificate application: $applicationData');

        final response = await ApiService.submitCharacterCertificate(
          token: token,
          applicationData: applicationData,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Application submitted successfully! Reference: ${response['reference_number']}'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 4),
            ),
          );

          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Error: ${e.toString().replaceAll('Exception: ', '')}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }
}
