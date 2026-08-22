# 🛒 E-Commerce App — Complete Flow (A to Z)

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


    
