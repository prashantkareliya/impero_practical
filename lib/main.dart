
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:impero_practical/screens/dashboard/bloc/category_bloc.dart';
import 'package:impero_practical/screens/dashboard/data/category_datasource.dart';
import 'package:impero_practical/screens/dashboard/data/category_repository.dart';
import 'package:impero_practical/screens/dashboard/model/category_request_model.dart';
import 'package:impero_practical/screens/dashboard/model/category_response_model.dart';
import 'package:impero_practical/screens/dashboard/model/get_product_response.dart';
import 'package:impero_practical/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'constants/helpers.dart';
import 'screens/design_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      child: MaterialApp(
        title: 'tapp-loyalty.com',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CategoryBloc categoryBloc = CategoryBloc(
      CategoryRepository(categoryDatasource: CategoryDatasource()));

  bool isLoading = false;
  List<Categories>? categoryList = [];

  PagingController<int, SubCategories> pagingController =
      PagingController(firstPageKey: 1);

  Categories? selectedCategory;
  SubCategories? selectSubCategories;
  ResultProduct? resultProduct;

  List<ResultProduct>? productList;


  @override
  void initState() {
    super.initState();
    getData();
    pagingController.addPageRequestListener((pageKey) {
      if (selectedCategory != null) {
        CategoryRequest categoryRequest = CategoryRequest(
            categoryId: selectedCategory?.id, pageIndex: pageKey);
        categoryBloc.add(GetSubCategoryEvent(categoryRequest));
      } else {
        pagingController.appendLastPage([]);
      }
    });

    /*pagingController.addPageRequestListener((pageKeyProduct) {
      if(resultProduct != null){
        CategoryRequest categoryRequest = CategoryRequest(
            pageIndex: pageKeyProduct,
          SubCategoryId: selectSubCategories?.id,
        );
        categoryBloc.add(GetProductEvent(categoryRequest));
      } else {
        pagingController.appendLastPage([]);
      }
    });*/
  }

  getData() {
    CategoryRequest categoryRequest = CategoryRequest(
        categoryId: 0,
        deviceManufacturer: "Google",
        deviceModel: "Android SDK built for x86",
        deviceToken: "",
        pageIndex: 1);
    categoryBloc.add(GetCategoryEvent(categoryRequest));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const DesignScreen()));
          },
          child: Icon(Icons.design_services, color: AppColors.whiteColor),
        ),
        body: BlocConsumer<CategoryBloc, CategoryState>(
          bloc: categoryBloc,
          listener: (context, state) {
            if (state is LoadingCategory) {
              isLoading = state.isBusy;
            }
            if (state is LoadedCategory) {
              categoryList = state.categoryList;
            }
            if (state is LoadedSubCategory) {
              //subCategoryList = state.subCategoryList;
              if(state.subCategoryList?.isNotEmpty == true){
                pagingController.appendPage(state.subCategoryList ?? [],
                    pagingController.nextPageKey!+1);
              } else {
                pagingController.appendLastPage(state.subCategoryList ?? []);
              }
              //pagingController.appendLastPage(state.subCategoryList ?? []);
            }
            if (state is FailCategory) {
              Helpers.showSnackbar(context, state.error.toString());
            }
            if (state is SelectCategoryState) {
              selectedCategory = state.categories;
              pagingController.refresh();
            }
            if (state is GetProductState) {
              productList = state.productList;
              pagingController.refresh();
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: AppColors.primaryColor,
                  width: size.width,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.sp, vertical: 5.sp),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.filter_alt_outlined,
                                color: AppColors.whiteColor),
                            Icon(Icons.search, color: AppColors.whiteColor),
                          ],
                        ),
                        Container(
                          color: AppColors.primaryColor,
                          width: size.width,
                          height: 0.04.sh,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryList?.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0.sp, 0.sp, 18.sp, 0.sp),
                                child: InkWell(
                                  onTap: () {
                                    categoryBloc.add(SelectCategoryEvent(
                                        categoryList![index]));
                                  },
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      categoryList![index].name ?? "",
                                      style: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontSize: 14.sp),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: PagedListView<int, SubCategories>(
                  pagingController: pagingController,
                  builderDelegate: PagedChildBuilderDelegate<SubCategories>(
                    itemBuilder: (context, item, index) =>
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 10.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.name ?? ""),
                              SizedBox(
                                height: 0.16.sh,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: item.product!.length,
                                  itemBuilder: (context, i) {
                                    return Padding(
                                      padding: EdgeInsets.only(right: 10.sp),
                                      child: Stack(
                                        children: [
                                          Image.network(item.product![index].imageName.toString()),
                                          Positioned(
                                            left: 12.sp,
                                            top: 12.sp,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 5.sp),
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.circular(8.sp)
                                              ),
                                                child: Text(item.product!.first.priceCode.toString(), style: TextStyle(color: AppColors.whiteColor))),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )

                            ],
                          ),
                        ),
                  ),
                ))
              ],
            );
          },
        ),
      ),
    );
  }
}
