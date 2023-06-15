class OnBoardingScreenModel {
  final String title;
  final String description;
  final String image;

  OnBoardingScreenModel(
      {required this.title, required this.description, required this.image});
}

List<OnBoardingScreenModel> onBoardingScreenModels = [
  OnBoardingScreenModel(
      title: 'Hangout',
      description: 'Mau ngopi bareng temen tapi masih bingung cari tempat?',
      image: 'assets/svg/splash-icon.svg'),
  OnBoardingScreenModel(
      title: 'Coffee Shop',
      description: 'Atau pengen nyari coffee shop dengan pengalaman baru?',
      image: 'assets/svg/splash-icon.svg'),
  OnBoardingScreenModel(
      title: 'hiSpace',
      description: 'Kamu temukan semuanya di hiSpace',
      image: 'assets/svg/splash-icon.svg'),
];
