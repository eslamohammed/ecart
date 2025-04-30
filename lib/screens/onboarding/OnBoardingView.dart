import 'package:ecart/screens/onboarding/OnboardingViewModel.dart';
import 'package:ecart/screens/onboarding/onboarding_slider.dart';
import 'package:ecart/utils/app_constants.dart';
import 'package:ecart/utils/app_strings.dart';
import 'package:ecart/utils/assets_manager.dart';
import 'package:ecart/utils/color_manager.dart';
import 'package:ecart/utils/routes.dart';
import 'package:ecart/utils/style_manager.dart';
import 'package:ecart/utils/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController pageController = PageController();
  final OnboardingViewModel _viewModel = OnboardingViewModel();

  _binding() {
    _viewModel.onStart();
  }

  @override
  void initState() {
    _binding();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OnboardingSliderViewObject>(
        stream: _viewModel.outputSliderViewObject,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return _getContentWidget(snapshot.data!);
          } else {
            return Container();
          }
        });
  }

  Widget _getContentWidget(OnboardingSliderViewObject data) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: ColorManager.water,
            statusBarBrightness: Brightness.light),
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: data.pageCount,
        onPageChanged: (index) {
          _viewModel.onPageChanged(index);
        },
        itemBuilder: (context, index) {
          return OnboardingPage(
            onboardingSlider: data.onboardingSlider,
          );
        },
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(Routes.homeRoute);
                  },
                  child:  Text(
                    AppStrings.skip,
                    textAlign: TextAlign.end,
                    style: buttonText2.copyWith(color: ColorManager.coldOrange),
                  ),
                ),
              ),
            ),
            _getBottomSheetWidget(data)
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget(OnboardingSliderViewObject? data) {
    return Container(
      decoration:  BoxDecoration(color: ColorManager.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p16, horizontal: AppPadding.p20),
            child: GestureDetector(
              onTap: () {
                pageController.previousPage(
                    duration: const Duration(
                        milliseconds: AppConstants.sliderAnimationTime),
                    curve: Curves.ease);
              },
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(
                  color: ColorManager.coldOrange,
                  AssetsManager.leftArrow,
                ),
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            for (int index = 0; index < data!.pageCount; index++)
              Container(
                width: data.currentIndex == index ? AppSize.s11_5 : AppSize.s10,
                height:
                    data.currentIndex == index ? AppSize.s11_5 : AppSize.s10,
                margin: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: data.currentIndex == index
                      ? Border.all(
                          color: ColorManager.white,
                          width: AppSize.s1_5,
                        )
                      : null,
                  color: data.currentIndex == index
                      ? ColorManager.primary
                      : ColorManager.white,
                ),
              )
          ]),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: GestureDetector(
              onTap: () {
                pageController.nextPage(
                    duration: const Duration(
                        milliseconds: AppConstants.sliderAnimationTime),
                    curve: Curves.ease);
              },
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(
                    color: ColorManager.coldOrange,
                    AssetsManager.rightArrow),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingSlider onboardingSlider;

  const OnboardingPage({super.key, required this.onboardingSlider});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
          child: Text(
            onboardingSlider.header,
            style:headline1.copyWith(color: ColorManager.primary),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        Image.asset(
          onboardingSlider.imagePath,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Text(
            onboardingSlider.body,
            style:bodyText1.copyWith(color: ColorManager.coldOrange),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
