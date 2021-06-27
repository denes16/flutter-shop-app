import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/orders/widgets/order_item.body.dart';
import '../../core/providers/orders_provider.dart' show OrdersProvider;
import 'widgets/order_item_header.dart';
import '../../shared/widgets/main_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = true;
  @override
  void initState() {
    super.initState();
    Provider.of<OrdersProvider>(context, listen: false)
        .fetchAndSetOrders()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  var _expandedOrderItemIndex = -1;
  bool isExpanded(int index) {
    return _expandedOrderItemIndex == -1
        ? false
        : _expandedOrderItemIndex == index;
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My orders'),
      ),
      drawer: MainDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator.adaptive())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ExpansionPanelList(
                    children: ordersProvider.orders
                        .asMap()
                        .entries
                        .map((e) => ExpansionPanel(
                            canTapOnHeader: true,
                            headerBuilder: (_, __) => OrderItemHeader(e.value),
                            body: OrderItemBody(e.value),
                            isExpanded: isExpanded(e.key)))
                        .toList(),
                    expansionCallback: (i, value) {
                      if (!value) {
                        setState(() {
                          _expandedOrderItemIndex = i;
                        });
                      } else {
                        setState(() {
                          _expandedOrderItemIndex = -1;
                        });
                      }
                    },
                  ),
                )
              ],
            ),
    );
  }
}
