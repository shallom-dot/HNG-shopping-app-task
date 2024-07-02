import 'package:flutter/material.dart';
import 'package:shopping_app/screens/checkoutscreen.dart';
import 'package:shopping_app/screens/products.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Map<String, String>> _products = [
    {
      'title': 'Product 1',
      'subtitle': 'Best product ever',
      'imagelocation': 'assets/image1.png',
      'price': '\$100',
      'discount': '\$85',
    },
    {
      'title': 'Product 2',
      'subtitle': 'Another great product',
      'imagelocation': 'assets/image2.png',
      'price': '\$150',
      'discount': '\$130',
    },
    {
      'title': 'Offer 1',
      'subtitle': 'Subtitle 1',
      'imagelocation': 'assets/image1.png',
      'price': '\$100',
      'discount': '\$85',
      
    },
    {
      'title': 'Offer 2',
      'subtitle': 'Subtitle 2',
      'imagelocation': 'assets/image2.png',
      'price': '\$150',
      'discount': '\$130',
      
    },
     {
      'title': 'Offer 2',
      'subtitle': 'Subtitle 2',
      'imagelocation': 'assets/image2.png',
      'price': '\$150',
      'discount': '\$130',
      
    }, {
      'title': 'Offer 2',
      'subtitle': 'Subtitle 2',
      'imagelocation': 'assets/image2.png',
      'price': '\$150',
      'discount': '\$130',
      
    },
  ];
  List<Map<String, dynamic>> _checkoutItems = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addItemToCheckout(Map<String, String> item) {
    setState(() {
      final existingItem = _checkoutItems.firstWhere(
          (element) => element['title'] == item['title'],
          orElse: () => {});
      if (existingItem.isNotEmpty) {
        existingItem['quantity'] += 1;
      } else {
        _checkoutItems.add({
          'title': item['title'],
          'subtitle': item['subtitle'],
          'imagelocation': item['imagelocation'],
          'price': item['price'],
          'discount': item['discount'],
          'quantity': 1,
        });
      }
    });
  }

  void _removeItemFromCheckout(Map<String, dynamic> item) {
    setState(() {
      final existingItem = _checkoutItems.firstWhere(
          (element) => element['title'] == item['title'],
          orElse: () => {});
      if (existingItem.isNotEmpty && existingItem['quantity'] > 1) {
        existingItem['quantity'] -= 1;
      } else {
        _checkoutItems.remove(item);
      }
    });
  }

  List<Widget> _buildScreens() {
    return [
      DiscountOffersGrid(products: _products, addItemToCheckout: _addItemToCheckout),
      CheckoutScreen(
        checkoutItems: _checkoutItems,
        removeItemFromCheckout: _removeItemFromCheckout,
        addItemToCheckout: _addItemToCheckout, // Include addItemToCheckout here
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping App'),
      ),
      body: _buildScreens()[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Checkout',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}