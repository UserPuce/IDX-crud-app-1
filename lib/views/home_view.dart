import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/login_provider.dart';
import 'package:myapp/widgets/drawer_widget.dart';
import 'package:myapp/widgets/login_widget.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home View"),
        centerTitle: true,
        elevation: 5,
        backgroundColor: Colors.blueAccent,
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (loginState == null)
                const LoginWidget()
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Welcome, $loginState!',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.redAccent),
                      onPressed: () {
                        ref.read(loginProvider.notifier).logout();
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 40),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: const Image(
                  height: 350,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://papelyt.com/web/image/7654-796a65af/back%20to%20school%20pink%20school_6494856.webp"),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: const Text(
                  "Todo lo que buscas en papelería y tecnología.",
                  style: TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: const Text(
                    "Explora las opciones del menú 👌",
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                      color: Colors.blueGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
