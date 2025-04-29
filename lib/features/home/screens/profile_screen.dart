import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  bool obscurePassword = true;

  void toggleEditMode() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isEditing ? _buildEditProfile(context) : _buildMyProfile(context);
  }

  Widget _buildMyProfile(BuildContext context) {
    final profileOptions = [
      {'icon': Icons.favorite_border, 'label': 'Favourites'},
      {'icon': Icons.download, 'label': 'Downloads'},
      {'icon': Icons.language, 'label': 'Language'},
      {'icon': Icons.location_on_outlined, 'label': 'Location'},
      {'icon': Icons.subscriptions, 'label': 'Subscription'},
      {'icon': Icons.cached, 'label': 'Clear cache'},
      {'icon': Icons.history, 'label': 'Clear history'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("My Profile", style: TextStyle(color: Colors.black)),
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.settings, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/images/avatar.jpg'),
          ),
          const SizedBox(height: 8),
          const Text("Charlotte King", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const Text("@johnkinggraphics", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: toggleEditMode,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            ),
            child: const Text("Edit Profile"),
          ),
          const SizedBox(height: 20),
          ...profileOptions.map((item) {
            return ListTile(
              leading: Icon(item['icon'] as IconData, color: Colors.black),
              title: Text(item['label'] as String),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              onTap: () {},
            );
          }).toList(),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Log out", style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildEditProfile(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: toggleEditMode,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.green),
            onPressed: toggleEditMode,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
            const SizedBox(height: 20),
            _buildInputField(label: "Name", initial: "Charlotte King"),
            _buildInputField(label: "E mail address", initial: "johnkinggraphics@gmail.com"),
            _buildInputField(label: "User name", initial: "@johnkinggraphics"),
            _buildPasswordField(),
            _buildInputField(label: "Phone number", initial: "+91 6895312"),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({required String label, String? initial}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: initial,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF4F5F7),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Password"),
        const SizedBox(height: 6),
        TextFormField(
          obscureText: obscurePassword,
          initialValue: "password123",
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF4F5F7),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            suffixIcon: IconButton(
              icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() => obscurePassword = !obscurePassword);
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
