import 'package:flutter/material.dart';
import '../../utils/app_localizations.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    // Mock announcements data
    final announcements = [
      {
        'id': '1',
        'title': 'New Service Available',
        'content':
            'Online birth certificate service is now available. You can apply for birth certificates through our mobile app.',
        'date': '2024-01-15',
        'category': 'Services',
        'priority': 'high',
      },
      {
        'id': '2',
        'title': 'Office Hours Update',
        'content':
            'Please note that our office hours have been updated. New hours: Monday to Friday, 8:00 AM to 4:00 PM.',
        'date': '2024-01-12',
        'category': 'General',
        'priority': 'medium',
      },
      {
        'id': '3',
        'title': 'Holiday Notice',
        'content':
            'The office will be closed on January 20th for the national holiday. Emergency services will be available.',
        'date': '2024-01-10',
        'category': 'Holiday',
        'priority': 'medium',
      },
      {
        'id': '4',
        'title': 'Community Meeting',
        'content':
            'Monthly community meeting will be held on January 25th at 3:00 PM at the community center. All residents are invited.',
        'date': '2024-01-08',
        'category': 'Community',
        'priority': 'low',
      },
      {
        'id': '5',
        'title': 'Road Maintenance Notice',
        'content':
            'Road maintenance work will be carried out on Main Street from January 18th to January 22nd. Please use alternative routes.',
        'date': '2024-01-05',
        'category': 'Infrastructure',
        'priority': 'high',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations?.announcements ?? 'Announcements'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Handle filter
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: announcements.length,
        itemBuilder: (context, index) {
          final announcement = announcements[index];
          return _AnnouncementCard(
            title: announcement['title']!,
            content: announcement['content']!,
            date: announcement['date']!,
            category: announcement['category']!,
            priority: announcement['priority']!,
          );
        },
      ),
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  final String title;
  final String content;
  final String date;
  final String category;
  final String priority;

  const _AnnouncementCard({
    required this.title,
    required this.content,
    required this.date,
    required this.category,
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with priority indicator and date
            Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: _getPriorityColor(priority),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Text(
                  _formatDate(date),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Category chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getCategoryColor(category).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: _getCategoryColor(category),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Content
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),

            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.share, size: 16),
                  label: const Text('Share'),
                  onPressed: () {
                    // Handle share
                  },
                ),
                TextButton.icon(
                  icon: const Icon(Icons.bookmark_outline, size: 16),
                  label: const Text('Save'),
                  onPressed: () {
                    // Handle save
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Services':
        return Colors.blue;
      case 'General':
        return Colors.grey;
      case 'Holiday':
        return Colors.purple;
      case 'Community':
        return Colors.green;
      case 'Infrastructure':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return '1 day ago';
    } else {
      return '$difference days ago';
    }
  }
}
