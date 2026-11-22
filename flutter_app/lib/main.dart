import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const AlShamMarketApp());
}

class AlShamMarketApp extends StatelessWidget {
  const AlShamMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سوق الشام',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B5E20)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), _goHome);
  }

  void _goHome() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'سوق الشام',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  'منصة الشام للمواد الغذائية والوجبات السريعة',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 24),
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _goHome,
                  child: const Text('دخول إلى المتجر الآن'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductItem {
  final String name;
  final String category;
  final double priceUsd;
  final String description;

  const ProductItem({
    required this.name,
    required this.category,
    required this.priceUsd,
    required this.description,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ProductItem> _items = const [
    ProductItem(
      name: 'معجون بندورة 800 غرام',
      category: 'مواد غذائية',
      priceUsd: 1.50,
      description: 'عبوة معجون بندورة جاهزة للاستخدام اليومي في الطبخ.',
    ),
    ProductItem(
      name: 'زيت زيتون بلدي',
      category: 'مواد غذائية',
      priceUsd: 6.00,
      description: 'زيت زيتون طبيعي مناسب للمائدة والطبخ.',
    ),
    ProductItem(
      name: 'شاورما عربي',
      category: 'وجبات سريعة',
      priceUsd: 3.50,
      description: 'وجبة شاورما مع مقبلات ومناسبات التقديم السريع.',
    ),
    ProductItem(
      name: 'بروستد مع بطاطا',
      category: 'وجبات سريعة',
      priceUsd: 5.50,
      description: 'قطع دجاج مقرمشة مع بطاطا ومقبلات.',
    ),
  ];

  final List<ProductItem> _cart = [];

  void _addToCart(ProductItem item) {
    setState(() {
      _cart.add(item);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تمت إضافة "${item.name}" إلى السلة'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _openItemDetails(ProductItem item) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text('القسم: ${item.category} • السعر: \$${item.priceUsd.toStringAsFixed(2)}'),
                const SizedBox(height: 12),
                Text(item.description),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(sheetContext).pop();
                      _addToCart(item);
                    },
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text('إضافة إلى السلة'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openCart() {
    final double total = _cart.fold(0, (sum, item) => sum + item.priceUsd);
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: const Text('سلة المشتريات'),
            content: _cart.isEmpty
                ? const Text('السلة فارغة حالياً. اضغط على أي منتج لإضافته.')
                : SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _cart.length,
                            itemBuilder: (_, i) => ListTile(
                              dense: true,
                              title: Text(_cart[i].name),
                              trailing: Text('\$${_cart[i].priceUsd.toStringAsFixed(2)}'),
                            ),
                          ),
                        ),
                        const Divider(),
                        Text(
                          'الإجمالي: \$${total.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
            actions: [
              if (_cart.isNotEmpty)
                TextButton(
                  onPressed: () {
                    setState(() => _cart.clear());
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('إفراغ السلة'),
                ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('إغلاق'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('سوق الشام - الرئيسية'),
          actions: [
            TextButton.icon(
              onPressed: _openCart,
              icon: const Icon(Icons.shopping_cart),
              label: Text('(${_cart.length})'),
            ),
          ],
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: _items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final item = _items[index];
            return Card(
              child: ListTile(
                onTap: () => _openItemDetails(item),
                leading: const Icon(Icons.storefront),
                title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('القسم: ${item.category} • \$${item.priceUsd.toStringAsFixed(2)}'),
                trailing: IconButton(
                  tooltip: 'إضافة إلى السلة',
                  onPressed: () => _addToCart(item),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
