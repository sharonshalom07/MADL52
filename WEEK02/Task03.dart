import 'package:flutter/material.dart';

void main() => runApp(const EcommerceHub());

class EcommerceHub extends StatelessWidget {
  const EcommerceHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainHub(),
    );
  }
}

class MainHub extends StatefulWidget {
  const MainHub({super.key});
  @override
  State<MainHub> createState() => _MainHubState();
}

class _MainHubState extends State<MainHub> {
  int _selectedIndex = 0;
  final _pages = [const HomePage(), const CartPage(), const ProfilePage()];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            child: child,
          );
        },
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade900, Colors.black87],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 12,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.white70,
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: 'Cart'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- HOME PAGE ----------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => Container(
        key: const ValueKey("home"),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1f4037), Color(0xFF99f2c8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("✨ Featured Products",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.75, crossAxisSpacing: 15, mainAxisSpacing: 15),
                  itemCount: 6,
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: const Offset(2, 4))
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            child: Image.network(
                              "https://picsum.photos/200/200?random=$index",
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text("Product ${index + 1}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    5,
                                    (i) => Icon(Icons.star,
                                        size: 16,
                                        color: i < 4
                                            ? Colors.amber
                                            : Colors.grey)),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Text("Add to Cart"),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

// ---------------- CART PAGE ----------------
class CartPage extends StatelessWidget {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context) => Container(
        key: const ValueKey("cart"),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF373B44), Color(0xFF4286f4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("🛍 Your Cart",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: 3,
                  itemBuilder: (context, index) => Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                              "https://picsum.photos/100/100?random=$index",
                              fit: BoxFit.cover)),
                      title: Text("Cart Item ${index + 1}"),
                      subtitle: const Text("Quantity: 1"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.remove)),
                          const Text("1"),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.add)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total: \$249",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: const Text("Checkout"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

// ---------------- PROFILE PAGE ----------------
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => Container(
        key: const ValueKey("profile"),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF614385), Color(0xFF516395)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
              ),
              const SizedBox(height: 15),
              const Center(
                  child: Text("John Doe",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
              const SizedBox(height: 5),
              const Center(
                  child: Text("john.doe@email.com",
                      style: TextStyle(color: Colors.white70))),
              const SizedBox(height: 30),

              // Stats row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStat("Orders", "12"),
                  _buildStat("Wishlist", "8"),
                  _buildStat("Rewards", "240"),
                ],
              ),
              const SizedBox(height: 30),

              // Options
              _buildProfileTile(Icons.settings, "Account Settings"),
              _buildProfileTile(Icons.history, "Order History"),
              _buildProfileTile(Icons.favorite, "Wishlist"),
              _buildProfileTile(Icons.card_giftcard, "Rewards"),
              _buildProfileTile(Icons.logout, "Logout", color: Colors.red),
            ],
          ),
        ),
      );

  Widget _buildStat(String title, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amber)),
        const SizedBox(height: 5),
        Text(title, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }

  Widget _buildProfileTile(IconData icon, String text,
      {Color color = Colors.blueGrey}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(text),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {},
      ),
    );
  }
}
