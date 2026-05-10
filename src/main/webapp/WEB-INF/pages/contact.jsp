<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us — GymPulse</title>
    <meta name="description" content="Get in touch with the GymPulse team. We're here to help with memberships, classes, and anything else.">
</head>
<body class="bg-gradient-to-br from-zinc-950 via-zinc-900 to-black text-white min-h-screen flex flex-col font-sans antialiased">
<%@ include file="header.jsp" %>

<main class="flex-grow max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-10 pb-20">

    <!-- Hero -->
    <div class="mb-14 text-center">
        <div class="inline-flex items-center gap-2 px-3 py-1.5 bg-emerald-500/10 border border-emerald-500/20 rounded-full text-emerald-400 text-xs font-semibold uppercase tracking-widest mb-6">
            <span class="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse"></span>
            We're Here to Help
        </div>
        <h1 class="text-4xl md:text-5xl font-bold tracking-tight mb-4 bg-clip-text text-transparent bg-gradient-to-r from-white via-zinc-200 to-zinc-400">
            Get In Touch
        </h1>
        <p class="text-zinc-400 text-base max-w-xl mx-auto">
            Have a question about your membership, classes, or anything else? Send us a message and we'll get back to you within 24 hours.
        </p>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-5 gap-8">

        <!-- Left: Contact Info -->
        <div class="lg:col-span-2 space-y-4">

            <!-- Info Card -->
            <div class="relative overflow-hidden bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-3xl p-7">
                <div class="absolute -top-10 -left-10 w-40 h-40 bg-emerald-500/5 rounded-full blur-3xl pointer-events-none"></div>
                <h3 class="text-lg font-bold text-white mb-6 relative z-10">Contact Information</h3>
                <div class="space-y-5 relative z-10">
                    <div class="flex items-start gap-4">
                        <div class="w-9 h-9 rounded-xl bg-zinc-800 border border-zinc-700 flex items-center justify-center flex-shrink-0">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-zinc-400"><path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0Z"/><circle cx="12" cy="10" r="3"/></svg>
                        </div>
                        <div>
                            <p class="text-white text-sm font-medium">Our Location</p>
                            <p class="text-zinc-500 text-sm">123 Fitness Avenue, Suite 100<br>New York, NY 10001</p>
                        </div>
                    </div>
                    <div class="flex items-start gap-4">
                        <div class="w-9 h-9 rounded-xl bg-zinc-800 border border-zinc-700 flex items-center justify-center flex-shrink-0">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-zinc-400"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 13.9a19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 3.6 3h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L8.09 10a16 16 0 0 0 5.91 5.91l.82-.82a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 22 16.92z"/></svg>
                        </div>
                        <div>
                            <p class="text-white text-sm font-medium">Phone</p>
                            <p class="text-zinc-500 text-sm">+1 (555) 123-4567</p>
                        </div>
                    </div>
                    <div class="flex items-start gap-4">
                        <div class="w-9 h-9 rounded-xl bg-zinc-800 border border-zinc-700 flex items-center justify-center flex-shrink-0">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-zinc-400"><rect width="20" height="16" x="2" y="4" rx="2"/><path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"/></svg>
                        </div>
                        <div>
                            <p class="text-white text-sm font-medium">Email</p>
                            <p class="text-zinc-500 text-sm">support@gympulse.com</p>
                        </div>
                    </div>
                    <div class="flex items-start gap-4">
                        <div class="w-9 h-9 rounded-xl bg-zinc-800 border border-zinc-700 flex items-center justify-center flex-shrink-0">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-zinc-400"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                        </div>
                        <div>
                            <p class="text-white text-sm font-medium">Hours</p>
                            <p class="text-zinc-500 text-sm">Mon – Fri: 6:00 AM – 10:00 PM<br>Sat – Sun: 8:00 AM – 8:00 PM</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick FAQs -->
            <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-5 space-y-4">
                <h4 class="text-sm font-semibold text-zinc-400 uppercase tracking-widest">Quick Info</h4>
                <div class="border-t border-zinc-800 pt-4 space-y-3">
                    <div>
                        <p class="text-zinc-300 text-sm font-medium mb-0.5">Membership Inquiries</p>
                        <p class="text-zinc-500 text-xs">Contact us to learn about our plan options and pricing.</p>
                    </div>
                    <div>
                        <p class="text-zinc-300 text-sm font-medium mb-0.5">Class Scheduling</p>
                        <p class="text-zinc-500 text-xs">All bookings are managed via the member dashboard.</p>
                    </div>
                    <div>
                        <p class="text-zinc-300 text-sm font-medium mb-0.5">Technical Support</p>
                        <p class="text-zinc-500 text-xs">Issues with your account? Our team responds within 24h.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right: Contact Form -->
        <div class="lg:col-span-3">
            <div class="relative overflow-hidden bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-3xl p-8">
                <div class="absolute -bottom-16 -right-16 w-48 h-48 bg-white/3 rounded-full blur-3xl pointer-events-none"></div>
                <div class="relative z-10">
                    <h3 class="text-xl font-bold text-white mb-2">Send Us a Message</h3>
                    <p class="text-zinc-500 text-sm mb-8">Fill out the form below and we'll reach out as soon as possible.</p>

                    <!-- Flash messages are handled by the global toast system in footer.jsp -->


                    <form action="${pageContext.request.contextPath}/contact" method="POST" class="space-y-5">
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
                            <div>
                                <label class="block text-sm font-medium text-zinc-300 mb-2">Your Name</label>
                                <input type="text" name="name" id="contact-name" required placeholder="John Doe"
                                    class="w-full bg-zinc-800/60 border border-zinc-700 text-white placeholder-zinc-500 text-sm rounded-xl px-4 py-3 focus:outline-none focus:border-zinc-500 focus:ring-1 focus:ring-zinc-600 transition-all">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-zinc-300 mb-2">Email Address</label>
                                <input type="email" name="email" id="contact-email" required placeholder="you@example.com"
                                    class="w-full bg-zinc-800/60 border border-zinc-700 text-white placeholder-zinc-500 text-sm rounded-xl px-4 py-3 focus:outline-none focus:border-zinc-500 focus:ring-1 focus:ring-zinc-600 transition-all">
                            </div>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-zinc-300 mb-2">Subject</label>
                            <select name="subject" id="contact-subject"
                                class="w-full bg-zinc-800/60 border border-zinc-700 text-zinc-300 text-sm rounded-xl px-4 py-3 focus:outline-none focus:border-zinc-500 focus:ring-1 focus:ring-zinc-600 transition-all appearance-none">
                                <option value="general">General Inquiry</option>
                                <option value="membership">Membership Question</option>
                                <option value="classes">Class Information</option>
                                <option value="technical">Technical Support</option>
                                <option value="billing">Billing Issue</option>
                            </select>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-zinc-300 mb-2">Message</label>
                            <textarea name="message" id="contact-message" rows="5" required placeholder="How can we help you?"
                                class="w-full bg-zinc-800/60 border border-zinc-700 text-white placeholder-zinc-500 text-sm rounded-xl px-4 py-3 focus:outline-none focus:border-zinc-500 focus:ring-1 focus:ring-zinc-600 transition-all resize-none"></textarea>
                        </div>
                        <button type="submit" id="contact-submit"
                            class="w-full py-3.5 bg-white text-black font-semibold text-sm rounded-xl hover:bg-zinc-200 active:scale-[0.98] transition-all shadow-lg">
                            Send Message
                        </button>
                    </form>
                </div>
            </div>
        </div>

    </div>
</main>

<%@ include file="footer.jsp" %>
</body>
</html>
