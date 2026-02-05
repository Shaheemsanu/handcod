import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:handcode_test/core/common_widgets/section_header.dart';
import 'package:handcode_test/core/constants/assets.dart';
import 'package:handcode_test/core/constants/colors.dart';
import 'package:handcode_test/core/constants/sizes.dart';
import 'package:handcode_test/core/routes/route_names.dart';
import 'package:handcode_test/presentation/widgets/category_circle.dart';

class CategoryModel {
  final String label;
  final String iconPath;

  CategoryModel({required this.label, required this.iconPath});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final categories = [
    CategoryModel(label: "Cleaning", iconPath: AppIcons.cleaning),
    CategoryModel(label: "Waste Disposal", iconPath: AppIcons.recycleBin),
    CategoryModel(label: "Plumbing", iconPath: AppIcons.plumbing),
    CategoryModel(label: "Repair", iconPath: AppIcons.cleaning),
    CategoryModel(label: "Painting", iconPath: AppIcons.recycleBin),
    CategoryModel(label: "Gardening", iconPath: AppIcons.cleaning),
    CategoryModel(label: "Electric", iconPath: AppIcons.recycleBin),
    CategoryModel(label: "Car Wash", iconPath: AppIcons.plumbing),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildBanner(),
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 25),

              _buildCategoryGrid(categories),

              const SizedBox(height: 25),
              _buildHorizontalServiceList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Text(
                "406, Skyline Park Dale, MM Road....",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down,
                size: 22,
                color: AppColors.primaryGreen,
              ),
            ],
          ),

          InkWell(
            onTap: () {
              context.push(RouteNames.cart);
            },
            child: Container(
              height: 45,
              width: 45,
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSizes.cardRadius),
              ),
              child: SvgPicture.asset(AppIcons.cart),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
      child: Image.asset(AppImages.bannerImg, height: 130, fit: BoxFit.fill),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search for a service",
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(AppIcons.search),
          ),
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryGrid(List<CategoryModel> categories) {
    final displayList = categories.take(7).toList();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: "Available Services"),
          const SizedBox(height: 15),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayList.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              if (index == displayList.length) {
                return CategoryCircle(
                  label: "See All",
                  isSeeAll: true,
                  iconPath: '',
                );
              }

              final category = displayList[index];

              return CategoryCircle(
                label: category.label,
                iconPath: category.iconPath,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalServiceList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionHeader(
            title: "Cleaning Services",
            onSeeAll: () => context.push(RouteNames.services),
          ),
        ),

        const SizedBox(height: 14),

        SizedBox(
          height: 200,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            children: const [
              ServiceCard(
                title: "Home Cleaning",
                imagePath: AppImages.homeCleaning,
              ),
              SizedBox(width: 14),
              ServiceCard(
                title: "Carpet Cleaning",
                imagePath: AppImages.carpetCleaning,
              ),
              SizedBox(width: 14),
              ServiceCard(
                title: "Sofa Cleaning",
                imagePath: AppImages.sofaCleaning,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
