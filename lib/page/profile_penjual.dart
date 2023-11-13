import 'package:flutter/material.dart';
import 'package:solusi_penjualan_pangan/model/user.dart';

class UserDetailView extends StatelessWidget {
  const UserDetailView({Key? key});

  @override
  Widget build(BuildContext context) {
    // Simulate fetching user details (replace this with your actual logic)
    final staticUser = getStaticUser();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: const Color(0xFF22692D),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text('Profile',
                    style: TextStyle(fontSize: 32, color: Colors.white)),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(staticUser.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  staticUser.nama,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    TextField(
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Masukkan email',
                      ),
                      controller: TextEditingController(text: staticUser.email),
                      onChanged: (value) {
                        staticUser.email = value;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Role',
                        hintText: 'Masukkan role',
                      ),
                      controller: TextEditingController(text: staticUser.role),
                      onChanged: (value) {
                        staticUser.role = value;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Alamat',
                        hintText: 'Masukkan alamat',
                      ),
                      controller:
                          TextEditingController(text: staticUser.alamat),
                      onChanged: (value) {
                        staticUser.alamat = value;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'No. Handphone',
                        hintText: 'Masukkan nomor handphone',
                      ),
                      controller:
                          TextEditingController(text: staticUser.noTelp),
                      onChanged: (value) {
                        staticUser.noTelp = value;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      readOnly: true,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Masukkan password',
                      ),
                      controller:
                          TextEditingController(text: staticUser.password),
                      onChanged: (value) {
                        staticUser.password = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to create a static user for testing
  User getStaticUser() {
    return User(
      id: 1,
      nama: 'John Doe',
      email: 'john.doe@example.com',
      role: 'Admin',
      alamat: '123 Main St',
      noTelp: '123-456-7890',
      password: 'password',
      imageUrl:
          'https://images.unsplash.com/photo-1511367461989-f85a21fda167?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D',
    );
  }
}
