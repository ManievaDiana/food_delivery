import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_cart_tile.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/pages/payment_page.dart';
import 'package:provider/provider.dart';

import '../components/my_button.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        // User's cart
        final userCart = restaurant.cart;

        // App UI
        return Scaffold(
          appBar: AppBar(
            title: const Text("Cart"), // Add centerTitle: true property
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              IconButton(
                onPressed: () {
                  // Confirm clearing the cart
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                          "Are you sure you want to clear the cart?"),
                      actions: [
                        // Cancel button
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        // Yes button
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            restaurant.clearCart(); // Clear the cart
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          body: Column(
            children: [
              // Cart items
              Expanded(
                child: userCart.isEmpty
                    ? Center(
                        child: const Text("Cart is empty.."),
                      )
                    : ListView.builder(
                        itemCount: userCart.length,
                        itemBuilder: (context, index) {
                          final cartItem = userCart[index];
                          return MyCartTile(cartItem: cartItem);
                        },
                      ),
              ),
              // Payment page
              MyButton(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentPage(),
                  ),
                ),
                text: "Go to checkout",
              ),
              const SizedBox(height: 25),
            ],
          ),
        );
      },
    );
  }
}
