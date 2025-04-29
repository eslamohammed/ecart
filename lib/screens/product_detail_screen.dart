import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: product.id,
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  fit: BoxFit.fitWidth,
                  errorWidget:
                      (context, error, stackTrace) => const Icon(Icons.error),
                  progressIndicatorBuilder:
                      (context, child, loadingProgress) =>
                          const CircularProgressIndicator(),
                  alignment: Alignment.center,
                  filterQuality: FilterQuality.medium,
                ),
              ),
              const VerticalSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      product.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  const VerticalSpace(),
                  Text(
                    '${product.price} \$',
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(color: Colors.green),
                  ),
                ],
              ),
              const VerticalSpace(),
              Text(product.description),
            ],
          ),
        ),
      ),
    );
  }
}

class VerticalSpace extends StatelessWidget {
  const VerticalSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 20);
  }
}
