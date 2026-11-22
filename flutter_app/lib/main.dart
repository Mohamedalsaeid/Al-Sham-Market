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
                  'منصة الشام للسوبر ماركتات والمطاعم',
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
  final String storeName;
  final String storeType; // 'سوبر ماركت' أو 'مطعم'
  final String category;
  final double priceUsd;
  final String description;

  const ProductItem({
    required this.name,
    required this.storeName,
    required this.storeType,
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
  String _selectedType = 'الكل'; // 'الكل' | 'سوبر ماركت' | 'مطعم'
  String _selectedStore = 'كل المتاجر';

  // أضف أي سوبر ماركت أو مطعم أو منتج جديد داخل هذه القائمة بنفس النمط
  final List<ProductItem> _items = const [
    ProductItem(
      name: 'معجون بندورة 800 غرام',
      storeName: 'سوبر ماركت الشام',
      storeType: 'سوبر ماركت',
      category: 'مواد غذائية',
      priceUsd: 1.50,
      description: 'عبوة معجون بندورة جاهزة للاستخدام اليومي في الطبخ.',
    ),
    ProductItem(
      name: 'زيت زيتون بلدي',
      storeName: 'سوبر ماركت الشام',
      storeType: 'سوبر ماركت',
      category: 'مواد غذائية',
      priceUsd: 6.00,
      description: 'زيت زيتون طبيعي مناسب للمائدة والطبخ.',
    ),
    ProductItem(
      name: 'رز بسمتي 5 كغ',
      storeName: 'ماركت الفيحاء',
      storeType: 'سوبر ماركت',
      category: 'مواد غذائية',
      priceUsd: 8.50,
      description: 'أرز حبة طويلة مناسب للأطباق الرئيسية.',
    ),
    ProductItem(
      name: 'سكر أبيض 2 كغ',
      storeName: 'ماركت الفيحاء',
      storeType: 'سوبر ماركت',
      category: 'مواد غذائية',
      priceUsd: 2.00,
      description: 'عبوة سكر أبيض ناعم للاستخدام المنزلي.',
    ),
    ProductItem(
      name: 'شاورما عربي',
      storeName: 'مطعم شاورما الشام',
      storeType: 'مطعم',
      category: 'وجبات سريعة',
      priceUsd: 3.50,
      description: 'وجبة شاورما مقطعة مع بطاطا ومقبلات وثوم.',
    ),
    ProductItem(
      name: 'بروستد مع بطاطا',
      storeName: 'مطعم بروستد الغوطة',
      storeType: 'مطعم',
      category: 'وجبات سريعة',
      priceUsd: 5.50,
      description: 'قطع دجاج مقرمشة مع بطاطا ومقبلات.',
    ),
    ProductItem(
      name: 'فروج مشوي كامل',
      storeName: 'مطعم بروستد الغوطة',
      storeType: 'مطعم',
      category: 'وجبات سريعة',
      priceUsd: 9.00,
      description: 'فروج مشوي على الفحم مع ثوم وبطاطا ومخلل.',
    ),
  ];

  final List<ProductItem> _cart = [];

  List<String> get _availableStores {
    final base = _selectedType == 'الكل'
        ? _items
        : _items.where((item) => item.storeType == _selectedType);
    final names = base.map((e) => e.storeName).toSet().toList();
    return ['كل المتاجر', ...names];
  }

  List<ProductItem> get _filteredItems {
    return _items.where((item) {
      final matchesType = _selectedType == 'الكل' || item.storeType == _selectedType;
      final matchesStore = _selectedStore == 'كل المتاجر' || item.storeName == _selectedStore;
      return matchesType && matchesStore;
    }).toList();
  }

  void _addToCart(ProductItem item) {
    setState(() {
      _cart.add(item);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تمت إضافة "${item.name}" من ${item.storeName} إلى السلة'),
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
                Text('${item.storeName} (${item.storeType}) • ${item.category}'),
                const SizedBox(height: 4),
                Text('السعر: \$${item.priceUsd.toStringAsFixed(2)}'),
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
                              subtitle: Text(_cart[i].storeName),
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم إرسال الطلب وتفريغ السلة')),
                    );
                  },
                  child: const Text('تأكيد الطلب'),
                ),
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
    final stores = _availableStores;
    final activeStore = stores.contains(_selectedStore) ? _selectedStore : 'كل المتاجر';
    final visibleItems = _filteredItems;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('سوق الشام - المتاجر والمطاعم'),
          actions: [
            TextButton.icon(
              onPressed: _openCart,
              icon: const Icon(Icons.shopping_cart),
              label: Text('(${_cart.length})'),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Row(
                children: ['الكل', 'سوبر ماركت', 'مطعم'].map((type) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ChoiceChip(
                      label: Text(type),
                      selected: _selectedType == type,
                      onSelected: (_) {
                        setState(() {
                          _selectedType = type;
                          _selectedStore = 'كل المتاجر';
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 46,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: stores.length,
                itemBuilder: (_, index) {
                  final store = stores[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: FilterChip(
                      label: Text(store),
                      selected: activeStore == store,
                      onSelected: (_) => setState(() => _selectedStore = store),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: visibleItems.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final item = visibleItems[index];
                  return Card(
                    child: ListTile(
                      onTap: () => _openItemDetails(item),
                      leading: Icon(
                        item.storeType == 'مطعم' ? Icons.restaurant : Icons.storefront,
                      ),
                      title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        '${item.storeName} • ${item.category} • \$${item.priceUsd.toStringAsFixed(2)}',
                      ),
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
          ],
        ),
      ),
    );
  }
}
