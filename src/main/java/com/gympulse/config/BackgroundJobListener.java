package com.gympulse.config;

import com.gympulse.service.MembershipService;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@WebListener
public class BackgroundJobListener implements ServletContextListener {

    private ScheduledExecutorService scheduler;
    private MembershipService membershipService;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        membershipService = new MembershipService();
        scheduler = Executors.newSingleThreadScheduledExecutor();

        // Run the job immediately, then every 24 hours
        scheduler.scheduleAtFixedRate(() -> {
            try {
                System.out.println("[BackgroundJob] Running membership auto-expiry and notifications job...");
                
                // Expire memberships where end_date < CURDATE()
                membershipService.expireOldMemberships();
                
                // TODO: Generate 7-day and 1-day reminders (requires additional service method)
                System.out.println("[BackgroundJob] Job execution complete.");
            } catch (Exception e) {
                System.err.println("[BackgroundJob] Error running background task: " + e.getMessage());
            }
        }, 0, 1, TimeUnit.DAYS);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (scheduler != null) {
            scheduler.shutdownNow();
            System.out.println("[BackgroundJob] Scheduler shut down.");
        }
    }
}
