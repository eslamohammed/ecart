import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecart/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.appName)),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return _buildProductList(state.products, context);
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          return const _EmptyStateWidget();
        },
      ),
    );
  }

  Widget _buildProductList(List<Product> products, BuildContext context) {
    return ListView.separated(
      itemCount: products.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final product = products[index];
        return _ProductListItem(product: product);
      },
    );
  }
}

class _EmptyStateWidget extends StatelessWidget {
  const _EmptyStateWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("No products available."));
  }
}

class _ProductListItem extends StatelessWidget {
  final Product product;

  const _ProductListItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: product.id,
        child: CachedNetworkImage(
          imageUrl: product.image,
          width: 50,
          height: 50,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget:
              (context, url, error) =>
                  const Icon(Icons.error), // Add error widget
        ),
      ),
      title: Text(product.title),
      subtitle: Text(
        '${product.price} \$',
        textAlign: TextAlign.end,
        style: DefaultTextStyle.of(context).style.copyWith(color: Colors.green),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: product),
          ),
        );
      },
    );
  }
}
