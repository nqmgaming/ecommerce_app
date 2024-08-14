import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int? _userId;

  @override
  void initState() {
    super.initState();
    getUserIdFromSecureStorage();
  }

  void getUserIdFromSecureStorage() async {
    final userId = await const FlutterSecureStorage().read(key: 'userId');
    setState(() {
      _userId = userId != null ? int.tryParse(userId) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: _userId != null
          ? Center(
        child: Text('User ID: $_userId'),
      )
          : Center(
        child: Text('User ID not found'),
      ),
    );
  }
}