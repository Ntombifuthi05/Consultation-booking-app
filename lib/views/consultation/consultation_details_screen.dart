import 'package:consultation/models/consultation_model.dart';
import 'package:consultation/viewmodels/consultation_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ConsultationDetailsScreen extends StatelessWidget {
  final Consultation consultation;

  const ConsultationDetailsScreen({Key? key, required this.consultation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, yyyy');
    final timeFormat = DateFormat('h:mm a');

    return Scaffold(
      appBar: AppBar(title: const Text('Consultation Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              consultation.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'With ${consultation.lecturer}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(height: 32),
            Text(
              'Date: ${dateFormat.format(consultation.date)}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Time: ${timeFormat.format(consultation.date)}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Divider(height: 32),
            Text(
              'Description:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(consultation.description),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                await Provider.of<ConsultationViewModel>(context, listen: false)
                    .deleteConsultation(consultation.id);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Cancel Consultation'),
            ),
          ],
        ),
      ),
    );
  }
}