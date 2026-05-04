# GymPulse — CS5003NI Milestone 1 Report

**Module:** CS5003NI — Web and Mobile Application Development  
**Due Date:** 17 April 2026  
**Student:** _(your name)_  
**Application:** GymPulse — Fitness Management System

---

## 1. Project Scope

GymPulse is a full-stack Java EE fitness management system built for a gym that needs to manage its members, memberships, fitness classes, and bookings. The application follows the **MVC architecture** pattern using Jakarta Servlets as controllers, JSP as views, and a MySQL-backed service layer as the model.

The system supports two distinct user roles:
- **Admin** — manages members, plans, classes, and views all bookings
- **Member** — registers, logs in, views/books fitness classes, manages their profile

---

## 2. Objectives

| # | Objective | Status |
|---|-----------|--------|
| 1 | Role-based authentication (login, register, session) | ✅ Done |
| 2 | Admin CRUD: members, plans, classes | ✅ Done |
| 3 | Member dashboard: bookings, membership status | ✅ Done |
| 4 | MVC structure with WEB-INF/pages JSP routing | ✅ Done |
| 5 | MySQL/JDBC with PreparedStatements only | ✅ Done |
| 6 | AES password encryption via EncryptionUtil | ✅ Done |
| 7 | Input validation via ValidationUtil | ✅ Done |
| 8 | Session/filter security (AdminFilter, MemberFilter) | ✅ Done |
| 9 | Profile image upload (@MultipartConfig) | ✅ Done |
| 10 | Custom error pages (404/500, friendlly, no stack traces) | ✅ Done |

---

## 3. Agenda / Milestones

| Milestone | Deliverable | Target Date |
|-----------|------------|-------------|
| Milestone 1 | Core MVC, Auth, CRUD, DB schema, Security | 17 April 2026 |
| Milestone 2 | Reporting, Payment Flow, Email Verification | TBD |
| Milestone 3 | Final Testing, Deployment, Documentation | TBD |

---

## 4. Progress Summary

### Week 1–2: Setup & HTML/CSS
- Project structure established under `com.gympulse.{controllers, model, config, service, util, filter}`
- Responsive CSS design system implemented in `css/style.css` (flexbox, grid, custom properties, mobile media queries)
- No Bootstrap — pure CSS throughout

### Week 3: JSP Lifecycle
- All JSPs placed under `WEB-INF/pages/` (inaccessible directly)
- Every page reached exclusively via `RequestDispatcher.forward()`
- `index.jsp` at root contains no business logic — pure redirect to `/login`
- Header/footer fragments included via `<%@ include %>`
- JSTL (`c:if`, `c:forEach`, `c:choose`) used throughout; no scriptlets in pages

### Week 4: Servlets & MVC
- 15 Servlet controllers: `LoginServlet`, `RegisterServlet`, `LogoutServlet`, `HomeServlet`, `AdminDashboardServlet`, `MemberDashboardServlet`, `ProfileServlet`, `ManageMembersServlet`, `ManageClassesServlet`, `ManagePlansServlet`, `BookClassServlet`, `AboutServlet`, `ContactServlet`, `ForgotPasswordServlet`, `ErrorServlet`
- Every `<form action>` and `<a href>` points to servlet URL patterns only — no `.jsp` paths exposed

### Week 5: MySQL & JDBC
- All SQL uses `PreparedStatement` with `?` placeholders — zero string concatenation
- JDBC resources (Connection, PreparedStatement, ResultSet) closed via `try-with-resources`
- SQL transactions used for multi-step operations (bookClass, assignMembership)
- `database/schema.sql` created with all 6 tables and seed data

### Week 6: Security & File Upload
- `AdminFilter` (`@WebFilter("/admin/*")`) and `MemberFilter` (`@WebFilter("/member/*")`) enforce role-based access
- AES/ECB/PKCS5 encryption via `EncryptionUtil` — passwords never stored or compared in plaintext
- `ProfileServlet` annotated `@MultipartConfig` — supports profile image upload to `images/profiles/`
- `LogoutServlet` invalidates session and clears cookies via `CookieUtil`
- `ValidationUtil` enforces email format, password strength, phone digits on all POST handlers

---

## 5. Screens Implemented

### Public / Auth
| Screen | Servlet | JSP |
|--------|---------|-----|
| Login | `/login` | `WEB-INF/pages/login.jsp` |
| Register | `/register` | `WEB-INF/pages/register.jsp` |
| Forgot Password | `/forgot-password` | `WEB-INF/pages/forgot-password.jsp` |
| About | `/about` | `WEB-INF/pages/about.jsp` |
| Contact | `/contact` | `WEB-INF/pages/contact.jsp` |
| 404 Error | `/error?code=404` | `WEB-INF/pages/error-404.jsp` |
| 500 Error | `/error?code=500` | `WEB-INF/pages/error-500.jsp` |

### Admin (protected by AdminFilter)
| Screen | Servlet | JSP |
|--------|---------|-----|
| Dashboard | `/admin/dashboard` | `WEB-INF/pages/admin/dashboard.jsp` |
| Manage Members | `/admin/members` | `WEB-INF/pages/admin/manage-members.jsp` |
| Manage Classes | `/admin/classes` | `WEB-INF/pages/admin/manage-classes.jsp` |
| Manage Plans | `/admin/plans` | `WEB-INF/pages/admin/manage-plans.jsp` |
| View All Bookings | `/admin/bookings` | `WEB-INF/pages/admin/view-bookings.jsp` |

### Member (protected by MemberFilter)
| Screen | Servlet | JSP |
|--------|---------|-----|
| Dashboard | `/member/dashboard` | `WEB-INF/pages/member/dashboard.jsp` |
| My Profile | `/member/profile` | `WEB-INF/pages/member/profile.jsp` |
| Classes | `/member/classes` | `WEB-INF/pages/member/classes.jsp` |
| My Bookings | `/member/bookings` | `WEB-INF/pages/member/my-bookings.jsp` |

---

## 6. Database Schema Overview

```
users              — user_id (PK), full_name, email (UNIQUE), phone (UNIQUE), password, role, status
membership_plans   — plan_id (PK), plan_name, duration_months, price, description, status
memberships        — membership_id (PK), user_id (FK→users), plan_id (FK→plans), start_date, end_date, status
fitness_classes    — class_id (PK), class_name, instructor, schedule_date, schedule_time, capacity, enrolled, status
class_bookings     — booking_id (PK), user_id (FK→users), class_id (FK→classes), booking_date, status
payments           — payment_id (PK), user_id (FK→users), membership_id (FK→memberships), amount, payment_date
```

Full DDL with seed data: [`database/schema.sql`](../database/schema.sql)

---

## 7. Remaining Work (Milestone 2)

| # | Item | Notes |
|---|------|-------|
| 1 | Forgot Password — email reset flow | Needs SMTP configuration (JavaMail) |
| 2 | Admin view-bookings servlet | Stub JSP built; needs `AdminBookingsServlet` wired |
| 3 | Member classes servlet | Stub JSP built; needs dedicated `MemberClassesServlet` |
| 4 | Payment gateway integration | Currently simulated; wire a real payment provider |
| 5 | Admin reporting & charts | Revenue, membership growth analytics |
| 6 | Pagination on large tables | Members list, bookings list |
| 7 | Remember-Me cookie flow | `CookieUtil` ready; logic not yet in LoginServlet |
| 8 | Replace `REPLACE_WITH_ENCRYPTED_*` in schema.sql | Must run `EncryptionUtil.encrypt()` and paste hex values |
| 9 | Unit tests (JUnit 5) | Service layer unit tests to be written |
| 10 | Deployment to cloud/VPS | Tomcat 10.x + MySQL on a public host |
