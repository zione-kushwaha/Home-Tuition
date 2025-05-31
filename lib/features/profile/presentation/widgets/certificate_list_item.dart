import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/certificate.dart';

/// Widget to display a certificate item in the profile
class CertificateListItem extends StatelessWidget {
  final Certificate certificate;

  const CertificateListItem({
    Key? key,
    required this.certificate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Certificate icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.card_membership,
                color: Colors.blue,
              ),
            ),
            
            const SizedBox(width: AppTheme.spacingMd),
            
            // Certificate details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Certificate name
                  Text(
                    certificate.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  
                  const SizedBox(height: AppTheme.spacingSm),
                  
                  // Issuing organization
                  Text(
                    certificate.issuingOrganization,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  
                  const SizedBox(height: AppTheme.spacingSm),
                  
                  // Issue date
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatDate(certificate.issueDate),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[700],
                            ),
                      ),
                    ],
                  ),
                  
                  // Expiry date (if any)
                  if (certificate.expiryDate != null) ...[
                    const SizedBox(height: AppTheme.spacingSm / 2),
                    Row(
                      children: [
                        Icon(
                          Icons.event_busy,
                          size: 16,
                          color: _isExpired(certificate.expiryDate!) 
                              ? Colors.red[700] 
                              : Colors.grey[700],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Expires: ${_formatDate(certificate.expiryDate!)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: _isExpired(certificate.expiryDate!) 
                                    ? Colors.red[700] 
                                    : Colors.grey[700],
                              ),
                        ),
                      ],
                    ),
                  ],
                  
                  // Credential ID (if any)
                  if (certificate.credentialId != null && certificate.credentialId!.isNotEmpty) ...[
                    const SizedBox(height: AppTheme.spacingSm),
                    Row(
                      children: [
                        Icon(
                          Icons.tag,
                          size: 16,
                          color: Colors.grey[700],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Credential ID: ${certificate.credentialId!}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                  
                  // Credential URL (if any)
                  if (certificate.credentialUrl != null && certificate.credentialUrl!.isNotEmpty) ...[
                    const SizedBox(height: AppTheme.spacingSm),
                    Row(
                      children: [
                        Icon(
                          Icons.link,
                          size: 16,
                          color: AppTheme.primaryColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Verify Certificate',
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            decoration: TextDecoration.underline,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  /// Format date
  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }
  
  /// Check if certificate is expired
  bool _isExpired(DateTime expiryDate) {
    return expiryDate.isBefore(DateTime.now());
  }
}
