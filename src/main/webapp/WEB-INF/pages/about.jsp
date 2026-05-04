<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us — GymPulse</title>
    <meta name="description" content="Learn about GymPulse — your modern fitness management platform built for serious athletes and gym owners.">
</head>
<body class="bg-gradient-to-br from-zinc-950 via-zinc-900 to-black text-white min-h-screen flex flex-col font-sans antialiased">
<%@ include file="header.jsp" %>

<main class="flex-grow max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-10 pb-20">

    <!-- Hero -->
    <div class="mb-16 text-center">
        <div class="inline-flex items-center gap-2 px-3 py-1.5 bg-emerald-500/10 border border-emerald-500/20 rounded-full text-emerald-400 text-xs font-semibold uppercase tracking-widest mb-6">
            <span class="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse"></span>
            Our Story
        </div>
        <h1 class="text-4xl md:text-6xl font-bold tracking-tight mb-4 bg-clip-text text-transparent bg-gradient-to-r from-white via-zinc-200 to-zinc-400">
            Built for Every Rep,<br>Every Goal.
        </h1>
        <p class="text-zinc-400 text-base md:text-lg max-w-2xl mx-auto leading-relaxed">
            GymPulse is a modern fitness management platform connecting gym owners, trainers, and members in one seamless ecosystem.
        </p>
    </div>

    <!-- Mission & Vision Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-12">
        <div class="relative overflow-hidden bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-3xl p-8 group hover:border-zinc-700 transition-all duration-300">
            <div class="absolute -top-10 -left-10 w-32 h-32 bg-emerald-500/10 rounded-full blur-3xl group-hover:bg-emerald-500/15 transition-all"></div>
            <div class="relative z-10">
                <div class="w-12 h-12 rounded-2xl bg-emerald-500/10 border border-emerald-500/20 flex items-center justify-center mb-5">
                    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-emerald-400"><path d="M12 22c5.523 0 10-4.477 10-10S17.523 2 12 2 2 6.477 2 12s4.477 10 10 10z"/><path d="m9 12 2 2 4-4"/></svg>
                </div>
                <h2 class="text-xl font-bold text-white mb-3">Our Mission</h2>
                <p class="text-zinc-400 text-sm leading-relaxed">We believe fitness should be accessible, organized, and motivating. GymPulse streamlines class scheduling, membership management, and progress tracking so you can focus on what matters — your health and goals.</p>
            </div>
        </div>

        <div class="relative overflow-hidden bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-3xl p-8 group hover:border-zinc-700 transition-all duration-300">
            <div class="absolute -top-10 -right-10 w-32 h-32 bg-white/5 rounded-full blur-3xl group-hover:bg-white/10 transition-all"></div>
            <div class="relative z-10">
                <div class="w-12 h-12 rounded-2xl bg-zinc-800 border border-zinc-700 flex items-center justify-center mb-5">
                    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-zinc-300"><path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z"/><circle cx="12" cy="12" r="3"/></svg>
                </div>
                <h2 class="text-xl font-bold text-white mb-3">Our Vision</h2>
                <p class="text-zinc-400 text-sm leading-relaxed">To become the world's most trusted fitness management platform — empowering gyms of every size with professional-grade tools that were once only available to elite health clubs.</p>
            </div>
        </div>
    </div>

    <!-- Stats Row -->
    <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-12">
        <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-6 text-center hover:bg-zinc-800/40 transition-all">
            <p class="text-3xl font-bold text-white mb-1">5K+</p>
            <p class="text-zinc-500 text-xs uppercase tracking-widest">Active Members</p>
        </div>
        <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-6 text-center hover:bg-zinc-800/40 transition-all">
            <p class="text-3xl font-bold text-white mb-1">120+</p>
            <p class="text-zinc-500 text-xs uppercase tracking-widest">Weekly Classes</p>
        </div>
        <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-6 text-center hover:bg-zinc-800/40 transition-all">
            <p class="text-3xl font-bold text-white mb-1">30+</p>
            <p class="text-zinc-500 text-xs uppercase tracking-widest">Expert Trainers</p>
        </div>
        <div class="bg-zinc-900/40 border border-zinc-800 rounded-2xl p-6 text-center hover:bg-zinc-800/40 transition-all">
            <p class="text-3xl font-bold text-emerald-400 mb-1">98%</p>
            <p class="text-zinc-500 text-xs uppercase tracking-widest">Satisfaction Rate</p>
        </div>
    </div>

    <!-- Instructors -->
    <div class="mb-12">
        <div class="flex items-center gap-3 mb-8">
            <h2 class="text-2xl font-bold text-white tracking-tight">Meet Our Instructors</h2>
            <div class="h-px flex-grow bg-zinc-800"></div>
        </div>
        <div class="grid grid-cols-1 sm:grid-cols-3 gap-6">
            <div class="bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-3xl p-6 hover:border-zinc-700 hover:bg-zinc-800/50 transition-all group text-center">
                <div class="w-16 h-16 rounded-2xl bg-zinc-800 flex items-center justify-center text-3xl mx-auto mb-5 group-hover:scale-110 transition-transform">🏋️</div>
                <h3 class="text-lg font-bold text-white mb-1">Alex Johnson</h3>
                <p class="text-emerald-400 text-xs font-semibold uppercase tracking-widest mb-3">Strength & Conditioning</p>
                <p class="text-zinc-500 text-sm leading-relaxed">Certified Strength & Conditioning Specialist with 10+ years in powerlifting and functional training.</p>
            </div>
            <div class="bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-3xl p-6 hover:border-zinc-700 hover:bg-zinc-800/50 transition-all group text-center">
                <div class="w-16 h-16 rounded-2xl bg-zinc-800 flex items-center justify-center text-3xl mx-auto mb-5 group-hover:scale-110 transition-transform">🧘</div>
                <h3 class="text-lg font-bold text-white mb-1">Priya Sharma</h3>
                <p class="text-emerald-400 text-xs font-semibold uppercase tracking-widest mb-3">Yoga & Mindfulness</p>
                <p class="text-zinc-500 text-sm leading-relaxed">RYT-500 certified instructor specializing in Vinyasa, Hatha, and meditation practices for all levels.</p>
            </div>
            <div class="bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-3xl p-6 hover:border-zinc-700 hover:bg-zinc-800/50 transition-all group text-center">
                <div class="w-16 h-16 rounded-2xl bg-zinc-800 flex items-center justify-center text-3xl mx-auto mb-5 group-hover:scale-110 transition-transform">🥊</div>
                <h3 class="text-lg font-bold text-white mb-1">Marcus Chen</h3>
                <p class="text-emerald-400 text-xs font-semibold uppercase tracking-widest mb-3">Boxing & HIIT</p>
                <p class="text-zinc-500 text-sm leading-relaxed">Professional boxing coach and HIIT specialist. Former amateur champion with a passion for high-energy training.</p>
            </div>
        </div>
    </div>

    <!-- Facilities -->
    <div class="mb-12">
        <div class="flex items-center gap-3 mb-8">
            <h2 class="text-2xl font-bold text-white tracking-tight">World-Class Facilities</h2>
            <div class="h-px flex-grow bg-zinc-800"></div>
        </div>
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div class="flex items-start gap-5 bg-zinc-900/40 border border-zinc-800 rounded-2xl p-5 hover:bg-zinc-800/40 hover:border-zinc-700 transition-all group">
                <div class="text-2xl w-10 h-10 flex-shrink-0 flex items-center justify-center bg-zinc-800 rounded-xl group-hover:scale-110 transition-transform">🏢</div>
                <div>
                    <h4 class="font-semibold text-white mb-1">Modern Gym Floor</h4>
                    <p class="text-zinc-500 text-sm">10,000 sq ft of open training space with premium equipment from Rogue and Life Fitness.</p>
                </div>
            </div>
            <div class="flex items-start gap-5 bg-zinc-900/40 border border-zinc-800 rounded-2xl p-5 hover:bg-zinc-800/40 hover:border-zinc-700 transition-all group">
                <div class="text-2xl w-10 h-10 flex-shrink-0 flex items-center justify-center bg-zinc-800 rounded-xl group-hover:scale-110 transition-transform">🏊</div>
                <div>
                    <h4 class="font-semibold text-white mb-1">Olympic Pool</h4>
                    <p class="text-zinc-500 text-sm">25m heated pool with dedicated lap lanes and regular aqua fitness sessions throughout the week.</p>
                </div>
            </div>
            <div class="flex items-start gap-5 bg-zinc-900/40 border border-zinc-800 rounded-2xl p-5 hover:bg-zinc-800/40 hover:border-zinc-700 transition-all group">
                <div class="text-2xl w-10 h-10 flex-shrink-0 flex items-center justify-center bg-zinc-800 rounded-xl group-hover:scale-110 transition-transform">🧖</div>
                <div>
                    <h4 class="font-semibold text-white mb-1">Recovery Zone</h4>
                    <p class="text-zinc-500 text-sm">Sauna, steam room, and cold plunge pools for elite post-workout recovery and muscle repair.</p>
                </div>
            </div>
            <div class="flex items-start gap-5 bg-zinc-900/40 border border-zinc-800 rounded-2xl p-5 hover:bg-zinc-800/40 hover:border-zinc-700 transition-all group">
                <div class="text-2xl w-10 h-10 flex-shrink-0 flex items-center justify-center bg-zinc-800 rounded-xl group-hover:scale-110 transition-transform">🥤</div>
                <div>
                    <h4 class="font-semibold text-white mb-1">Nutrition Bar</h4>
                    <p class="text-zinc-500 text-sm">Protein shakes, cold-pressed juices, and healthy snacks prepared fresh daily by our nutrition team.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Why Choose Us -->
    <div class="relative overflow-hidden bg-zinc-900/50 backdrop-blur-xl border border-zinc-800 rounded-3xl p-8 md:p-10">
        <div class="absolute -top-16 -right-16 w-64 h-64 bg-emerald-500/5 rounded-full blur-3xl pointer-events-none"></div>
        <div class="relative z-10">
            <h2 class="text-2xl font-bold text-white mb-8 tracking-tight">Why Choose GymPulse?</h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div class="flex items-center gap-3">
                    <div class="w-5 h-5 rounded-full bg-emerald-500/15 border border-emerald-500/30 flex items-center justify-center flex-shrink-0">
                        <svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" class="text-emerald-400"><path d="M20 6 9 17l-5-5"/></svg>
                    </div>
                    <span class="text-zinc-300 text-sm">Easy online class booking & real-time availability</span>
                </div>
                <div class="flex items-center gap-3">
                    <div class="w-5 h-5 rounded-full bg-emerald-500/15 border border-emerald-500/30 flex items-center justify-center flex-shrink-0">
                        <svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" class="text-emerald-400"><path d="M20 6 9 17l-5-5"/></svg>
                    </div>
                    <span class="text-zinc-300 text-sm">Flexible membership plans for every budget</span>
                </div>
                <div class="flex items-center gap-3">
                    <div class="w-5 h-5 rounded-full bg-emerald-500/15 border border-emerald-500/30 flex items-center justify-center flex-shrink-0">
                        <svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" class="text-emerald-400"><path d="M20 6 9 17l-5-5"/></svg>
                    </div>
                    <span class="text-zinc-300 text-sm">Certified and experienced world-class instructors</span>
                </div>
                <div class="flex items-center gap-3">
                    <div class="w-5 h-5 rounded-full bg-emerald-500/15 border border-emerald-500/30 flex items-center justify-center flex-shrink-0">
                        <svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" class="text-emerald-400"><path d="M20 6 9 17l-5-5"/></svg>
                    </div>
                    <span class="text-zinc-300 text-sm">State-of-the-art equipment and premium facilities</span>
                </div>
                <div class="flex items-center gap-3">
                    <div class="w-5 h-5 rounded-full bg-emerald-500/15 border border-emerald-500/30 flex items-center justify-center flex-shrink-0">
                        <svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" class="text-emerald-400"><path d="M20 6 9 17l-5-5"/></svg>
                    </div>
                    <span class="text-zinc-300 text-sm">Secure member portal with full profile management</span>
                </div>
                <div class="flex items-center gap-3">
                    <div class="w-5 h-5 rounded-full bg-emerald-500/15 border border-emerald-500/30 flex items-center justify-center flex-shrink-0">
                        <svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" class="text-emerald-400"><path d="M20 6 9 17l-5-5"/></svg>
                    </div>
                    <span class="text-zinc-300 text-sm">Responsive design — manage your fitness on the go</span>
                </div>
            </div>
        </div>
    </div>

</main>

<%@ include file="footer.jsp" %>
</body>
</html>
