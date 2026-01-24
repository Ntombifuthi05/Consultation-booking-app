import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingTableRow extends StatelessWidget {
  final QueryDocumentSnapshot booking;
  final VoidCallback onDelete;

  const BookingTableRow({required this.booking, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(booking['topic']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Student: ${booking['studentId']}'),
            Text('Date: ${DateFormat('MMM dd, yyyy').format(
              (booking['date'] as Timestamp).toDate())}'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}