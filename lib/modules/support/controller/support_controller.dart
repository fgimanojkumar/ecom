import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportController extends GetxController {
  final RxString searchText = ''.obs;
  final RxInt selectedTabIndex = 1.obs;
  final RxInt expandedContactIndex = 1.obs;

  final contactItems = <Map<String, String>>[
    {
      'title': 'Customer Service',
      'icon': 'headset',
      'detail': '',
    },
    {
      'title': 'WhatsApp',
      'icon': 'whatsapp',
      'detail': '(480) 555-0103',
    },
    {
      'title': 'Website',
      'icon': 'website',
      'detail': '',
    },
    {
      'title': 'Facebook',
      'icon': 'facebook',
      'detail': '',
    },
    {
      'title': 'X',
      'icon': 'x',
      'detail': '',
    },
    {
      'title': 'Instagram',
      'icon': 'instagram',
      'detail': '',
    },
  ].obs;

  final faqItems = [
    {
      'question': 'How do I return a product?',
      'answer':
          'You can return a product within 30 days of purchase. Go to My Orders, select the order, and click Return.',
      'expanded': false,
    },
    {
      'question': 'What are the shipping charges?',
      'answer':
          'Free shipping is available on orders above ₹500. Otherwise, shipping charges are ₹50.',
      'expanded': false,
    },
    {
      'question': 'How can I track my order?',
      'answer':
          'You can track your order from the My Orders section by clicking on the specific order.',
      'expanded': false,
    },
    {
      'question': 'What payment methods do you accept?',
      'answer':
          'We accept Razorpay, Debit Card, Credit Card, UPI, and Wallet payments.',
      'expanded': false,
    },
  ].obs;

  final messages = <Map<String, String>>[].obs;
  final messageController = TextEditingController();

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void updateSearch(String value) {
    searchText.value = value;
  }

  void setSelectedTab(int index) {
    selectedTabIndex.value = index;
  }

  void toggleContact(int index) {
    if (expandedContactIndex.value == index) {
      expandedContactIndex.value = -1;
      return;
    }
    expandedContactIndex.value = index;
  }

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      messages.add({
        'text': messageController.text,
        'sender': 'user',
        'time': DateTime.now().toString(),
      });
      messageController.clear();

      // Simulate bot response
      Future.delayed(const Duration(seconds: 1), () {
        messages.add({
          'text':
              'Thanks for your message. Our support team will get back to you soon.',
          'sender': 'bot',
          'time': DateTime.now().toString(),
        });
      });
    }
  }

  void toggleExpanded(int index) {
    faqItems[index]['expanded'] = !(faqItems[index]['expanded'] as bool);
    faqItems.refresh();
  }
}
