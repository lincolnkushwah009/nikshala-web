import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class TermsCondition extends StatelessWidget {
  // const TermsCondition({ Key? key }) : super(key: key);
  final String text = 'Terms of Use\n' +
      'These Terms of Use ("Terms") were last updated on July 12, 2021. \n' +
      'Nikshala’s mission is to improve student lives who are applying for higher education in Germany. We enable anyone anywhere to access that educational content to learn (students). We consider our marketplace model the best way to offer valuable educational content to our users. We need rules to keep our platform and services safe for you, us, and our student and instructor community. We also provide details regarding our processing of personal data of our students and instructors in our Privacy Policy \n' +
      'If you live in the India or Germany, by agreeing to these Terms, you agree to resolve disputes with Nikshala through binding arbitration (with very limited exceptions, not in court), and you waive certain rights to participate in class actions, as detailed in the Dispute Resolution section. \n' +
      'Table of Contents \n' +
      '1.	Accounts \n' +
      '2.	Content Enrollment and Lifetime Access \n' +
      '3.	Payments, Credits and Refunds\n' +
      '4.	Content and Behavior Rules \n' +
      '5.	Using Nikshala at Your Own Risk \n' +
      '6.	Nikshala’s Rights \n' +
      '7.	Miscellaneous Legal Terms \n' +
      '8.	Dispute Resolution \n' +
      '9.	Updating These Terms \n' +
      '10.	How to Contact Us \n' +
      '\n' +
      'Accounts \n' +
      'You need an account for most activities on our platform. Keep your password somewhere safe, because you’re responsible for all activity associated with your account. If you suspect someone else is using your account, let us know by contacting our Support team at nd@nikshala.com You must have reached the age of consent for online services in your country to use Nikshala. \n' +
      'You need an account for most activities on our platform, including to purchase and access content. When setting up and maintaining your account, you must provide and continue to provide accurate and complete information, including a valid email address. You have complete responsibility for your account and everything that happens on your account, including for any harm or damage (to us or anyone else) caused by someone using your account without your permission. This means you need to be careful with your password. You may not transfer your account to someone else or use someone else’s account. If you contact us to request access to an account, we will not grant you such access unless you can provide us with the information that we need to prove you are the owner of that account. In the event of the death of a user, the account of that user will be closed. \n' +
      'You may not share your account login credentials with anyone else. You are responsible for what happens with your account and Nikshala will not intervene in disputes between users who have shared account login credentials. You must notify us immediately upon learning that someone else may be using your account without your permission (or if you suspect any other breach of security) by contacting our support team at nd@nikshala.com. We may request some information from you to confirm that you are indeed the owner of your account. \n' +
      'User must be at least 13 years of age to create an account on Nikshala and use the Services. If you are younger than 13 but above the required age for consent to use online services where you live (for example, 13 in the US or 16 in Ireland), you may not set up an account, but we encourage you to invite a parent or guardian to open an account and help you access content that is appropriate for you. If you are below this age of consent to use online services, you may not create a Nikshala account. If we discover that you have created an account that violates these rules, we will terminate your account. \n' +
      'You can terminate your account at any time by following the steps. Check our Privacy Policy to see what happens when you terminate your account. \n' +
      'Content Enrollment and Lifetime Access \n' +
      'When you purchase a video, you get a license from us to view it via the Nikshala Services and no other use. Don’t try to transfer or resell content in any way. We generally grant you a specific time period access license. \n' +
      'when you enroll in a course or other content, whether it’s free or paid content, you are getting a license from Nikshala to view the content via the Nikshala platform and Services, and Nikshala is the licensor of record. Content is licensed, and not sold, to you. This license does not give you any right to resell the content in any manner (including by sharing account information with a purchaser or illegally downloading the content and sharing it on torrent sites). \n' +
      'In legal, more complete terms, Nikshala grants you (as a user) a limited, non-exclusive, non-transferable license to access and view the content for which you have paid all required fees, solely for your personal, non-commercial, educational purposes through the Services, in accordance with these Terms and any conditions or restrictions associated with the particular content or feature of our Services. All other uses are expressly prohibited. You may not reproduce, redistribute, transmit, assign, sell, broadcast, rent, share, lend, modify, adapt, edit, create derivative works of, sublicense, or otherwise transfer or use any content unless we give you explicit permission to do so in a written agreement signed by a Nikshala authorized representative. This also applies to content you can access via any of our APIs. \n' +
      'we reserve the right to revoke any license to access and use any content at any point in time in the event where we decide or are obligated to disable access to the content due to legal or policy reasons, for example if we determine it violates our Trust & Safety Guidlines.\n' +
      ' \n' +
      'Payments, Credits, and Refunds \n' +
      'When you make a payment, you agree to use a valid payment method. If you aren’t happy with your content. \n' +
      '	3.1 Pricing \n' +
      'The prices of content on Nikshala are determined based on the terms. In some instances, the price of content offered on the Nikshala website may not be exactly the same as the price offered on our mobile, due to mobile platform providers’ pricing systems and their policies around implementing sales and promotions. \n' +
      'We occasionally run promotions and sales for our content, during which certain content is available at discounted prices for a set period of time. The price applicable to the content will be the price at the time you complete your purchase of the content (at checkout). Any price offered for particular content may also be different when you are logged into your account from the price available to users who aren’t registered or logged in, because some of our promotions are available only to new users. \n' +
      'If you are logged into your account, the listed currency you see is based on your location when you created your account. If you are not logged into your account, the price currency is based on the country where you are located. We do not enable users to see pricing in other currencies. \n' +
      'If you are a user located in a country where use and sales tax, goods and services tax, or value added tax is applicable to consumer sales, we are responsible for collecting and remitting that tax to the proper tax authorities. Depending on your location, the price you see may include such taxes, or tax may be added at checkout. \n' +
      '	3.2 Payments \n' +
      'You agree to pay the fees for content that you purchase, and you authorize us to charge your debit or credit card or process other means of payment (such as Boleto, SEPA, direct debit, or mobile wallet) for those fees. Nikshala works with payment service providers to offer you the most convenient payment methods in your country and to keep your payment information secure. We may update your payment methods using information provided by our payment service providers. Check our Privacy Policy for more details. \n' +
      'When you make a purchase, you agree not to use an invalid or unauthorized payment method. If your payment method fails and you still get access to the content you are enrolling in, you agree to pay us the corresponding fees within thirty (30) days of notification from us. We reserve the right to disable access to any content for which we have not received adequate payment. \n' +
      ' \n' +
      '	3.3 Gift and Promotional Codes \n' +
      'Nikshala or our partners may offer gift and promotional codes to users. Certain codes may be redeemed for gift or promotional credits applied to your Nikshala account, which then may be used to purchase eligible content on our platform, subject to the terms included with your codes. Other codes may be directly redeemable for specific content. Gift and promotional credits can’t be used for purchases in our mobile or TV applications. \n' +
      'These codes and credits, as well as any promotional value linked to them, may expire if not used within the period specified in your Nikshala account. Gift and promotional codes offered by Nikshala may not be refunded for cash, unless otherwise specified in the terms included with your codes or as required by applicable law. \n' +
      'Content and Behavior Rules \n' +
      'You may not access or use the Services or create an account for unlawful purposes. Your use of the Services and behavior on our platform must comply with applicable local or national laws or regulations of your country. You are solely responsible for the knowledge of and compliance with such laws and regulations that are applicable to you. \n' +
      'We may restrict or terminate your permission to use our platform and Services or ban your account at any time, with or without notice, for any or no reason, including for any violation of these Terms, if you fail to pay any fees when due, for fraudulent chargeback requests, upon the request of law enforcement or government agencies, for extended periods of inactivity, for unexpected technical issues or problems, if we suspect that you engage in fraudulent or illegal activities, or for any other reason in our sole discretion. Upon any such termination we may delete your account and content, and we may prevent you from further access to the platforms and use of our Services. \n' +
      'Using Nikshala at Your Own Risk \n' +
      'By using the Services, you may be exposed to content that you consider offensive, indecent, or objectionable. Nikshala has no responsibility to keep such content from you and no liability for your access or enrolment in any course or other content, to the extent permissible under applicable law. This also applies to any content relating to health, wellness, and physical exercise. You acknowledge the inherent risks and dangers in the strenuous nature of these types of content, and by accessing such content you choose to assume those risks voluntarily, including risk of illness, bodily injury, disability, or death. You assume full responsibility for the choices you make before, during, and after your access to the content. \n' +
      'When you use our Services, you will find links to other websites that we don’t own or control. We are not responsible for the content or any other aspect of these third-party sites, including their collection of information about you. You should also read their terms and conditions and privacy policies. \n' +
      'Nikshala’s Rights \n' +
      'We own the Nikshala platform and Services, including the website, present or future apps and services, and things like our logos, API, code, and content created by our employees. You can’t tamper with those or use them without authorization. \n' +
      'All right, title, and interest in and to the Nikshala platform and Services, including our website, our existing or future applications, our APIs, databases, and the content our employees or partners submit or provide through our Services are and will remain the exclusive property of Nikshala and its licensors. Our platforms and services are protected by copyright, trademark, and other laws of both the India and foreign countries. Nothing gives you a right to use the Nikshala name or any of the Nikshala trademarks, logos, domain names, and other distinctive brand features. Any feedback, comments, or suggestions you may provide regarding Nikshala or the Services is entirely voluntary and we will be free to use such feedback, comments, or suggestions as we see fit and without any obligation to you. \n' +
      'You may not do any of the following while accessing or using the Nikshala platform and Services: \n' +
      'access, tamper with, or use non-public areas of the platform (including content storage), Nikshala’s computer systems, or the technical delivery systems of Nikshala’s service providers. \n' +
      'disable, interfere with, or try to circumvent any of the features of the platforms related to security or probe, scan, or test the vulnerability of any of our systems. \n' +
      'copy, modify, create a derivative work of, reverse engineer, reverse assemble, or otherwise attempt to discover any source code of or content on the Nikshala platform or Services. \n' +
      'access or search or attempt to access or search our platform by any means (automated or otherwise) other than through our currently available search functionalities that are provided via our website, mobile apps, or API (and only pursuant to those API terms and conditions). You may not scrape, spider, use a robot, or use other automated means of any kind to access the Services. \n' +
      'in any way use the Services to send altered, deceptive, or false source-identifying information (such as sending email communications falsely appearing as Nikshala); or interfere with, or disrupt, (or attempt to do so), the access of any user, host, or network, including, without limitation, sending a virus, overloading, flooding, spamming, or mail-bombing the platforms or services, or in any other manner interfering with or creating an undue burden on the Services. \n' +
      'Miscellaneous Legal Terms \n' +
      'These Terms are like any other contract, and they have boring but important legal terms that protect us from the countless things that could happen and that clarify the legal relationship between us and you. \n' +
      '	7.1 Binding Agreement \n' +
      'You agree that by registering, accessing, or using our Services, you are agreeing to enter into a legally binding contract with Nikshala. If you do not agree to these Terms, do not register, access, or otherwise use any of our Services. \n' +
      'Any version of these Terms in a language other than English is provided for convenience and you understand and agree that the English language will control if there is any conflict. \n' +
      'These Terms (including any agreements and policies linked from these Terms) constitute the entire agreement between you and us.\n' +
      'If any part of these Terms is found to be invalid or unenforceable by applicable law, then that provision will be deemed superseded by a valid, enforceable provision that most closely matches the intent of the original provision and the remainder of these Terms will continue in effect. \n' +
      'Even if we are delayed in exercising our rights or fail to exercise a right in one case, it doesn’t mean we waive our rights under these Terms, and we may decide to enforce them in the future. If we decide to waive any of our rights in a particular instance, it doesn’t mean we waive our rights generally or in the future. \n' +
      'The following sections shall survive the expiration or termination of these Terms: Sections 5 (Using Nikshala at Your Own Risk), 6 (Nikshala’s Rights), 8 (Miscellaneous Legal Terms), and 9 (Dispute Resolution). \n' +
      '	7.2 Disclaimers \n' +
      'It may happen that our platform is down, either for planned maintenance or because something goes down with the site. It may happen that one of our instructors is making misleading statements in their content. It may also happen that we encounter security issues. These are just examples. You accept that you will not have any recourse against us in any of these types of cases where things don’t work out right. In legal, more complete language, the Services and their content are provided on an “as is” and “as available” basis. We (and our affiliates, suppliers, partners, and agents) make no representations or warranties about the suitability, reliability, availability, timeliness, security, lack of errors, or accuracy of the Services or their content, and expressly disclaim any warranties or conditions (express or implied), including implied warranties of merchantability, fitness for a particular purpose, title, and non-infringement. We (and our affiliates, suppliers, partners, and agents) make no warranty that you will obtain specific results from use of the Services. Your use of the Services (including any content) is entirely at your own risk. Some jurisdictions don’t allow the exclusion of implied warranties, so some of the above exclusions may not apply to you. \n' +
      'We may decide to cease making available certain features of the Services at any time and for any reason. Under no circumstances will Nikshala or its affiliates, suppliers, partners or agents be held liable for any damages due to such interruptions or lack of availability of such features. \n' +
      'We are not responsible for delay or failure of our performance of any of the Services caused by events beyond our reasonable control, like an act of war, hostility, or sabotage; natural disaster; electrical, internet, or telecommunication outage; or government restrictions. \n' +
      '	7.3 Limitation of Liability \n' +
      'Nikshala is not giving any admission guarantee in any university, User should understand and agree that Nikshala is trying to help user to understand the specific university application process. \n' +
      '	7.4 Indemnification \n' +
      'If you behave in a way that gets us in legal trouble, we may exercise legal recourse against you. You agree to indemnify, defend (if we so request), and hold harmless Nikshala, our group companies, and their officers, directors, suppliers, partners, and agents from an against any third-party claims, demands, losses, damages, or expenses (including reasonable attorney fees) arising from (a) the content you post or submit, (b) your use of the Services (c) your violation of these Terms, or (d) your violation of any rights of a third party. Your indemnification obligation will survive the termination of these Terms and your use of the Services. \n' +
      '	7.5 Governing Law and Jurisdiction \n' +
      'When these Terms mention “Nikshala,” they’re referring to the Nikshala entity that you’re contracting with. If you’re a student, your contracting entity and governing law will generally be determined based on your location. \n' +
      'If you’re a user located in India, you’re contracting with Nikshala Private Limited and these Terms are governed by the laws of India, without reference to its choice or conflicts of law principles, and you consent to the exclusive jurisdiction and venue of the courts in Mumbai, India. \n' +
      'If you’re a user located in a geographical region other than India. \n' +
      '	7.6 Legal Actions and Notices \n' +
      'No action, regardless of form, arising out of or relating to this Agreement may be brought by either party more than one (1) year after the cause of action has accrued, except where this limitation cannot be imposed by law. \n' +
      'Any notice or other communication to be given hereunder will be in writing and given by registered or certified mail return receipt requested, or email (by us to the email associated with your account or by you to nd@nikshala.com). \n' +
      '	7.7 Relationship Between Us \n' +
      'You and we agree that no joint venture, partnership, employment, contractor, or agency relationship exists between us. \n' +
      '	7.8 No Assignment \n' +
      'You may not assign or transfer these Terms (or the rights and licenses granted under them). Nothing in these Terms confers any right, benefit, or remedy on any third-party person or entity. You agree that your account is non-transferable and that all rights to your account and other rights under these Terms terminate upon your death. \n' +
      '	7.9 Sanctions and Export Laws \n' +
      'You warrant that you (as an individual) aren’t located in, or a resident of, any country that is subject to applicable U.S. trade sanctions or embargoes (such as Cuba, Iran, North Korea, Sudan, Syria, or the Crimea region of Ukraine). You also warrant that you aren’t a person or entity who is named on any U.S. government specially designated national or denied-party list. \n' +
      'If you become subject to such a restriction during the term of any agreement with Nikshala, you will notify us within 24 hours, and we will have the right to terminate any further obligations to you, effective immediately and with no further liability to you (but without prejudice to your outstanding obligations to Nikshala). \n' +
      'You may not access, use, export, re-export, divert, transfer or disclose any portion of the Services or any related technical information or materials, directly or indirectly, in violation of any United States and other applicable country export control and trade sanctions laws, rules and regulations. You agree not to upload any content or technology (including information on encryption) whose export is specifically controlled under such laws. \n' +
      'Dispute Resolution \n' +
      'If there’s a dispute, our Support Team is happy to help resolve the issue. If that doesn’t work and you live in India, your options are to go to small claims court or bring a claim in binding arbitration; you may not bring that claim in another court or participate in a non-individual class action claim against us. \n' +
      'This Dispute Resolution section applies only if you live in India. Most disputes can be resolved, so before bringing a formal legal case, please first try contacting our Support Team.\n' +
      'Updating These Terms \n' +
      'From time to time, we may update these Terms to clarify our practices or to reflect new or different practices (such as when we add new features), and Nikshala reserves the right in its sole discretion to modify and/or make changes to these Terms at any time. If we make any material change, we will notify you using prominent means, such as by email notice sent to the email address specified in your account or by posting a notice through our Services. Modifications will become effective on the day they are posted unless stated otherwise. \n' +
      'Your continued use of our Services after changes become effective shall mean that you accept those changes. Any revised Terms shall supersede all previous Terms. \n' +
      'How to Contact Us \n' +
      'The best way to get in touch with us is to contact our Support Team. We’d love to hear your questions, concerns, and feedback about our Services. \n' +
      'Thanks for teaching and learning with us! \n' +
      '\n' +
      '\n' +
      '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Condition'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
      ),
    );
  }
}
