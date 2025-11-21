import 'package:get/get.dart';
import 'package:des/routes/app_routes.dart';
import 'package:des/screens/bookings_screen.dart';

import 'package:des/screens/edit_profile_screen.dart';
import 'package:des/screens/favorites_screen.dart';
import 'package:des/screens/forgot_password_screen.dart';
import 'package:des/screens/help_screen.dart';
import 'package:des/screens/home_screen.dart';

import 'package:des/screens/login_screen.dart';
import 'package:des/screens/notifications_screen.dart';

import 'package:des/screens/profile_screen.dart';
import 'package:des/screens/register_screen.dart';
import 'package:des/screens/bookings_screen.dart';
import 'package:des/screens/settings_screen.dart';
import 'package:des/screens/special_offers_screen.dart';


class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.LOGIN, page: () => LoginScreen()),
    GetPage(name: AppRoutes.REGISTER, page: () => RegisterScreen()),
    GetPage(name: AppRoutes.FORGOT_PASSWORD, page: () => ForgotPasswordScreen()),
    GetPage(name: AppRoutes.HOME, page: () => HomeScreen()),
   // GetPage(name: AppRoutes.SEARCH, page: () => SearchScreen()),
    GetPage(name: AppRoutes.BOOKINGS, page: () => BookingsScreen()),
    GetPage(name: AppRoutes.PROFILE, page: () => ProfileScreen()),
    GetPage(name: AppRoutes.NOTIFICATIONS, page: () => NotificationsScreen()),
    GetPage(name: AppRoutes.SETTINGS, page: () => SettingsScreen()),
    GetPage(name: AppRoutes.EDIT_PROFILE, page: () => EditProfileScreen()),
    GetPage(name: AppRoutes.HELP, page: () => HelpScreen()),
    GetPage(name: AppRoutes.FAVORITES, page: () => FavoritesScreen()),
    GetPage(name: AppRoutes.SPECIAL_OFFERS, page: () => SpecialOffersScreen()),
    // GetPage(name: AppRoutes.OFFER_DETAILS, page: () => OfferDetailsScreen()),
    // GetPage(name: AppRoutes.HOTEL_DETAILS, page: () => HotelDetailsScreen()),
    // GetPage(name: AppRoutes.ROOM_DETAILS, page: () => RoomDetailsScreen()),
     GetPage(name: AppRoutes.BOOKING, page: () => BookingsScreen()),
    // GetPage(name: AppRoutes.PAYMENT, page: () => PaymentScreen()),
    // GetPage(name: AppRoutes.CONFIRMATION, page: () => ConfirmationScreen()),
    // GetPage(name: AppRoutes.BOOKING_DETAILS, page: () => BookingDetailsScreen()),
  ];
}