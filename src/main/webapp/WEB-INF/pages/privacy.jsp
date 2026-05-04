<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Privacy Policy — GymPulse</title>
    <meta name="description" content="GymPulse Privacy Policy — learn how we collect, use, and protect your personal information.">
</head>
<body class="bg-gradient-to-br from-zinc-950 via-zinc-900 to-black text-white min-h-screen flex flex-col font-sans antialiased">
<%@ include file="header.jsp" %>

<main class="flex-grow max-w-4xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-10 pb-20">

    <!-- Hero -->
    <div class="mb-12 text-center">
        <div class="inline-flex items-center gap-2 px-3 py-1.5 bg-zinc-800 border border-zinc-700 rounded-full text-zinc-400 text-xs font-semibold uppercase tracking-widest mb-6">
            <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
            Legal Document
        </div>
        <h1 class="text-4xl md:text-5xl font-bold tracking-tight mb-4 bg-clip-text text-transparent bg-gradient-to-r from-white via-zinc-200 to-zinc-400">
            Privacy Policy
        </h1>
        <p class="text-zinc-500 text-sm">Last updated: May 4, 2026 &nbsp;·&nbsp; Effective immediately</p>
    </div>

    <!-- Policy Content -->
    <div class="space-y-6">

        <!-- Intro -->
        <div class="bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-3xl p-7">
            <p class="text-zinc-400 text-sm leading-relaxed">
                At <span class="text-white font-semibold">GymPulse</span>, we are committed to protecting your privacy and handling your personal data with care and transparency. This Privacy Policy explains how we collect, use, store, and share information when you use our platform and services. By using GymPulse, you agree to the terms described in this policy.
            </p>
        </div>

        <!-- Section 1 -->
        <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-7 hover:border-zinc-700 transition-all">
            <div class="flex items-center gap-3 mb-4">
                <div class="w-8 h-8 rounded-xl bg-zinc-800 border border-zinc-700 flex items-center justify-center flex-shrink-0">
                    <span class="text-xs font-bold text-zinc-300">01</span>
                </div>
                <h2 class="text-lg font-bold text-white">Information We Collect</h2>
            </div>
            <div class="space-y-3 text-zinc-400 text-sm leading-relaxed">
                <p>We collect information that you provide directly to us, including:</p>
                <ul class="space-y-2 ml-4">
                    <li class="flex items-start gap-2"><span class="text-zinc-600 mt-1">—</span><span><span class="text-zinc-300">Account Information:</span> Full name, email address, and phone number when you register.</span></li>
                    <li class="flex items-start gap-2"><span class="text-zinc-600 mt-1">—</span><span><span class="text-zinc-300">Profile Data:</span> Profile images and preferences you set within your account.</span></li>
                    <li class="flex items-start gap-2"><span class="text-zinc-600 mt-1">—</span><span><span class="text-zinc-300">Transaction Data:</span> Membership plan details and payment records (we do not store raw card data).</span></li>
                    <li class="flex items-start gap-2"><span class="text-zinc-600 mt-1">—</span><span><span class="text-zinc-300">Usage Data:</span> Class bookings, login timestamps, and feature usage patterns.</span></li>
                </ul>
            </div>
        </div>

        <!-- Section 2 -->
        <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-7 hover:border-zinc-700 transition-all">
            <div class="flex items-center gap-3 mb-4">
                <div class="w-8 h-8 rounded-xl bg-zinc-800 border border-zinc-700 flex items-center justify-center flex-shrink-0">
                    <span class="text-xs font-bold text-zinc-300">02</span>
                </div>
                <h2 class="text-lg font-bold text-white">How We Use Your Information</h2>
            </div>
            <div class="space-y-2 text-zinc-400 text-sm leading-relaxed ml-4">
                <p class="flex items-start gap-2"><span class="text-zinc-600 mt-1">—</span><span>To create and manage your member account securely.</span></p>
                <p class="flex items-start gap-2"><span class="text-zinc-600 mt-1">—</span><span>To process membership subscriptions and class bookings.</span></p>
                <p class="flex items-start gap-2"><span class="text-zinc-600 mt-1">—</span><span>To send important notifications about your bookings and membership.</span></p>
                <p class="flex items-start gap-2"><span class="text-zinc-600 mt-1">—</span><span>To improve the platform based on how our services are used.</span></p>
                <p class="flex items-start gap-2"><span class="text-zinc-600 mt-1">—</span><span>To protect the safety and security of our users and platform.</span></p>
            </div>
        </div>

        <!-- Section 3 -->
        <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-7 hover:border-zinc-700 transition-all">
            <div class="flex items-center gap-3 mb-4">
                <div class="w-8 h-8 rounded-xl bg-zinc-800 border border-zinc-700 flex items-center justify-center flex-shrink-0">
                    <span class="text-xs font-bold text-zinc-300">03</span>
                </div>
                <h2 class="text-lg font-bold text-white">Data Security</h2>
            </div>
            <p class="text-zinc-400 text-sm leading-relaxed">
                We take security seriously. All passwords are encrypted using AES-128 before being stored in our database. We implement account lockout mechanisms to protect against brute-force attacks. Our platform uses HTTPS to ensure data is encrypted in transit. We regularly review our security practices and update them to address new threats.
            </p>
        </div>

        <!-- Section 4 -->
        <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-7 hover:border-zinc-700 transition-all">
            <div class="flex items-center gap-3 mb-4">
                <div class="w-8 h-8 rounded-xl bg-zinc-800 border border-zinc-700 flex items-center justify-center flex-shrink-0">
                    <span class="text-xs font-bold text-zinc-300">04</span>
                </div>
                <h2 class="text-lg font-bold text-white">Data Sharing & Third Parties</h2>
            </div>
            <p class="text-zinc-400 text-sm leading-relaxed">
                GymPulse does not sell, trade, or rent your personal information to third parties. We may share data only in the following circumstances: (1) with service providers who assist us in operating the platform under strict confidentiality, (2) when required by law or a valid legal process, or (3) to protect the rights, safety, and property of GymPulse or its users.
            </p>
        </div>

        <!-- Section 5 -->
        <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-7 hover:border-zinc-700 transition-all">
            <div class="flex items-center gap-3 mb-4">
                <div class="w-8 h-8 rounded-xl bg-zinc-800 border border-zinc-700 flex items-center justify-center flex-shrink-0">
                    <span class="text-xs font-bold text-zinc-300">05</span>
                </div>
                <h2 class="text-lg font-bold text-white">Cookies & Sessions</h2>
            </div>
            <p class="text-zinc-400 text-sm leading-relaxed">
                We use HTTP sessions to maintain your login state. Sessions expire after 30 minutes of inactivity for your security. We do not use third-party tracking cookies or advertising cookies. The only session data stored is the minimum required to authenticate you and provide a personalized experience.
            </p>
        </div>

        <!-- Section 6 -->
        <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-7 hover:border-zinc-700 transition-all">
            <div class="flex items-center gap-3 mb-4">
                <div class="w-8 h-8 rounded-xl bg-zinc-800 border border-zinc-700 flex items-center justify-center flex-shrink-0">
                    <span class="text-xs font-bold text-zinc-300">06</span>
                </div>
                <h2 class="text-lg font-bold text-white">Your Rights</h2>
            </div>
            <div class="space-y-2 text-zinc-400 text-sm leading-relaxed ml-4">
                <p class="flex items-start gap-2"><span class="text-zinc-600 mt-1">—</span><span><span class="text-zinc-300">Access:</span> You can view and update your personal information via your profile page at any time.</span></p>
                <p class="flex items-start gap-2"><span class="text-zinc-600 mt-1">—</span><span><span class="text-zinc-300">Correction:</span> You can request correction of inaccurate personal data held by us.</span></p>
                <p class="flex items-start gap-2"><span class="text-zinc-600 mt-1">—</span><span><span class="text-zinc-300">Deletion:</span> You can request deletion of your account by contacting our support team.</span></p>
                <p class="flex items-start gap-2"><span class="text-zinc-600 mt-1">—</span><span><span class="text-zinc-300">Portability:</span> You may request a copy of your personal data in a structured format.</span></p>
            </div>
        </div>

        <!-- Section 7 -->
        <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-7 hover:border-zinc-700 transition-all">
            <div class="flex items-center gap-3 mb-4">
                <div class="w-8 h-8 rounded-xl bg-zinc-800 border border-zinc-700 flex items-center justify-center flex-shrink-0">
                    <span class="text-xs font-bold text-zinc-300">07</span>
                </div>
                <h2 class="text-lg font-bold text-white">Changes to This Policy</h2>
            </div>
            <p class="text-zinc-400 text-sm leading-relaxed">
                We may update this Privacy Policy from time to time. Any changes will be posted on this page with an updated effective date. We encourage you to review this policy periodically. Continued use of GymPulse after changes are posted constitutes your acceptance of the updated policy.
            </p>
        </div>

        <!-- Contact CTA -->
        <div class="relative overflow-hidden bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-3xl p-8 text-center">
            <div class="absolute -bottom-10 -right-10 w-40 h-40 bg-emerald-500/5 rounded-full blur-3xl pointer-events-none"></div>
            <div class="relative z-10">
                <h3 class="text-lg font-bold text-white mb-2">Questions About This Policy?</h3>
                <p class="text-zinc-500 text-sm mb-6">If you have any concerns or questions about how we handle your data, please don't hesitate to reach out.</p>
                <a href="${pageContext.request.contextPath}/contact" id="privacy-contact-btn"
                   class="inline-flex items-center gap-2 px-6 py-3 bg-white text-black text-sm font-semibold rounded-xl hover:bg-zinc-200 active:scale-95 transition-all shadow-lg">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect width="20" height="16" x="2" y="4" rx="2"/><path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"/></svg>
                    Contact Us
                </a>
            </div>
        </div>

    </div>
</main>

<%@ include file="footer.jsp" %>
</body>
</html>
