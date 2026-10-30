import 'package:flutter/material.dart';

void main() => runApp(ShofeRiderApp());

class ShofeRiderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shofe Rider',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xFF14532d)),
      home: ShofeHome(),
    );
  }
}

class ShofeHome extends StatelessWidget {
  final List services = [
    {"title": "Chauffeur Ride", "subtitle": "Premium rides", "icon": Icons.car_rental, "color": Color(0xFF14532d), "type": "chauffeur"},
    {"title": "Berries Car Wash", "subtitle": "In-store wash at Berries", "icon": Icons.local_car_wash, "color": Colors.blue, "type": "berries"},
    {"title": "Berryz Mobile Carwash", "subtitle": "We come to you - anywhere in Harare", "icon": Icons.delivery_dining, "color": Colors.black, "type": "berryz_mobile"},
    {"title": "Moto Beverages", "subtitle": "Drinks delivered", "icon": Icons.local_drink, "color": Colors.orange, "type": "moto"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shofe Rider - by Blingberry"), backgroundColor: Color(0xFF14532d), foregroundColor: Colors.white),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text("What do you need today?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          ...services.map((s) => Card(
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(backgroundColor: s["color"], child: Icon(s["icon"], color: Colors.white)),
              title: Text(s["title"], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(s["subtitle"]),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ServiceDetailPage(service: s)));
              },
            ),
          )).toList(),
        ],
      ),
    );
  }
}

class ServiceDetailPage extends StatefulWidget {
  final Map service;
  const ServiceDetailPage({required this.service});
  @override
  State<ServiceDetailPage> createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  String selectedPackage = "Full Wash + Interior - \$10";
  
  @override
  Widget build(BuildContext context) {
    bool isMobile = widget.service["type"] == "berryz_mobile";
    
    return Scaffold(
      appBar: AppBar(title: Text(widget.service["title"]), backgroundColor: widget.service["color"], foregroundColor: Colors.white),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(isMobile)
              Container(
                padding: EdgeInsets.all(12),
                color: Colors.yellow.shade100,
                child: Row(children: [Icon(Icons.info), SizedBox(width:8), Expanded(child: Text("Berryz Mobile team will come to your location with water tank & vacuum"))]),
              ),
            SizedBox(height: 16),
            Text("Choose Package:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            RadioListTile(value: "Exterior Only - \$5", groupValue: selectedPackage, onChanged: (v)=>setState(()=>selectedPackage=v!), title: Text("Exterior Only - \$5 (15 mins)")),
            RadioListTile(value: "Full Wash + Interior - \$10", groupValue: selectedPackage, onChanged: (v)=>setState(()=>selectedPackage=v!), title: Text("Full Wash + Interior - \$10 (30 mins)")),
            RadioListTile(value: "Premium Detail - \$25", groupValue: selectedPackage, onChanged: (v)=>setState(()=>selectedPackage=v!), title: Text("Premium Detail - \$25 (1 hour)")),
            Spacer(),
            if(isMobile)
              TextField(decoration: InputDecoration(labelText: "Your car location (e.g., Avondale, 17 Smith Road)", border: OutlineInputBorder())),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: widget.service["color"], padding: EdgeInsets.all(16)),
                onPressed: (){
                  // TODO: Connect to your Shofe backend / WhatsApp
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Booked $selectedPackage via ${widget.service["title"]}")));
                },
                child: Text(isMobile ? "BOOK MOBILE TEAM NOW" : "BOOK NOW", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
