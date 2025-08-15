import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';  // Commented out temporarily
import '../../providers/auth_provider.dart';
import '../../services/api_service.dart';

class ContactGramaNiladhariScreen extends StatefulWidget {
  const ContactGramaNiladhariScreen({super.key});

  @override
  State<ContactGramaNiladhariScreen> createState() => _ContactGramaNiladhariScreenState();
}

class _ContactGramaNiladhariScreenState extends State<ContactGramaNiladhariScreen> {
  List<Map<String, dynamic>> _officials = [];
  bool _isLoading = true;
  String? _errorMessage;
  String _selectedDistrict = 'Colombo'; // Default district
  final _searchController = TextEditingController();

  final List<String> _sriLankanDistricts = [
    'Colombo', 'Gampaha', 'Kalutara', 'Kandy', 'Matale', 'Nuwara Eliya',
    'Galle', 'Matara', 'Hambantota', 'Jaffna', 'Kilinochchi', 'Mannar',
    'Mullaitivu', 'Vavuniya', 'Puttalam', 'Kurunegala', 'Anuradhapura',
    'Polonnaruwa', 'Badulla', 'Monaragala', 'Ratnapura', 'Kegalle',
    'Ampara', 'Batticaloa', 'Trincomalee'
  ];

  @override
  void initState() {
    super.initState();
    _loadOfficials();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadOfficials() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final user = authProvider.user;

      if (user?.token == null) {
        throw Exception('User not authenticated');
      }

      final officials = await ApiService.getGramaNiladhariByDistrict(
        token: user!.token!,
        district: _selectedDistrict,
      );

      setState(() {
        _officials = officials;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _searchOfficials() async {
    if (_searchController.text.trim().isEmpty) {
      _loadOfficials();
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final user = authProvider.user;

      if (user?.token == null) {
        throw Exception('User not authenticated');
      }

      final officials = await ApiService.searchGramaNiladhari(
        token: user!.token!,
        district: _selectedDistrict,
        division: _searchController.text.trim(),
      );

      setState(() {
        _officials = officials;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    // Temporarily disabled url_launcher functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Phone: $phoneNumber (Click to call functionality will be added)')),
    );
    
    /* Original code with url_launcher:
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch phone call to $phoneNumber')),
        );
      }
    }
    */
  }

  Future<void> _sendEmail(String email) async {
    // Temporarily disabled url_launcher functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Email: $email (Click to email functionality will be added)')),
    );
    
    /* Original code with url_launcher:
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch email to $email')),
        );
      }
    }
    */
  }

  void _showOfficialDetails(Map<String, dynamic> official) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(official['name'] ?? 'Official Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDetailRow('Designation', official['designation']),
                _buildDetailRow('Employee ID', official['employee_id']),
                const SizedBox(height: 8),
                _buildDetailRow('District', official['district']),
                _buildDetailRow('Division', official['grama_niladhari_division']),
                _buildDetailRow('Secretariat', official['divisional_secretariat']),
                const SizedBox(height: 8),
                _buildDetailRow('Office Address', official['office_address']),
                _buildDetailRow('Office Hours', official['office_hours']),
                if (official['lunch_break'] != null)
                  _buildDetailRow('Lunch Break', official['lunch_break']),
                const SizedBox(height: 8),
                if (official['languages_spoken'] != null && 
                    (official['languages_spoken'] as List).isNotEmpty)
                  _buildDetailRow('Languages', 
                    (official['languages_spoken'] as List).join(', ')),
                const SizedBox(height: 8),
                if (official['services_provided'] != null && 
                    (official['services_provided'] as List).isNotEmpty) ...[
                  const Text(
                    'Services Provided:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  ...(official['services_provided'] as List).map(
                    (service) => Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text('• $service'),
                    ),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black87),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
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
        title: const Text('Contact Grama Niladhari'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                // District Selection
                DropdownButtonFormField<String>(
                  value: _selectedDistrict,
                  decoration: const InputDecoration(
                    labelText: 'Select District',
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(),
                  ),
                  items: _sriLankanDistricts.map((district) {
                    return DropdownMenuItem(
                      value: district,
                      child: Text(district),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedDistrict = value;
                      });
                      _loadOfficials();
                    }
                  },
                ),
                const SizedBox(height: 12),
                // Search Field
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search by Division Name',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _loadOfficials();
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _searchOfficials(),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _searchOfficials,
                    child: const Text('Search'),
                  ),
                ),
              ],
            ),
          ),

          // Content Section
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, size: 64, color: Colors.red),
                            const SizedBox(height: 16),
                            Text(
                              'Error loading officials',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 8),
                            Text(_errorMessage!),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _loadOfficials,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : _officials.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.person_search, size: 64, color: Colors.grey),
                                const SizedBox(height: 16),
                                Text(
                                  'No officials found',
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(height: 8),
                                Text('Try selecting a different district or search term'),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: _officials.length,
                            itemBuilder: (context, index) {
                              final official = _officials[index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                                    child: Icon(
                                      Icons.person,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  title: Text(
                                    official['name'] ?? 'Unknown Official',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(official['grama_niladhari_division'] ?? ''),
                                      Text(
                                        '${official['divisional_secretariat']}, ${official['district']}',
                                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          if (official['office_phone'] != null) ...[
                                            InkWell(
                                              onTap: () => _makePhoneCall(official['office_phone']),
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue.withOpacity(0.1),
                                                  borderRadius: BorderRadius.circular(12),
                                                  border: Border.all(color: Colors.blue.withOpacity(0.3)),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Icon(Icons.phone, size: 16, color: Colors.blue),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      official['office_phone'],
                                                      style: const TextStyle(fontSize: 12, color: Colors.blue),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                          ],
                                          if (official['mobile'] != null) ...[
                                            InkWell(
                                              onTap: () => _makePhoneCall(official['mobile']),
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: Colors.green.withOpacity(0.1),
                                                  borderRadius: BorderRadius.circular(12),
                                                  border: Border.all(color: Colors.green.withOpacity(0.3)),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Icon(Icons.smartphone, size: 16, color: Colors.green),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      official['mobile'],
                                                      style: const TextStyle(fontSize: 12, color: Colors.green),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: PopupMenuButton<String>(
                                    onSelected: (value) {
                                      switch (value) {
                                        case 'details':
                                          _showOfficialDetails(official);
                                          break;
                                        case 'email':
                                          if (official['email'] != null) {
                                            _sendEmail(official['email']);
                                          }
                                          break;
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
                                        value: 'details',
                                        child: Row(
                                          children: [
                                            Icon(Icons.info_outline),
                                            SizedBox(width: 8),
                                            Text('View Details'),
                                          ],
                                        ),
                                      ),
                                      if (official['email'] != null)
                                        const PopupMenuItem(
                                          value: 'email',
                                          child: Row(
                                            children: [
                                              Icon(Icons.email_outlined),
                                              SizedBox(width: 8),
                                              Text('Send Email'),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                  isThreeLine: true,
                                  onTap: () => _showOfficialDetails(official),
                                ),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
