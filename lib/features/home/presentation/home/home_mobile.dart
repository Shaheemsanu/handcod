// import 'package:handcode_test/shared/shared.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hancod_theme/forms/app_phonenumber_form.dart';
// import 'package:hancod_theme/hancod_theme.dart';

// class HomeScreenMobileMobile extends ConsumerStatefulWidget {
//   const HomeScreenMobileMobile({super.key});

//   @override
//   ConsumerState<HomeScreenMobileMobile> createState() => _HomeScreenMobileMobileState();
// }

// class _HomeScreenMobileMobileState extends ConsumerState<HomeScreenMobileMobile> {
//   final _inputDecoration = const InputDecoration(border: OutlineInputBorder());
//   final _formKey = GlobalKey<FormBuilderState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(context.l10n.helloHancod)),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: FormBuilder(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 AppTextForm<String>(
//                   name: 'text',
//                   label: context.l10n.textForm,
//                   decoration: _inputDecoration,
//                 ),
//                 const SizedBox(height: 8),
//                 AppPhoneNumberForm(
//                   name: 'phone',
//                   label: context.l10n.phoneNo,
//                   decoration: _inputDecoration,
//                 ),
//                 const SizedBox(height: 8),
//                 AppTypeAheadForm<int>(
//                   name: 'age',
//                   label: context.l10n.age,
//                   decoration: _inputDecoration,
//                   suggestionsCallback: (search) =>
//                       List.generate(100, (index) => index)
//                           .where((element) => '$element'.contains(search))
//                           .toList(),
//                   itemBuilder: (context, suggestion) => ListTile(
//                     title: Text('$suggestion'),
//                   ),
//                   selectionToTextTransformer: (suggestion) => '$suggestion',
//                 ),
//                 const SizedBox(height: 8),
//                 AppDateTimeForm(
//                   name: 'date',
//                   label: context.l10n.date,
//                   decoration: _inputDecoration,
//                 ),
//                 const SizedBox(height: 8),
//                 // const AppCheckBoxForm(
//                 //   name: 'check',
//                 //   label: 'Check me',
//                 //   hint: 'Check me',
//                 // ),
//                 // const SizedBox(height: 8),
//                 // AppMultiSelectDropdownForm<String>(
//                 //   name: 'multiSelect',
//                 //   label: 'MultiSelect',
//                 //   future: () => Future.value([
//                 //     DropdownItem(value: '1', label: 'Item 1'),
//                 //     DropdownItem(value: '2', label: 'Item 2'),
//                 //     DropdownItem(value: '3', label: 'Item 3'),
//                 //   ]),
//                 // ),
//                 // const SizedBox(height: 8),
//                 // const AppDropDownForm<String>(
//                 //   name: 'dropdown',
//                 //   label: 'Dropdown',
//                 //   items: [
//                 //     DropDownItems(value: '1', child: Text('Item 1')),
//                 //     DropDownItems(value: '2', child: Text('Item 2')),
//                 //     DropDownItems(value: '3', child: Text('Item 3')),
//                 //   ],
//                 // ),
//                 // const SizedBox(height: 8),
//                 // AppToggleForm(
//                 //   name: 'toggle',
//                 //   label: 'Toggle',
//                 //   hint: 'Toggle',
//                 //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //   onChanged: (value) {},
//                 // ),
//                 const SizedBox(height: 18),
//                 AppButton(
//                   onPress: () {
//                     if (_formKey.currentState?.saveAndValidate() ?? false) {}
//                   },
//                   label: Text(context.l10n.primary),
//                 ),
//                 const SizedBox(height: 8),
//                 AppButton(
//                   style: ButtonStyles.secondary,
//                   onPress: () {},
//                   label: Text(context.l10n.secondary),
//                 ),
//                 const SizedBox(height: 8),
//                 AppButton(
//                   style: ButtonStyles.cancel,
//                   onPress: () {},
//                   label: Text(context.l10n.cancel),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hancod_theme/colors.dart';
import 'package:handcode_test/features/home/presentation/home/widgets/category_circle.dart';
import 'package:handcode_test/features/home/presentation/home/widgets/section_header.dart';
import 'package:handcode_test/shared/shared.dart';
import 'package:handcode_test/shared/utils/assets.gen.dart';

class CategoryModel {
  final String label;
  final String iconPath;

  CategoryModel({required this.label, required this.iconPath});
}

class HomeScreenMobile extends StatefulWidget {
  const HomeScreenMobile({super.key});

  @override
  State<HomeScreenMobile> createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  final categories = [
    CategoryModel(label: "Cleaning", iconPath: Assets.icons.cleaningIcon.path),
    CategoryModel(
      label: "Waste Disposal",
      iconPath: Assets.icons.recycleBinIcon.path,
    ),
    CategoryModel(label: "Plumbing", iconPath: Assets.icons.plumbingIcon.path),
    CategoryModel(label: "Repair", iconPath: Assets.icons.cleaningIcon.path),
    CategoryModel(
      label: "Painting",
      iconPath: Assets.icons.recycleBinIcon.path,
    ),
    CategoryModel(label: "Gardening", iconPath: Assets.icons.cleaningIcon.path),
    CategoryModel(
      label: "Electric",
      iconPath: Assets.icons.recycleBinIcon.path,
    ),
    CategoryModel(label: "Car Wash", iconPath: Assets.icons.plumbingIcon.path),
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
            onTap: () {},
            child: Container(
              height: 45,
              width: 45,
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: SvgPicture.asset(Assets.icons.cartIcon.path),
              // SvgPicture.asset(AppIcons),
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
        borderRadius: BorderRadius.circular(16),
      ),
      child: Image.asset(
        Assets.images.perfectCleaning.path,
        height: 130,
        fit: BoxFit.fill,
      ),
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
            child: SvgPicture.asset(Assets.icons.searchIcon.path),
            // SvgPicture.asset(AppIcons.
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
                  onTap: () {
                    log("message");
                    context.pushNamed(AppRouter.service);
                  },
                );
              }

              final category = displayList[index];

              return CategoryCircle(
                label: category.label,
                iconPath: category.iconPath,
                onTap: () {},
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
            // onSeeAll: () => context.push(RouteNames.services),
          ),
        ),

        const SizedBox(height: 14),

        SizedBox(
          height: 200,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            children: [
              ServiceCard(
                title: "Home Cleaning",
                imagePath: Assets.images.homeCleaning.path,
              ),
              SizedBox(width: 14),
              ServiceCard(
                title: "Carpet Cleaning",
                imagePath: Assets.images.carpetCleaning.path,
              ),
              SizedBox(width: 14),
              ServiceCard(
                title: "Sofa Cleaning",
                imagePath: Assets.images.sofaCleaning.path,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
