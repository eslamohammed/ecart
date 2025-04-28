import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case ProductLoading _:
              return const Center(child: CircularProgressIndicator());
            case ProductLoaded _:
              final products = (state as ProductLoaded).products;
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: product.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                      errorWidget:
                          (context, error, stackTrace) =>
                              const Icon(Icons.error),
                      progressIndicatorBuilder:
                          (context, child, loadingProgress) =>
                              const CircularProgressIndicator(),
                      alignment: Alignment.center,
                      filterQuality: FilterQuality.high,
                    ),
                    title: Text(product.title),
                    subtitle: Text(
                      '${product.price}\$',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: Colors.green),
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
                },
              );
            case ProductError _:
              return Center(child: Text((state as ProductError).message));
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
