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
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isEditing ? _buildEditProfile(context) : _buildMyProfile(context);
  }

  Widget _buildMyProfile(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final profileOptions = [
      {'icon': Icons.favorite_border, 'label': 'Favourites', 'color': Colors.red},
      {'icon': Icons.download, 'label': 'Downloads', 'color': Colors.blue},
      {'icon': Icons.language, 'label': 'Language', 'color': Colors.green},
      {'icon': Icons.location_on_outlined, 'label': 'Location', 'color': Colors.orange},
      {'icon': Icons.subscriptions, 'label': 'Subscription', 'color': Colors.purple},
      {'icon': Icons.cached, 'label': 'Clear cache', 'color': Colors.teal},
      {'icon': Icons.history, 'label': 'Clear history', 'color': Colors.indigo},
    ];

    return Scaffold(
      backgroundColor: isDark ? cs.surface : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? cs.surface : Colors.white,
        elevation: 0,
        title: Text(
          "My Profile",
          style: TextStyle(
            color: isDark ? cs.onSurface : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? cs.onSurface : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings_outlined,
              color: isDark ? cs.onSurface : Colors.black,
            ),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: cs.primary.withOpacity(0.1),
                  child: const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: cs.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: cs.primary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "Charlotte King",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDark ? cs.onSurface : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "@johnkinggraphics",
              style: TextStyle(
                color: isDark ? cs.onSurfaceVariant : Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: toggleEditMode,
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                elevation: 0,
              ),
              child: const Text("Edit Profile"),
            ),
            const SizedBox(height: 32),
            ...profileOptions.map((item) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark ? cs.surfaceVariant : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (item['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: item['color'] as Color,
                    ),
                  ),
                  title: Text(
                    item['label'] as String,
                    style: TextStyle(
                      color: isDark ? cs.onSurface : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: isDark ? cs.onSurfaceVariant : Colors.grey,
                  ),
                  onTap: () {
                    // Handle option tap
                  },
                ),
              );
            }).toList(),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                ),
                title: const Text(
                  "Log out",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  // Handle logout
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildEditProfile(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? cs.surface : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? cs.surface : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? cs.onSurface : Colors.black,
          ),
          onPressed: toggleEditMode,
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: isDark ? cs.onSurface : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: toggleEditMode,
            child: Text(
              "Save",
              style: TextStyle(
                color: cs.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: cs.primary.withOpacity(0.1),
                  child: const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: cs.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: cs.primary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildInputField(
              label: "Name",
              initial: "Charlotte King",
              icon: Icons.person_outline,
            ),
            _buildInputField(
              label: "Email address",
              initial: "johnkinggraphics@gmail.com",
              icon: Icons.email_outlined,
            ),
            _buildInputField(
              label: "Username",
              initial: "@johnkinggraphics",
              icon: Icons.alternate_email,
            ),
            _buildPasswordField(),
            _buildInputField(
              label: "Phone number",
              initial: "+91 6895312",
              icon: Icons.phone_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    String? initial,
    IconData? icon,
  }) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isDark ? cs.onSurfaceVariant : Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initial,
          decoration: InputDecoration(
            prefixIcon: icon != null ? Icon(icon, color: cs.primary) : null,
            filled: true,
            fillColor: isDark ? cs.surfaceVariant : Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: cs.primary, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPasswordField() {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Password",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: obscurePassword,
          initialValue: "password123",
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_outline, color: cs.primary),
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: cs.primary,
              ),
              onPressed: () {
                setState(() => obscurePassword = !obscurePassword);
              },
            ),
            filled: true,
            fillColor: isDark ? cs.surfaceVariant : Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: cs.primary, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
