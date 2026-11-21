# منصة الشام للمواد الغذائية والوجبات السريعة (سوريا - بالدولار $)

حزمة مشروع متكاملة تضم:
- **قاعدة البيانات (`backend/schema.sql` و `backend/seed.sql`):** جداول المستخدمين، السوبرماركت ومطاعم الوجبات السريعة، المنتجات والوجبات، شركات التوصيل، قنوات الدفع (شام كاش، محافظ مثل شام كاش، حسابات بنكية، ماستر كارت، والدفع عند الاستلام)، الطلبات، وكشف التسوية التلقائي بالدولار الأمريكي (`USD`).
- **الواجهة الخلفية (`backend/server.js` و `backend/package.json`):** خادم Node.js + Express + PostgreSQL مع تسجيل دخول المدير العام (`POST /api/auth/login`)، حماية مسارات الإدارة (`requireAdmin`)، عرض الطلبات للمدير العام (`GET /api/admin/orders`)، تأكيد الحوالات (`PATCH /api/admin/orders/:id/verify-payment`)، إعدادات العمولة وقنوات الدفع (`GET /api/admin/settings`، `PATCH /api/admin/settings/commission`، `PATCH /api/admin/payment-channels/:id/toggle`)، حساب التسوية، وملخص الأرباح.
- **تطبيق الموبايل (`flutter_app/pubspec.yaml` و `flutter_app/lib/`):** واجهة عربية (RTL) بعملة الدولار (`$`) تشمل تصفح المنتجات والوجبات وتعديل الكميات في السلة (`cart_screen.dart`)، تسجيل دخول المدير العام وحماية لوحات الإدارة، متابعة الطلبات وتأكيد الحوالات (`admin_orders_screen.dart`)، إدارة السوبرماركت والمطاعم والمنتجات، إتمام الطلب والدفع، إدارة الحسابات وشركات التوصيل، إعدادات المنصة العامة (`admin_settings_screen.dart`)، ولوحة التسويات والأرباح.

## خطوات تثبيت وتشغيل التطبيق

### 1. قاعدة البيانات والواجهة الخلفية
1. أنشئ قاعدة بيانات `sham_delivery_db` في PostgreSQL.
2. نفّذ `backend/schema.sql` ثم `backend/seed.sql`.
3. انسخ `backend/.env.example` إلى `backend/.env` وعدّل بيانات الاتصال إذا لزم الأمر، ثم شغّل:
   ```bash
   cd backend
   npm install
   npm start
   ```

### 2. تطبيق الموبايل (Flutter)
```bash
cd flutter_app
flutter pub get
flutter run
```
