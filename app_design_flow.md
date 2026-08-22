# 🎨 E-Commerce App — Complete Design System (Deep Dive)

---

## 1. DESIGN PHILOSOPHY

| Principle | Description |
|---|---|
| **Premium Green Theme** | Deep forest green as primary — trustworthy, fresh, eco |
| **White-first backgrounds** | All pages use `Colors.white` — clean & minimal |
| **Gradient as energy** | Buttons, badges, strips use green gradient — adds life |
| **Rounded corners everywhere** | 8–24px radius — soft, approachable feel |
| **Consistent 16px padding** | Left/right padding uniform across all pages |
| **Dark text on light bg** | `#1F2937` headings, `#6B7280` subtitles — high contrast |

---

## 2. COLOR SYSTEM

### Primary Brand Colors
| Name | Hex | Usage |
|---|---|---|
| `primary1` / `primary2` | `#0F6B43` | Buttons, icons, borders, chips, indicators |
| `gradientStart` | `#0F6B43` | Gradient left/start |
| `gradientEnd` | `#37C87A` | Gradient right/end |
| `buttonColor` | `#0F6B43` | ElevatedButton theme override |
| `appBarColor` | `#0F6B43` | Legacy AppBar bg |
| `appDrawerColor` | `#0A5234` | Drawer background (darker green) |

### Text Colors
| Name | Hex | Usage |
|---|---|---|
| `black` | `#111111` | Pure black (rarely used) |
| `black1` | `#1F2937` | Headings, primary text |
| `black2` | `#6B7280` | Subtitles, muted text, labels |
| `blackHeading` | `#111827` | Section titles |
| `muteIconColor` | `#9CA3AF` | Placeholder icons, timestamps |

### Background Colors
| Name | Hex | Usage |
|---|---|---|
| `white` | `#FFFFFF` | Page backgrounds |
| `white1` | `#F9FAFB` | Card backgrounds, input fills |
| `white2` | `#E5E7EB` | Borders, dividers |
| `body` | `#F4FBF7` | Light green tint (body bg) |
| `greyLight` | `#D1D5DB` | Disabled states |
| `divider` | `#E5E7EB` | Horizontal dividers |
| `cardBackground` | `#FFFFFF` | Card surface |

### Status / Semantic Colors
| Name | Hex | Usage |
|---|---|---|
| `success` | `#0F6B43` | Order placed, in-stock, applied coupon |
| `warning` | `#D97706` | Expiry labels, low-stock |
| `error` | `#B42318` | Delete, expired coupons, remove buttons |
| `info` | `#2563EB` | Info banners, order notifications |
| `yellowStarColor` | `#F5B301` | Star ratings |

### Section Background Colors (Home page)
| Section | Color |
|---|---|
| Categories | `#F1F9FF` (light blue tint) |
| Featured Products | `#FFF7EE` (warm cream) |
| Top Products | `#EEFCEF` (light green) |
| Recent Viewed | `#F5F3FF` (soft lavender) |
| Top Rated | `#EFF7FF` (sky blue) |
| Hot Offers | `#FFF9E8` (warm amber) |
| Benefits | `#FFF2F6` (light rose) |

---

## 3. TYPOGRAPHY SYSTEM

### Font Scale
| Level | Size | Weight | Usage |
|---|---|---|---|
| H1 | 28px | `w800` | Page hero titles ("Best offers for you") |
| H2 | 20px | `w700` | Section titles, screen names |
| H3 | 18px | `w700` | Card titles, coupon codes |
| H4 | 17px | `w700` | AppBar title (`PremiumAppBar`) |
| H5 | 16px | `w600`–`w700` | Sub-section headings |
| Body | 14px | `w500`–`w600` | Product names, card descriptions |
| Small | 13px | `w400`–`w500` | Subtitles, unlock messages |
| Caption | 11–12px | `w500`–`w600` | Timestamps, badges, expiry labels |
| Tiny | 9–10px | `w700`–`w800` | Code chips (letterSpacing: 1.2), micro-badges |

### Text Styles Class (`AppTextStyle`)
```dart
AppTextStyle.headingH1('H1')    // 18px w600 (legacy naming)
AppTextStyle.mutedTextLabel()   // 9px w500 #6B7280
AppTextStyle.cardTitleStyle()   // used in section headers
AppTextStyle.fs12Black600()     // 12px w600 black1
AppTextStyle.drawerMenuStyle()  // 16px w600 white
```

---

## 4. BUTTON SYSTEM

All buttons via `ThemeData.elevatedButtonTheme` (global — auto-applies):

### ElevatedButton (Primary CTA)
```
Gradient: #0F6B43 → #37C87A (top-left to bottom-right)
Border radius: 10px
Padding: horizontal 24, vertical 13
Text: white, w700
Disabled: grey gradient
Ripple overlay: white 12% opacity
```

### OutlinedButton (Secondary)
```
Border: 1.5px solid #0F6B43
Text color: #0F6B43
Border radius: 10px
Padding: horizontal 24, vertical 13
```

### TextButton
```
Text color: #0F6B43
Used for: "T&Cs Apply", "Mark all read", "View All"
```

### Custom Gradient Button (inline)
Used in coupon Apply button, Shop Now buttons:
```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(colors: [gradientStart, gradientEnd]),
    borderRadius: BorderRadius.circular(20),
  ),
  child: Text(...)
)
```

---

## 5. SPACING SYSTEM

### Standard Padding
| Constant | Value | Usage |
|---|---|---|
| `AppPadding.hPad` | `16.0` | Standard horizontal page padding |
| `AppPadding.pageH` | `EdgeInsets.symmetric(horizontal: 16)` | Page-level padding |
| `AppPadding.pageScroll` | `EdgeInsets.symmetric(h: 16, v: 16)` | Scroll view padding |
| Card padding | `EdgeInsets.all(14–18)` | Inside all cards |
| Section gap | `SizedBox(height: 22–24)` | Between home sections |
| Item gap | `SizedBox(height: 12–14)` | Between list items |

### Responsive Padding (`ResponsiveContent`)
| Device | Horizontal Padding |
|---|---|
| Mobile (`< 600px`) | `16px` |
| Tablet (`600–1024px`) | `20px` |
| Desktop (`> 1440px`) | `28px` |

---

## 6. BORDER RADIUS SYSTEM

| Radius | Used For |
|---|---|
| `4–6px` | Timer boxes, tiny chips, expiry badges |
| `8–10px` | Buttons, code chips, input fields |
| `12px` | Applied coupon banner, notification cards |
| `14px` | Category card images, list card images |
| `16px` | Product cards, coupon cards, offer cards |
| `18px` | Coupon ticket cutout area |
| `20px` | Home section containers, pill buttons |
| `22–24px` | Bottom sheets (top corners), home banner |
| `25–26px` | Search bar (pill shape) |

---

## 7. SHADOW SYSTEM

### Card Shadow (standard)
```dart
BoxShadow(
  color: Colors.black.withOpacity(0.05–0.08),
  blurRadius: 12–16,
  offset: Offset(0, 4–6),
)
```

### Gradient Shadow (brand cards)
```dart
BoxShadow(
  color: gradientStart.withOpacity(0.08–0.32),
  blurRadius: 16–18,
  offset: Offset(0, 6–7),
)
```

### AppBar Shadow (PremiumAppBar)
```dart
BoxShadow(
  color: primary1.withOpacity(0.06),
  blurRadius: 10,
  offset: Offset(0, 3),
)
// + bottom border: BorderSide(color: #EEEEEE, width: 1)
```

---

## 8. COMPONENT DESIGN SPECS

### PremiumAppBar
```
Background: White
Bottom border: 1px #EEEEEE
Shadow: green-tinted 6% opacity
Back button: green circle (8% opacity bg) + green icon
Title: 17px w700 #1F2937
Actions: green text/icons
```

### PremiumProductCard
```
Size: ~178px wide (mobile) / 205px (tablet) / 230px (desktop)
Image: top 60% of card, rounded top corners
Discount badge: gradient orange-red pill (top-left)
Wishlist: white circle with pink heart (top-right)
Name: 12px w600, maxLines: 2, ellipsis, SizedBox(width: inf)
Rating: star (yellow) + score + count (grey)
Price: 14px w800 green
Original price: 11px grey strikethrough
Border radius: 20px
Shadow: black 6% / blurRadius 12
```

### PremiumCategoryCard
```
Size: 90x110px
showOverlay: true → full-image bg + text at bottom
Name: 12px bold white, maxLines: 2, SizedBox(w: inf)
"Explore" label: 10px white 70% opacity
Hover: scale 1.03 with shadow boost (AnimatedBuilder)
Border radius: 18px
```

### PremiumBottomBar
```
Background: white
Border: 1px #EDEDED
Border radius: 22px (floating pill)
Margin: 12px horizontal, 10px bottom
Shadow: 2-layer (primary 12% + 5%)
Height: 70px (NavigationBar)
Active indicator: primary 14% opacity
Active label: primary color, w700
Inactive: #333333, w500
```

### _CouponCard
```
Height: auto (minHeight: 96px)
Strip width: 76px (left for even, right for odd)
Strip: gradient top→bottom (4 unique per coupon)
Discount text: rotated ±90°, 14px w800 white
Ticket cutouts: 20px white circles (left or right edge)
Border: dotted (_DottedBorderPainter) — color from gradient
Applied state: green dotted border 1.8px
Expired state: grey strip + 65% opacity
```

---

## 9. ANIMATION SYSTEM

### Home Banner (auto-scroll)
```
Timer: 3 sec periodic
Transition: PageView animateToPage 500ms easeInOut
Indicators: AnimatedContainer width 6→20px
```

### PromoOffersSection
```
Shimmer: LinearGradient shift -1.8 → +2.2 (1600ms repeat)
Pulse glow: BoxShadow opacity 0.28→0.48 (1200ms reverse)
Discount badge: border opacity 0.30→0.70 (pulsing)
Auto-scroll: 3 sec Timer
```

### FlashSaleSection
```
Countdown: Timer.periodic 1sec, state updates HH:MM:SS
```

### DealOfTheDaySection
```
Countdown: Duration -= 1sec every second
Progress bar: LinearProgressIndicator value: 0.73 (static)
```

### PremiumCategoryCard
```
MouseRegion hover → AnimationController 0→1 (250ms)
Scale: 1.0 → 1.03
Shadow elevation: 3 → 8
```

### Notification Card
```
Dismissible: endToStart swipe → red delete reveal
```

---

## 10. RESPONSIVE BREAKPOINTS

| Breakpoint | Width | Grid Cols | Max Content Width |
|---|---|---|---|
| Mobile | `< 600px` | 2 | full width |
| Tablet | `600–1024px` | 3–4 | 1120px |
| Desktop | `> 1440px` | 4–5 | 1320px |

### Responsive Grid Count Examples
| Page | Mobile | Tablet | Desktop |
|---|---|---|---|
| Product Listing | 2 col | 3 col | 4 col |
| Categories Page | 2 col | 3–4 col | 5 col |
| Search Page | 2 col | 3–4 col | 5 col |
| Home strips | 178px cards | 205px cards | 230px cards |

---

## 11. ICON SYSTEM

All icons from `Icons.*` (Material Design):
| Category | Icons Used |
|---|---|
| Navigation | `home_filled`, `shopping_cart`, `person` |
| Actions | `copy_rounded`, `close_rounded`, `arrow_back_ios_new_rounded` |
| Notifications | `shopping_bag_rounded`, `local_offer_rounded`, `celebration_rounded` |
| Coupon | `gavel_rounded`, `bolt_rounded`, `card_giftcard_rounded` |
| AppBar | `view_list_rounded`, `grid_view_rounded`, `tune_rounded` |
| Status | `check_circle_rounded`, `warning_amber_rounded`, `timer_outlined` |

---

## 12. INPUT DESIGN

### Search Bar (Home)
```
Height: 52px
Border radius: 26px (pill)
Background: gradient overlay (dark → light grey) + white fill
Prefix: search icon grey
Suffix: green circle with tune icon
Shadow: black 8% / blurRadius 20
```

### Standard Text Field
```
Fill: AppColors.body (#F4FBF7) or white
Border: none (InputBorder.none)
Border radius: 5–26px depending on context
Content padding: vertical 15
```

---

## 13. EMERGENCY BANNER (Dynamic)

```
Trigger: HomeController.showEmergencyBanner = true
Color: #FF3B30 at 18% opacity bg + 55% border
Icon: warning_amber_rounded (red, 15px)
Text: 11px w600 red, height 1.3
Close: ✕ button (14px red icon)
Header height: 130px → 172px (animated via Obx)
```

---

## 14. DESIGN FILES LOCATION

```
lib/shared/style/
  ├── app_colors.dart      ← All color constants
  ├── app_text_style.dart  ← Typography methods
  ├── app_padding.dart     ← Spacing constants (hPad=16)
  ├── app_style.dart       ← Barrel export
  └── app_input_decoration.dart

lib/shared/widgets/
  ├── premium_app_bar.dart       ← Standard page header
  ├── premium_bottom_bar.dart    ← Floating nav bar
  ├── premium_product_card.dart  ← Product grid/list card
  ├── premium_category_card.dart ← Category grid card
  └── app_toast.dart             ← Success/error toasts

lib/init_app.dart
  └── ThemeData
        ├── elevatedButtonTheme  ← Global gradient button
        ├── outlinedButtonTheme  ← Global green border button
        └── textButtonTheme      ← Global green text button
```


---

## STEP 1 — App Launch
- **Splash Screen** (`/splash`)
  - App logo + animation (2–3 sec)
  - Check: local token exists?
    - ✅ Token found → go to `/home`
    - ❌ No token → go to `/onboarding` (first install) or `/login`

---

## STEP 2 — Onboarding (First Time Only)
- **Onboarding Screen** (`/onboarding`)
  - 3–4 intro slides (features/benefits)
  - "Get Started" → `/signup`
  - "Already have account" → `/login`

---

## STEP 3 — Authentication

### 3A. Signup (`/signup`)
- Name, Email, Phone, Password
- OTP verification
- Success → `/home`

### 3B. Login (`/login`)
- Email + Password
- "Forgot Password?" → `/forgotPassword`
- Success → `/home`

### 3C. Forgot Password (`/forgotPassword`)
- Enter email → OTP → New Password
- Success → `/login`

---

## STEP 4 — Home Page (`/home`)
Main hub. Contains these sections (top to bottom):

| # | Section | Action |
|---|---|---|
| Header | Greeting + Search bar + Bell icon | → Search / Notifications |
| [1] | Banner Slider (auto-scroll) | → Product Listing |
| [2] | Promo Offers (animated auto-scroll) | → `/products` |
| [3] | Categories (horizontal scroll) | → Category filter |
| Flash Sale | Countdown timer + products | → Product Details |
| [5] | Top Products | → Product Details |
| Deal of Day | Dark card + progress bar + timer | → Product Details |
| [6] | Recent Viewed Products | → Product Details |
| [7] | Top Rated Products | → Product Details |
| [8] | Hot Offers (gradient cards) | → `/specialOffers` |
| Brands | Top Brand logos | → Product Listing |
| [9] | Shopping Benefits | Static info |

**Bottom Nav Bar:**
- 🏠 Home (current)
- 🛒 Cart → `/cart`
- 👤 Profile → `/profile`

**App Drawer (hamburger):**
- Profile, Orders, Wishlist, Coupons, Address, Settings, Support, Logout

---

## STEP 5 — Product Discovery

### 5A. Search (`/search`)
- Search bar + filter icon
- Recent searches (chips)
- Category filter chips
- Grid / List toggle (top-right icon)
- Product grid (MasonryGridView) → Product Details

### 5B. Product Listing (`/products`)
- Simple header: Back + "Products" + Grid/List toggle
- Filter button → Filter bottom sheet (Category, Brand, Price slider, Rating)
- Sort button → Sort bottom sheet (Popular, Price ↑↓, Rating, Newest)
- Grid view: `PremiumProductCard` (image, name, rating, price, discount badge)
- List view: horizontal card (image + details)
- Tap card → Product Details

### 5C. Categories Page (`/categories`)
- Grid of category cards (image + name)
- Tap → Product Listing (filtered)

---

## STEP 6 — Product Details (`/productDetails`)
- Image gallery (swipeable)
- Name, Rating, Price, Original price, Discount %
- Description / Specs
- Reviews section
- "Add to Cart" button → Cart
- "Buy Now" → Checkout (skip cart)
- Wishlist icon toggle

---

## STEP 7 — Cart (`/cart`)
- List of cart items (image, name, qty controls, delete)
- Order Summary:
  - Sub Total
  - Coupon discount (if applied, auto-computed from `CouponController`)
  - Shipping: ₹8
  - **Total Amount** (dynamic = subtotal − coupon + shipping)
- "Apply Coupon" → `/coupon`
- "Proceed to Checkout" → `/checkout`

---

## STEP 8 — Coupon Page (`/coupon`)
- "Best offers for you" heading
- Applied coupon banner (if active) + Remove button
- Coupon cards (even = strip left / odd = strip right, dotted border):
  - Gradient strip with discount text
  - Code chip + Copy button (clipboard + toast)
  - Unlock condition text
  - Expiry badge (orange if active, red if expired)
  - T&Cs Apply → Bottom sheet dialog with full T&C
  - **Apply** button → applies coupon to `CouponController.appliedCouponCode`
    - Cart total updates automatically (real-time)
  - **Remove** button (if already applied)
- Expired coupons → greyed out, no Apply/Copy
- Back → Cart (discount reflected)

---

## STEP 9 — Checkout (`/checkout`)
- Delivery address selection / add new
- Order summary review
- Payment method selection
- Place Order → `/payment`

---

## STEP 10 — Payment (`/payment`)
- Payment gateway (Razorpay integrated)
- UPI / Card / NetBanking / COD
- Success → `/paymentSuccess`
- Failure → Retry / Back

---

## STEP 11 — Post-Order

### 11A. Payment Success (`/paymentSuccess`)
- Order placed animation
- Order ID
- "Track Order" → Orders list
- "Continue Shopping" → Home

### 11B. Order Confirmation (`/orderConfirmation`)
- Full order summary
- Estimated delivery date

---

## STEP 12 — Orders (`/orders`)
- List of all orders (date, status, amount)
- Tap → Order Details (`/orderDetails`)
  - Item list, tracking timeline, invoice download

---

## STEP 13 — Profile & Account (`/profile`)
- Avatar, Name, Email, Phone
- Quick links: Orders, Wishlist, Address, Coupons
- Settings → `/settings`
- Logout

---

## STEP 14 — Supporting Pages

| Page | Route | Purpose |
|---|---|---|
| Wishlist | `/wishlist` | Saved/liked products |
| Address | `/address` | Manage delivery addresses |
| Change Password | `/changePassword` | Secure account (SVG illustration at top) |
| Settings | `/settings` | Theme, Language, Notifications prefs |
| Notifications | `/notifications` | Mark read, swipe to delete, empty state |
| Invite Friends | `/inviteFriends` | Referral code sharing |
| Support | `/support` | FAQ / Chat / Call |
| Special Offers | `/specialOffers` | All active promo deals |
| Privacy Policy | `/privacyPolicy` | Static legal page |

---

## App State Flow Summary

```
Launch
  └─ Splash
       ├─ [new user] → Onboarding → Signup → Home
       └─ [returning] → Login → Home
                              └─ Home (hub)
                                   ├─ Browse → Search / Category / Product Listing
                                   │              └─ Product Details
                                   │                    └─ Add to Cart
                                   │                         └─ Cart
                                   │                              ├─ Coupon (apply discount)
                                   │                              └─ Checkout
                                   │                                   └─ Payment
                                   │                                        └─ Payment Success
                                   │                                             └─ Orders
                                   └─ Profile
                                        ├─ Wishlist
                                        ├─ Address
                                        ├─ Change Password
                                        ├─ Settings
                                        ├─ Notifications
                                        └─ Support
```

---

## Key Data Flows

| Action | From Controller | To Controller |
|---|---|---|
| Apply Coupon | `CouponController.appliedCouponCode` | `CartController.couponDiscount` |
| Cart badge count | `CartController.itemCount` | `PremiumBottomBar` (Home) |
| Emergency banner | `HomeController.showEmergencyBanner` | Header overlay |
| Notifications unread | `NotificationController.hasUnread` | AppBar "Mark all read" |


    
