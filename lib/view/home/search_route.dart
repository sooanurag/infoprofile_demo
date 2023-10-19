import 'package:flutter/material.dart';
import 'package:infoprofile_demo/resources/colors.dart';
import 'package:infoprofile_demo/resources/fonts.dart';

class SearchRoute extends StatefulWidget {
  const SearchRoute({super.key});

  @override
  State<SearchRoute> createState() => _SearchRouteState();
}

class _SearchRouteState extends State<SearchRoute> {
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();

  @override
  void initState() {
    _searchFocusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Search",
          ),
        ),
      ),
      body: SafeArea(
          child: Center(
        child: Text(
          "Try searching for people, topics or keywords",
          style: AppFonts.headerStyle(
            context: context,
              color: AppColors.grey, fontWeight: FontWeight.w600),
        ),
      )),
    );
  }
}
