import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override

  Widget build(BuildContext context)
{
    // Example data - you can replace these with dynamic values.
    const String imageUrl =
        '../image/ProfileImage.JPG'; // placeholder
    const String name = 'John kathayat';
    const String email = 'somethingkathayat@gmail.com';
    const String phone = '+977 9801234567';

    return SizedBox(
      height:700,
      width: 400,
      child: Card(
        elevation: 5,
        margin:const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child:Padding(padding: const EdgeInsets.all(16.0),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
         CircleAvatar(
          radius: 48,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          backgroundImage: const NetworkImage(imageUrl),
         ),
         const SizedBox(height: 12), 
         Text(
          name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
         const SizedBox(height: 6),
          const Divider(),
          const SizedBox(height: 10),
          const InfoRow(icon:Icons.email, label:email),
          const SizedBox(height: 10),  
          InfoRow(icon:Icons.phone, label:phone),    
          const SizedBox(height: 10),
          InfoRow(icon:Icons.location_city_rounded , label:"Butwal 12, Rupandehi, Nepal"),
          
        ],
        )
        )
        ),
    );
      
}
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const InfoRow({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 18,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}








