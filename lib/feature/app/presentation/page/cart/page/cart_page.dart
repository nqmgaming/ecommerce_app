import 'package:ecommerce_app/feature/app/presentation/page/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int? _userId;
  int _cartLength = 0;

  @override
  void initState() {
    getUserIdFromSecureStorage();

    super.initState();
  }

  void getUserIdFromSecureStorage() async {
    final userId = await const FlutterSecureStorage().read(key: 'userId');
    if (mounted) {
      setState(() {
        _userId = userId != null ? int.tryParse(userId) : null;
      });
      if (_userId != null) {
        BlocProvider.of<CartBloc>(context).add(GetCart(_userId.toString()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartLoaded) {
          setState(() {
            _cartLength = state.cart.length;
          });
        }
      },
      buildWhen: (previous, current) {
        if (current is CartLoaded) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            actions: [
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(right: 10),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  // shadow
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 0.1, // How much the shadow spreads
                      blurRadius: 5, // How much the shadow blurs
                      offset: const Offset(0, 1), // Offset of the shadow (x, y)
                    ),
                  ],
                ),
                child: Center(
                  child: Badge(
                    textStyle: const TextStyle(color: Colors.red),
                    backgroundColor: Colors.black,
                    label: Text(
                      _cartLength.toString(),
                      style: const TextStyle(fontSize: 10),
                    ),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
          body: state is CartLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is CartLoaded
                  ? ListView.builder(
                      itemCount: state.cart.length,
                      itemBuilder: (context, index) {
                        final cart = state.cart[index];
                        return ListTile(
                          title: Text(cart.id.toString()),
                          subtitle: Text(cart.quantity.toString()),
                        );
                      },
                    )
                  : const Center(child: Text('No data')),
        );
      },
    );
  }
}
