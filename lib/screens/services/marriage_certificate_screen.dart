import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/api_service.dart';
import '../../utils/theme.dart';

class MarriageCertificateScreen extends StatefulWidget {
  const MarriageCertificateScreen({super.key});

  @override
  State<MarriageCertificateScreen> createState() =>
      _MarriageCertificateScreenState();
}

class _MarriageCertificateScreenState extends State<MarriageCertificateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _applicantNameController = TextEditingController();
  final _spouseNameController = TextEditingController();
  final _marriagePlaceController = TextEditingController();
  final _applicantNicController = TextEditingController();
  final _spouseNicController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _addressController = TextEditingController();
  DateTime? _marriageDate;
  bool _isLoading = false;

  @override
  void dispose() {
    _applicantNameController.dispose();
    _spouseNameController.dispose();
    _marriagePlaceController.dispose();
    _applicantNicController.dispose();
    _spouseNicController.dispose();
    _contactNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text(
          'Marriage Certificate',
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
                    'Marriage Certificate Application',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Apply for an official marriage certificate',
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
                    label: 'Applicant Full Name',
                    icon: Icons.person,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Applicant name is required'
                        : null,
                  ),
                  _buildTextField(
                    controller: _applicantNicController,
                    label: 'Applicant NIC Number',
                    icon: Icons.credit_card,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Applicant NIC is required'
                        : null,
                  ),

                  const SizedBox(height: 20),

                  // Spouse Details Section
                  _buildSectionHeader('Spouse Details'),
                  _buildTextField(
                    controller: _spouseNameController,
                    label: 'Spouse Full Name',
                    icon: Icons.person,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Spouse name is required'
                        : null,
                  ),
                  _buildTextField(
                    controller: _spouseNicController,
                    label: 'Spouse NIC Number',
                    icon: Icons.credit_card,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Spouse NIC is required'
                        : null,
                  ),

                  const SizedBox(height: 20),

                  // Marriage Details Section
                  _buildSectionHeader('Marriage Details'),
                  _buildDateField(),
                  _buildTextField(
                    controller: _marriagePlaceController,
                    label: 'Place of Marriage',
                    icon: Icons.location_on,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Marriage place is required'
                        : null,
                  ),

                  const SizedBox(height: 20),

                  // Contact Information Section
                  _buildSectionHeader('Contact Information'),
                  _buildTextField(
                    controller: _contactNumberController,
                    label: 'Contact Number (Optional)',
                    icon: Icons.phone,
                  ),
                  _buildTextField(
                    controller: _addressController,
                    label: 'Address (Optional)',
                    icon: Icons.home,
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
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
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

  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColors.primary,
                    onPrimary: Colors.white,
                    surface: Colors.white,
                    onSurface: Colors.black,
                  ),
                ),
                child: child!,
              );
            },
          );
          if (date != null) {
            setState(() {
              _marriageDate = date;
            });
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.calendar_today, color: Colors.grey[600]),
              const SizedBox(width: 12),
              Text(
                _marriageDate == null
                    ? 'Select Marriage Date'
                    : '${_marriageDate!.day}/${_marriageDate!.month}/${_marriageDate!.year}',
                style: TextStyle(
                  color:
                      _marriageDate == null ? Colors.grey[600] : Colors.black87,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitApplication() async {
    if (_formKey.currentState!.validate() && _marriageDate != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final token = authProvider.token;

        if (token == null) {
          throw Exception('Not authenticated');
        }

        final applicationData = {
          'applicantName': _applicantNameController.text.trim(),
          'spouseName': _spouseNameController.text.trim(),
          'marriageDate': _marriageDate!
              .toIso8601String()
              .split('T')[0], // YYYY-MM-DD format
          'marriagePlace': _marriagePlaceController.text.trim(),
          'applicantNIC': _applicantNicController.text.trim(),
          'spouseNIC': _spouseNicController.text.trim(),
          'contactNumber': _contactNumberController.text.trim(),
          'address': _addressController.text.trim(),
        };

        final response = await ApiService.submitMarriageCertificate(
          token: token,
          applicationData: applicationData,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Application submitted successfully! Application ID: ${response['application_id']}'),
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
          content:
              Text('Please fill all required fields and select marriage date'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }
}
