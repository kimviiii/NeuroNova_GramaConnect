import 'package:flutter/material.dart';
import '../../utils/app_localizations.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({super.key});

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations?.complaints ?? 'Complaints'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
                text: localizations?.translate('submit_complaint') ??
                    'Submit Complaint'),
            Tab(
                text: localizations?.translate('my_applications') ??
                    'My Complaints'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const SubmitComplaintTab(),
          const MyComplaintsTab(),
        ],
      ),
    );
  }
}

class SubmitComplaintTab extends StatefulWidget {
  const SubmitComplaintTab({super.key});

  @override
  State<SubmitComplaintTab> createState() => _SubmitComplaintTabState();
}

class _SubmitComplaintTabState extends State<SubmitComplaintTab> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCategory = 'Infrastructure';

  final List<String> _categories = [
    'Infrastructure',
    'Water Supply',
    'Waste Management',
    'Street Lighting',
    'Road Maintenance',
    'Other',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitComplaint() async {
    if (_formKey.currentState!.validate()) {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Close loading dialog
      if (mounted) {
        Navigator.pop(context);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Complaint submitted successfully'),
            backgroundColor: Colors.green,
          ),
        );

        // Clear form
        _titleController.clear();
        _descriptionController.clear();
        setState(() {
          _selectedCategory = 'Infrastructure';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Category Dropdown
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                prefixIcon: Icon(Icons.category_outlined),
              ),
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),

            // Title Field
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: localizations?.complaintTitle ?? 'Complaint Title',
                prefixIcon: const Icon(Icons.title_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localizations?.fieldRequired ??
                      'This field is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Description Field
            TextFormField(
              controller: _descriptionController,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: localizations?.complaintDescription ?? 'Description',
                prefixIcon: const Icon(Icons.description_outlined),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localizations?.fieldRequired ??
                      'This field is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Submit Button
            ElevatedButton(
              onPressed: _submitComplaint,
              child: Text(localizations?.submit ?? 'Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyComplaintsTab extends StatelessWidget {
  const MyComplaintsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    // Mock complaints data
    final complaints = [
      {
        'id': 'C001',
        'title': 'Road Damage on Main Street',
        'status': 'pending',
        'date': '2024-01-15',
        'category': 'Infrastructure',
      },
      {
        'id': 'C002',
        'title': 'Street Light Not Working',
        'status': 'in_progress',
        'date': '2024-01-10',
        'category': 'Street Lighting',
      },
      {
        'id': 'C003',
        'title': 'Water Supply Issue',
        'status': 'resolved',
        'date': '2024-01-05',
        'category': 'Water Supply',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: complaints.length,
      itemBuilder: (context, index) {
        final complaint = complaints[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  _getStatusColor(complaint['status']!).withOpacity(0.2),
              child: Icon(
                _getStatusIcon(complaint['status']!),
                color: _getStatusColor(complaint['status']!),
              ),
            ),
            title: Text(complaint['title']!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID: ${complaint['id']}'),
                Text('Category: ${complaint['category']}'),
                Text('Date: ${complaint['date']}'),
              ],
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(complaint['status']!).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _getStatusText(complaint['status']!, localizations),
                style: TextStyle(
                  color: _getStatusColor(complaint['status']!),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'in_progress':
        return Colors.blue;
      case 'resolved':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'pending':
        return Icons.schedule;
      case 'in_progress':
        return Icons.work;
      case 'resolved':
        return Icons.check_circle;
      default:
        return Icons.info;
    }
  }

  String _getStatusText(String status, AppLocalizations? localizations) {
    switch (status) {
      case 'pending':
        return localizations?.complaintPending ?? 'Pending';
      case 'in_progress':
        return localizations?.complaintInProgress ?? 'In Progress';
      case 'resolved':
        return localizations?.complaintResolved ?? 'Resolved';
      default:
        return status;
    }
  }
}
