# 📚 Bookia
**Developed by Hassan Elbalashony**

**Bookia** is a modern, feature-rich mobile bookstore application built with **Flutter**, allowing users to browse, search, explore detailed book previews, manage their shopping cart, and customize their profile seamlessly.

---

## ✨ Key Features
- 🔐 **Authentication:** Secure login workflow with custom input validation (`RegExp`) and persistent session/token storage.
- 🏠 **Home & Search:** Browse featured books and search through the catalog in real time.
- 📖 **Rich Book Details:** Detailed book views featuring sliver app bars, metadata statistics, expandable descriptions, and shimmer loading states.
- 🛒 **Shopping Cart & Checkout:** Full cart management to add, update, and order books effortlessly with empty/error/shimmer states.
- 👤 **User Profile & Settings:** Complete profile management with user info sections, action buttons, and logout confirmation dialog.
- 🌍 **Localization & Custom Theming:** Multi-language support and unified color/typography system with auto-generated asset references (`flutter_gen`).
- 🏗️ **Clean Feature-First Architecture:** Modular codebase powered by `flutter_bloc` (Cubit) and `Dio`.

---

## 📱 App Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/ddeab9b4-992d-4b8e-9232-635575bbedab" width="220" alt="Splash Screen" />
  <img src="https://github.com/user-attachments/assets/8daff144-5fc4-4bcb-ab9a-0c932a314448" width="220" alt="Welcome Screen" />
  <img src="https://github.com/user-attachments/assets/ef10cc6f-cc7a-4ecb-8faf-5403c88e9865" width="220" alt="Login Screen" />
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/321a06c4-ca14-4ba5-af80-bb4f3640f22e" width="220" alt="Home Screen" />
  <img src="https://github.com/user-attachments/assets/cea69730-1c4d-45b2-a8a3-b6b9b125f585" width="220" alt="Search Screen" />
  <img src="https://github.com/user-attachments/assets/5ca820c2-34a2-4848-9449-b3fabbf8cccc" width="220" alt="Book Details" />
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/88077477-4ec0-48e3-a5d1-53da47f89acf" width="220" alt="Book Description" />
  <img src="https://github.com/user-attachments/assets/374648cc-99a9-410a-9b92-651c24be6956" width="220" alt="Shopping Cart" />
  <img src="https://github.com/user-attachments/assets/4468f452-da74-4d99-9a22-2cc9f5947679" width="220" alt="Checkout & Profile" />
</p>

---

## 📂 Project Structure

```text
bookia/
├── assets/                       # Images, icons, and custom fonts
├── lib/
│   ├── main.dart                 # Application entry point
│   ├── bookia_app.dart           # Root widget (Theme, Routing, Localization)
│   │
│   ├── core/                     # Shared app-wide modules & utilities
│   │   ├── networking/           # Network configuration & Dio factory
│   │   │   └── dio_factory.dart
│   │   ├── routes/               # Navigation & route management
│   │   │   ├── app_router.dart
│   │   │   └── app_routes.dart
│   │   ├── services/             # Local storage & helper services
│   │   │   └── locale/
│   │   │       └── locale_helper.dart
│   │   ├── theam/                # App color palette & text styles
│   │   │   ├── app_color.dart
│   │   │   └── app_text_style.dart
│   │   ├── utils/                # Constants, RegExp validators & helpers
│   │   │   ├── app_const/
│   │   │   │   └── app_Const.dart
│   │   │   └── app_validator.dart
│   │   └── widgets/              # Reusable global UI components
│   │       ├── app_button.dart
│   │       └── custom_text_form.dart
│   │
│   ├── features/                 # Feature-First Architecture modules
│   │   │
│   │   ├── auth/                 # Authentication (Login & validation)
│   │   │   ├── data/
│   │   │   │   └── rebo/
│   │   │   │       └── auth_rebo.dart
│   │   │   └── presantation/
│   │   │       ├── cubit/
│   │   │       │   ├── auth_cubit.dart
│   │   │       │   └── auth_state.dart
│   │   │       └── ui/
│   │   │           ├── login_screen.dart
│   │   │           └── widgets/
│   │   │               └── login_form.dart
│   │   │
│   │   ├── welcom/               # Onboarding & Welcome screen
│   │   │   └── presantation/
│   │   │       └── ui/
│   │   │           └── welcom_screen.dart
│   │   │
│   │   ├── bottom_nav_bar/       # Bottom navigation bar controller
│   │   │   └── presentation/
│   │   │       └── ui/
│   │   │           └── bottom_nav_bar_screen.dart
│   │   │
│   │   ├── home/                 # Home feed & book search
│   │   │   ├── data/
│   │   │   │   └── models/
│   │   │   │       ├── books_model.dart
│   │   │   │       └── repo/
│   │   │   │           └── home_Repo.dart
│   │   │   └── presantation/
│   │   │       ├── cubit/
│   │   │       │   ├── home_cubit.dart
│   │   │       │   └── home_state.dart
│   │   │       └── ui/
│   │   │           ├── home_screen.dart
│   │   │           ├── search_screen.dart
│   │   │           └── widgets/
│   │   │               ├── book_iteam.dart
│   │   │               └── home_app_bar.dart
│   │   │
│   │   ├── book_details/         # Detailed book view & metadata
│   │   │   ├── data/
│   │   │   │   ├── model/
│   │   │   │   │   └── book_details_model.dart
│   │   │   │   └── repo/
│   │   │   │       └── book_details_repo.dart
│   │   │   └── presentations/
│   │   │       ├── cuibt/
│   │   │       │   ├── book_details_cubit.dart
│   │   │       │   └── book_details_state.dart
│   │   │       ├── ui/
│   │   │       │   └── book_details_screen.dart
│   │   │       └── widgets/
│   │   │           ├── book_bottom_action_bar.dart
│   │   │           ├── book_details_error_view.dart
│   │   │           ├── book_details_shimmer.dart
│   │   │           ├── book_details_sliver_app_bar.dart
│   │   │           ├── book_header_info.dart
│   │   │           ├── book_meta_stats.dart
│   │   │           └── expandable_description.dart
│   │   │
│   │   ├── cart/                 # Shopping cart & order management
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   └── cart_responce.dart
│   │   │   │   └── repo/
│   │   │   │       └── cart_repo.dart
│   │   │   └── presentation/
│   │   │       ├── cubit/
│   │   │       │   ├── cart_cubit.dart
│   │   │       │   └── cart_state.dart
│   │   │       └── ui/
│   │   │           ├── cart_screen.dart
│   │   │           └── widgets/
│   │   │               ├── cart_app_bar.dart
│   │   │               ├── cart_empty_view.dart
│   │   │               ├── cart_error_view.dart
│   │   │               ├── cart_item_card.dart
│   │   │               ├── cart_shimmer.dart
│   │   │               └── cart_summary_bar.dart
│   │   │
│   │   └── profile/              # User profile & account settings
│   │       ├── data/
│   │       │   ├── model/
│   │       │   │   └── profile_model.dart
│   │       │   └── repo/
│   │       │       └── profile_repo.dart
│   │       └── presentation/
│   │           ├── cubit/
│   │           │   ├── profile_cubit.dart
│   │           │   └── profile_state.dart
│   │           └── ui/
│   │               ├── profile_screen.dart
│   │               └── widgets/
│   │                   ├── logout_dialog.dart
│   │                   ├── profile_action_buttons.dart
│   │                   ├── profile_app_bar.dart
│   │                   ├── profile_error_view.dart
│   │                   ├── profile_header_card.dart
│   │                   ├── profile_info_section.dart
│   │                   ├── profile_menu_section.dart
│   │                   └── profile_shimmer.dart
│   │
│   └── gen/                      # Auto-generated asset & font references
│       ├── assets.gen.dart
│       └── fonts.gen.dart
