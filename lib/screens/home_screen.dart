import 'package:delivery/datas/restriction_list.dart';
import 'package:delivery/forms/restrictions_form.dart';
import 'package:delivery/models/user_model.dart';
import 'package:delivery/tabs/home_tab.dart';
import 'package:delivery/tabs/orders_tab.dart';
import 'package:delivery/tabs/products_tab.dart';
import 'package:delivery/widgets/cart_button.dart';
import 'package:delivery/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();
  List<String> _restrictions = [];

  _addRestriction(
    String newRestriction,
  ) {
    setState(() {
      _restrictions.add(newRestriction);
    });
    if(UserModel.of(context).isLoggedIn()){
      UserModel.of(context).addRestrictions(newRestriction);
    }
    Navigator.of(context).pop();
  }

  _deleteRestriction(String restriction) {
    setState(() {
      _restrictions.remove(restriction);
    });
  }

  _openRestrictionsFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return RestrictionsForm(_addRestriction);
        });
  }

  @override
  Widget build(BuildContext context) {
    _restrictions = UserModel.of(context).restrictions;
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(this._pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 246, 85, 63),
            title: Text("Categorias"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(this._pageController),
          body: ProductsTab(),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 246, 85, 63),
            title: Text("Restrições"),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _openRestrictionsFormModal(context),
              )
            ],
          ),
          drawer: CustomDrawer(this._pageController),
          body: ScopedModelDescendant<UserModel>(
              builder: (context, child, model) {
            if (model.isLoading && UserModel.of(context).isLoggedIn()) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              UserModel.of(context).loadRestrictions();
              return Container(
                child: ListView(
                  children: <Widget>[
                    RestrictionsList(_restrictions, _deleteRestriction),
                  ],
                ),
              );
            }
          }),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Color.fromARGB(255, 246, 85, 63),
            onPressed: () => _openRestrictionsFormModal(context),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 246, 85, 63),
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}
