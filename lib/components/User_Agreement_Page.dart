import 'package:flutter/material.dart';
import 'package:pc_shop/theme/app_theme.dart';

class UserAgreementPage extends StatelessWidget {
  const UserAgreementPage({super.key});

  double _adaptiveFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 320) {
      return 12;
    } else if (screenWidth < 400) {
      return 14;
    } else if (screenWidth < 600) {
      return 16;
    } else {
      return 18;
    }
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = _adaptiveFontSize(context);
    final bottomPadding = MediaQuery.of(context).padding.bottom + 16;

    return Scaffold(
      backgroundColor: AppTheme.black70,
      appBar: AppBar(
        backgroundColor:  AppTheme.black70,
        iconTheme: const IconThemeData(color: AppTheme.purpleAccent),
        title: const Text(
          'Пользовательское соглашение',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, bottomPadding),
        child: SingleChildScrollView(
          child: Text(
            '''Пользовательское соглашение и гарантийная политика
Добро пожаловать в интернет-магазин MIR_PC_UZ — магазин компьютерной техники, сборок и аксессуаров. Мы ценим каждого клиента и гарантируем высокое качество предоставляемой продукции.

1. Гарантия на товары
Мы предоставляем гарантию на всю продаваемую продукцию сроком от 1 месяца до 2 лет в зависимости от типа товара.

Максимальный срок гарантии составляет 24 месяца (2 года).

2. Гарантийный случай
Гарантия распространяется на заводские дефекты и случаи, когда товар не работает с самого начала.

Если в течение первой недели после покупки выявлен заводской дефект, мы гарантируем замену товара на аналогичный или возврат денежных средств.

Для признания случая гарантийным товар проходит диагностику нашими специалистами.

3. Подтверждение гарантии
Гарантийные обязательства подтверждаются:

Либо в накладной;

Либо гарантийным стикером, наклеенным на товар.

По этим отметкам определяется оставшийся срок гарантии.

4. Исключения из гарантии
Гарантия не действует, если:

Товар был умышленно повреждён (механические повреждения, влага, вскрытие и т.д.);

Нарушены условия эксплуатации;

Производился самостоятельный ремонт или вскрытие.

В этих случаях возврат и замена невозможны.

5. Доставка и обслуживание
Мы обязуемся отвечать на все запросы клиентов (звонки, сообщения) в течение 24 часов.

Если ответ или обслуживание не были предоставлены в течение этого времени, клиенту предоставляется скидка 15% на товар по текущей гарантии.

Доставка по г. Ташкент возможна следующими способами:

При нахождении клиента в Мирзо-Улугбекском районе, и если наш сотрудник находится рядом, доставка может быть осуществлена лично.

В остальных случаях доставка осуществляется через Яндекс.Такси, и стоимость доставки оплачивает клиент.

Если:

Клиент получил не тот товар, либо

Товар оказался бракованным при получении —
тогда повторная доставка оплачивается нами.
''',
            style: TextStyle(color: AppTheme.white, fontSize: fontSize, height: 1.5),
          ),
        ),
      ),
    );
  }
}
