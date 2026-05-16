package com.gympulse.utils;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.Map;

public class NepaliCalendarUtils {

    // Reference: Baisakh 1, 2083 BS = April 14, 2026 AD
    private static final LocalDate REF_AD = LocalDate.of(2026, 4, 14);
    private static final int REF_BS_YEAR = 2083;
    
    private static final int[] BS_MONTH_DAYS_2083 = {31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30};
    private static final String[] BS_MONTH_NAMES = {
        "Baisakh", "Jestha", "Asar", "Shrawan", "Bhadra", "Ashwin", 
        "Kartik", "Mangsir", "Poush", "Magh", "Falgun", "Chaitra"
    };

    public static class NepaliDate {
        public int year;
        public int month; // 1-indexed
        public int day;
        public String monthName;

        public int getYear() { return year; }
        public int getMonth() { return month; }
        public int getDay() { return day; }
        public String getMonthName() { return monthName; }

        @Override
        public String toString() {
            return day + " " + monthName + ", " + year;
        }
    }

    public static NepaliDate convertToNepali(LocalDate adDate) {
        long daysDiff = ChronoUnit.DAYS.between(REF_AD, adDate);
        
        // This is a simplified version for BS 2083
        NepaliDate nd = new NepaliDate();
        nd.year = REF_BS_YEAR;
        
        if (daysDiff < 0) {
            // Simplified: if before REF_AD, we don't handle it perfectly but return something
            nd.month = 1;
            nd.day = 1;
            nd.monthName = BS_MONTH_NAMES[0];
            return nd;
        }

        long remainingDays = daysDiff;
        for (int i = 0; i < 12; i++) {
            if (remainingDays < BS_MONTH_DAYS_2083[i]) {
                nd.month = i + 1;
                nd.day = (int) remainingDays + 1;
                nd.monthName = BS_MONTH_NAMES[i];
                return nd;
            }
            remainingDays -= BS_MONTH_DAYS_2083[i];
        }

        // If it overflows the year, just cap it (simplified)
        nd.month = 12;
        nd.day = 30;
        nd.monthName = BS_MONTH_NAMES[11];
        return nd;
    }

    public static int getDaysInMonth(int month) {
        if (month < 1 || month > 12) return 30;
        return BS_MONTH_DAYS_2083[month - 1];
    }
    
    public static LocalDate getAdStartOfMonth(int month) {
        LocalDate start = REF_AD;
        for (int i = 0; i < month - 1; i++) {
            start = start.plusDays(BS_MONTH_DAYS_2083[i]);
        }
        return start;
    }
}
