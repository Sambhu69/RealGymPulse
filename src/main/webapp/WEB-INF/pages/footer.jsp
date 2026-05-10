<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<footer class="w-full bg-zinc-950/80 backdrop-blur-md border-t border-zinc-900 mt-auto py-6">
    <div class="max-w-7xl mx-auto px-4 md:px-8 flex flex-col md:flex-row justify-between items-center text-zinc-500 text-sm gap-4">
        <p class="text-zinc-600 text-xs">&copy; 2026 GymPulse. All Rights Reserved.</p>
        <div class="flex space-x-6">
            <a href="${pageContext.request.contextPath}/about" class="hover:text-zinc-300 transition-colors text-xs">About</a>
            <a href="${pageContext.request.contextPath}/contact" class="hover:text-zinc-300 transition-colors text-xs">Contact</a>
            <a href="${pageContext.request.contextPath}/privacy" class="hover:text-zinc-300 transition-colors text-xs">Privacy Policy</a>
        </div>
    </div>
</footer>

<!-- =========================================================
     GLOBAL TOAST NOTIFICATION SYSTEM
     Reads param.success / param.error / param.info from URL
     and fires a stylised, auto-closing toast in the top-right.
     ========================================================= -->
<style>
  #gp-toast-container {
    position: fixed;
    top: 90px;
    right: 0;
    z-index: 9999;
    display: flex;
    flex-direction: column;
    gap: 10px;
    pointer-events: none;
    padding-right: 0;
  }

  .gp-toast {
    pointer-events: all;
    display: flex;
    align-items: flex-start;
    gap: 12px;
    min-width: 300px;
    max-width: 380px;
    padding: 14px 16px 14px 18px;
    border-radius: 12px 0 0 12px;
    border: 1px solid transparent;
    border-right: none;
    backdrop-filter: blur(20px);
    box-shadow: -6px 6px 30px rgba(0,0,0,0.5);
    position: relative;
    overflow: hidden;
    transform: translateX(120%);
    transition: transform 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
    will-change: transform;
  }

  .gp-toast.gp-toast-show {
    transform: translateX(0);
  }

  .gp-toast.gp-toast-hide {
    transform: translateX(120%);
    transition: transform 0.35s cubic-bezier(0.36, 0, 0.66, -0.56);
  }

  /* Toast types */
  .gp-toast-success {
    background: rgba(5, 46, 22, 0.92);
    border-color: rgba(34, 197, 94, 0.3);
  }
  .gp-toast-error {
    background: rgba(69, 10, 10, 0.92);
    border-color: rgba(239, 68, 68, 0.3);
  }
  .gp-toast-warning {
    background: rgba(69, 45, 10, 0.92);
    border-color: rgba(245, 158, 11, 0.3);
  }
  .gp-toast-info {
    background: rgba(10, 30, 69, 0.92);
    border-color: rgba(59, 130, 246, 0.3);
  }

  /* Icon */
  .gp-toast-icon {
    flex-shrink: 0;
    width: 20px;
    height: 20px;
    margin-top: 1px;
  }

  /* Text */
  .gp-toast-body { flex: 1; }
  .gp-toast-title {
    font-size: 11px;
    font-weight: 700;
    letter-spacing: 0.08em;
    text-transform: uppercase;
    opacity: 0.6;
    margin-bottom: 2px;
  }
  .gp-toast-msg {
    font-size: 13px;
    font-weight: 500;
    line-height: 1.45;
  }
  .gp-toast-success .gp-toast-title,
  .gp-toast-success .gp-toast-msg  { color: #4ade80; }
  .gp-toast-error   .gp-toast-title,
  .gp-toast-error   .gp-toast-msg  { color: #f87171; }
  .gp-toast-warning .gp-toast-title,
  .gp-toast-warning .gp-toast-msg  { color: #fbbf24; }
  .gp-toast-info    .gp-toast-title,
  .gp-toast-info    .gp-toast-msg  { color: #60a5fa; }

  /* Close btn */
  .gp-toast-close {
    flex-shrink: 0;
    background: none;
    border: none;
    cursor: pointer;
    opacity: 0.45;
    padding: 0;
    line-height: 1;
    font-size: 16px;
    margin-top: 1px;
    transition: opacity 0.2s;
  }
  .gp-toast-close:hover { opacity: 1; }
  .gp-toast-success .gp-toast-close { color: #4ade80; }
  .gp-toast-error   .gp-toast-close { color: #f87171; }
  .gp-toast-warning .gp-toast-close { color: #fbbf24; }
  .gp-toast-info    .gp-toast-close { color: #60a5fa; }

  /* Progress bar */
  .gp-toast-progress {
    position: absolute;
    bottom: 0;
    left: 0;
    height: 3px;
    width: 100%;
    transform-origin: left;
    border-radius: 0 0 0 12px;
    animation: gp-drain 15s linear forwards;
  }
  .gp-toast-success .gp-toast-progress { background: rgba(74, 222, 128, 0.5); }
  .gp-toast-error   .gp-toast-progress { background: rgba(248, 113, 113, 0.5); }
  .gp-toast-warning .gp-toast-progress { background: rgba(251, 191, 36, 0.5); }
  .gp-toast-info    .gp-toast-progress { background: rgba(96, 165, 250, 0.5); }

  @keyframes gp-drain {
    from { transform: scaleX(1); }
    to   { transform: scaleX(0); }
  }
</style>

<div id="gp-toast-container"></div>

<script>
(function () {
  /* ── Message lookup table ───────────────────────────────── */
  var MESSAGES = {
    success: {
      // Admin — Members
      'deleted'              : 'Member deleted successfully.',
      'updated'              : 'Details updated successfully.',
      'password_changed'     : 'Password changed successfully.',
      'plan_assigned'        : 'Membership plan assigned.',
      // Admin — Classes
      'added'                : 'Record added successfully!',
      // Admin — Trainers
      'trainer_added'        : 'Trainer account created!',
      'trainer_updated'      : 'Trainer profile updated.',
      'trainer_deleted'      : 'Trainer deleted successfully.',
      // Admin — Plans
      // (uses 'added', 'updated', 'deleted' above)
      // Member — Dashboard
      'membership_activated' : 'Membership activated! Welcome aboard 🎉',
      'trainer_booked'       : 'Personal Trainer session booked successfully!',
      'booked'               : 'Class booked successfully!',
      'cancelled'            : 'Booking cancelled.',
      // Member — Profile
      'profile_updated'      : 'Profile updated successfully!',
      // Trainer — Dashboard
      'slot_added'           : 'Availability slot added successfully!',
      // Contact
      'message_sent'         : 'Your message was sent. We\'ll be in touch!'
    },
    error: {
      // Admin — Members
      'delete_failed'        : 'Failed to delete. Try again.',
      'invalid_data'         : 'Invalid input data. Check all fields.',
      'weak_password'        : 'Password too weak. Min 6 characters.',
      'password_failed'      : 'Failed to update password.',
      // Admin — Classes
      'add_failed'           : 'Failed to add. Email / phone may already exist.',
      // Admin — Trainers
      'update_failed'        : 'Failed to update. Please try again.',
      'system_error'         : 'A system error occurred. Please try again.',
      // Member
      'alreadybooked'        : 'You have already booked this class.',
      'cancel_failed'        : 'Cancellation failed. Please try again.',
      'slot_unavailable'     : 'That time slot is no longer available.',
      'invalid_name'         : 'Invalid name. Use letters only.',
      'invalid_phone'        : 'Phone must be at least 10 digits.',
      'wrong_password'       : 'Current password is incorrect.',
      'passwords_mismatch'   : 'New passwords do not match.'
    },
    warning: {
      'plan_deactivated'     : 'Plan deactivated successfully.'
    }
  };

  /* ── Toast builder ──────────────────────────────────────── */
  var DURATION = 15000; // 15 seconds

  var ICONS = {
    success : '<svg class="gp-toast-icon" viewBox="0 0 24 24" fill="none" stroke="#4ade80" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M20 6L9 17l-5-5"/></svg>',
    error   : '<svg class="gp-toast-icon" viewBox="0 0 24 24" fill="none" stroke="#f87171" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><path d="M15 9l-6 6M9 9l6 6"/></svg>',
    warning : '<svg class="gp-toast-icon" viewBox="0 0 24 24" fill="none" stroke="#fbbf24" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>',
    info    : '<svg class="gp-toast-icon" viewBox="0 0 24 24" fill="none" stroke="#60a5fa" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>'
  };

  var LABELS = { success:'Success', error:'Error', warning:'Notice', info:'Info' };

  function showToast(type, message) {
    var container = document.getElementById('gp-toast-container');
    if (!container || !message) return;

    var toast = document.createElement('div');
    toast.className = 'gp-toast gp-toast-' + type;
    toast.innerHTML =
      ICONS[type] +
      '<div class="gp-toast-body">' +
        '<div class="gp-toast-title">' + LABELS[type] + '</div>' +
        '<div class="gp-toast-msg">' + message + '</div>' +
      '</div>' +
      '<button class="gp-toast-close" aria-label="Dismiss">&times;</button>' +
      '<div class="gp-toast-progress"></div>';

    container.appendChild(toast);

    // Slide in
    requestAnimationFrame(function () {
      requestAnimationFrame(function () {
        toast.classList.add('gp-toast-show');
      });
    });

    // Auto-dismiss
    var timer = setTimeout(function () { dismissToast(toast); }, DURATION);

    // Manual close
    toast.querySelector('.gp-toast-close').addEventListener('click', function () {
      clearTimeout(timer);
      dismissToast(toast);
    });
  }

  function dismissToast(toast) {
    toast.classList.remove('gp-toast-show');
    toast.classList.add('gp-toast-hide');
    toast.addEventListener('transitionend', function () { toast.remove(); }, { once: true });
  }

  /* ── URL param reader ───────────────────────────────────── */
  function getParam(name) {
    var q = window.location.search;
    var rx = new RegExp('[?&]' + name + '=([^&#]*)');
    var m  = rx.exec(q);
    return m ? decodeURIComponent(m[1].replace(/\+/g, ' ')) : null;
  }

  /* ── Fire on DOM ready ──────────────────────────────────── */
  document.addEventListener('DOMContentLoaded', function () {
    var sp = getParam('success');
    var ep = getParam('error');
    var wp = getParam('warning');
    var ip = getParam('info');

    if (sp) {
      var msg = MESSAGES.success[sp] || sp.replace(/_/g, ' ');
      showToast('success', msg);
    }
    if (ep) {
      var msg = MESSAGES.error[ep] || ep.replace(/_/g, ' ');
      showToast('error', msg);
    }
    if (wp) {
      var msg = MESSAGES.warning[wp] || wp.replace(/_/g, ' ');
      showToast('warning', msg);
    }
    if (ip) {
      showToast('info', ip.replace(/_/g, ' '));
    }
  });

  /* Expose globally so any page JS can call window.gpToast() */
  window.gpToast = showToast;
})();
</script>
