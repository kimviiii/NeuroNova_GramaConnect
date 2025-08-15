import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/api_service.dart';

class VoterRegistrationScreen extends StatefulWidget {
  const VoterRegistrationScreen({super.key});

  @override
  State<VoterRegistrationScreen> createState() => _VoterRegistrationScreenState();
}

class _VoterRegistrationScreenState extends State<VoterRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Form controllers
  final _applicantNameController = TextEditingController();
  final _nicNumberController = TextEditingController();
  final _currentAddressController = TextEditingController();
  final _newAddressController = TextEditingController();
  final _currentPollingDivisionController = TextEditingController();
  final _newPollingDivisionController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _reasonForChangeController = TextEditingController();

  // Update type selection
  String _selectedUpdateType = '';
  final List<Map<String, String>> _updateTypes = [
    {'value': 'address_change', 'label': 'Address Change'},
    {'value': 'personal_details', 'label': 'Personal Details Update'},
    {'value': 'polling_division_transfer', 'label': 'Polling Division Transfer'},
    {'value': 'contact_information', 'label': 'Contact Information Update'},
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.user;
    if (user != null) {
      _applicantNameController.text = user.name;
      _nicNumberController.text = user.nic ?? '';
      _contactNumberController.text = user.phone ?? '';
    }
  }

  @override
  void dispose() {
    _applicantNameController.dispose();
    _nicNumberController.dispose();
    _currentAddressController.dispose();
    _newAddressController.dispose();
    _currentPollingDivisionController.dispose();
    _newPollingDivisionController.dispose();
    _contactNumberController.dispose();
    _reasonForChangeController.dispose();
    super.dispose();
  }

  Future<void> _submitApplication() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedUpdateType.isEmpty) {
      _showErrorDialog('Please select an update type');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final user = authProvider.user;

      if (user?.token == null) {
        throw Exception('User not authenticated');
      }

      final applicationData = {
        'applicantName': _applicantNameController.text.trim(),
        'nicNumber': _nicNumberController.text.trim(),
        'updateType': _selectedUpdateType,
        'currentAddress': _currentAddressController.text.trim(),
        'newAddress': _newAddressController.text.trim(),
        'currentPollingDivision': _currentPollingDivisionController.text.trim(),
        'newPollingDivision': _newPollingDivisionController.text.trim(),
        'contactNumber': _contactNumberController.text.trim(),
        'reasonForChange': _reasonForChangeController.text.trim(),
      };

      print('🔍 Submitting voter registration application: $applicationData');

      final result = await ApiService.submitVoterRegistration(
        token: user!.token!,
        applicationData: applicationData,
      );

      if (mounted) {
        _showSuccessDialog(result);
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog(e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSuccessDialog(Map<String, dynamic> result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
          title: const Text('Application Submitted Successfully'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(result['message'] ?? 'Your voter registration update application has been submitted successfully.'),
              const SizedBox(height: 16),
              if (result['reference_number'] != null) ...[
                Text(
                  'Reference Number: ${result['reference_number']}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
              ],
              if (result['estimated_processing_time'] != null)
                Text('Estimated Processing Time: ${result['estimated_processing_time']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Return to services screen
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.error, color: Colors.red, size: 48),
          title: const Text('Submission Failed'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'assets/images/logo.png',
            width: 48,
            height: 48,
            fit: BoxFit.contain,
          ),
        ),
        title: const Text('Voter Registration Update'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Card
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.how_to_vote_outlined, 
                                     color: Theme.of(context).primaryColor, size: 32),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Voter Registration Update',
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Update your voter registration details',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.blue.withOpacity(0.3)),
                              ),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Service Details:',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Text('• Service Fee: Free'),
                                  Text('• Processing Time: 7-14 working days'),
                                  Text('• Required Documents: Valid NIC, Proof of address'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Applicant Information
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Applicant Information',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _applicantNameController,
                              decoration: const InputDecoration(
                                labelText: 'Full Name *',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Full name is required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _nicNumberController,
                              decoration: const InputDecoration(
                                labelText: 'NIC Number *',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.badge),
                                hintText: 'e.g., 123456789V or 123456789012',
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'NIC number is required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _contactNumberController,
                              decoration: const InputDecoration(
                                labelText: 'Contact Number',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.phone),
                                hintText: 'e.g., 0771234567',
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Update Type Selection
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Update Type *',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            ..._updateTypes.map((type) {
                              return RadioListTile<String>(
                                title: Text(type['label']!),
                                value: type['value']!,
                                groupValue: _selectedUpdateType,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedUpdateType = value!;
                                  });
                                },
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Address Information (shown when relevant)
                    if (_selectedUpdateType == 'address_change' || 
                        _selectedUpdateType == 'polling_division_transfer') ...[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Address Information',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _currentAddressController,
                                decoration: const InputDecoration(
                                  labelText: 'Current Address *',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.location_on),
                                ),
                                maxLines: 2,
                                validator: (value) {
                                  if ((_selectedUpdateType == 'address_change' || 
                                       _selectedUpdateType == 'polling_division_transfer') &&
                                      (value == null || value.trim().isEmpty)) {
                                    return 'Current address is required';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _newAddressController,
                                decoration: const InputDecoration(
                                  labelText: 'New Address *',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.home),
                                ),
                                maxLines: 2,
                                validator: (value) {
                                  if ((_selectedUpdateType == 'address_change' || 
                                       _selectedUpdateType == 'polling_division_transfer') &&
                                      (value == null || value.trim().isEmpty)) {
                                    return 'New address is required';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Polling Division Information (shown when relevant)
                    if (_selectedUpdateType == 'polling_division_transfer') ...[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Polling Division Information',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _currentPollingDivisionController,
                                decoration: const InputDecoration(
                                  labelText: 'Current Polling Division *',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.location_city),
                                ),
                                validator: (value) {
                                  if (_selectedUpdateType == 'polling_division_transfer' &&
                                      (value == null || value.trim().isEmpty)) {
                                    return 'Current polling division is required';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _newPollingDivisionController,
                                decoration: const InputDecoration(
                                  labelText: 'New Polling Division *',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.how_to_vote),
                                ),
                                validator: (value) {
                                  if (_selectedUpdateType == 'polling_division_transfer' &&
                                      (value == null || value.trim().isEmpty)) {
                                    return 'New polling division is required';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Reason for Change
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Additional Information',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _reasonForChangeController,
                              decoration: const InputDecoration(
                                labelText: 'Reason for Change',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.notes),
                                hintText: 'Please explain why you need to update your voter registration',
                              ),
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submitApplication,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text(
                                'Submit Application',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Disclaimer
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Note: Please ensure all information provided is accurate. '
                        'False information may result in rejection of your application and legal consequences.',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
