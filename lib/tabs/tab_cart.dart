import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import "../providers/provider_auth.dart";
import "../providers/provider_cart.dart";
import 'package:palestine_console/palestine_console.dart';

//! 장바구니는 유저마다 달라야하니까 도큐먼트 아이디가 유저아이디여야 한다
class CartTab extends StatelessWidget {
  const CartTab({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final authClient = Provider.of<FirebaseAuthProvider>(context);
    // Print.red("${authClient.user}");
    // Print.white("${cart.fetchCartItemsOrMakeCart(authClient.user)}");
    return FutureBuilder(
        future: cart.fetchCartItemsOrMakeCart(authClient.user),
        builder: (context, snapshot) {
          if (cart.cartItems.length == 0) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: cart.cartItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/item_detail',
                          arguments: cart.cartItems[index]);
                    },
                    title: Text(cart.cartItems[index].title),
                    subtitle: Text(cart.cartItems[index].price.toString()),
                    leading: Image.network(cart.cartItems[index].imageUrl),
                    trailing: InkWell(
                        onTap: () {
                          cart.removeItemFromCart(
                              authClient.user, cart.cartItems[index]);
                        },
                        child: Icon(Icons.delete)),
                  );
                });
          }
        });
  }
}
