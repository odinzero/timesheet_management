package org.timesheet.security;

import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.timesheet.security.libs.bcrypt.BCrypt;

public class BCrypt_test {

    public static void main(String[] args) throws NoSuchAlgorithmException {
//        String  originalPassword = "password";
//        String generatedSecuredPasswordHash = BCrypt.hashpw(originalPassword, BCrypt.gensalt(12));
//        System.out.println(generatedSecuredPasswordHash);
//         
//        boolean matched = BCrypt.checkpw(originalPassword, generatedSecuredPasswordHash);
//        System.out.println(matched);

        // convert seconds to milliseconds
        Date date = new Date();
        
        int unixSeconds = (int) (date.getTime() / 1000L);

        System.out.println(unixSeconds);
        
        // convert seconds to milliseconds
        date = new Date(unixSeconds * 1000L);
        // the format of your date
        SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss z");
        // give a timezone reference for formatting (see comment at the bottom)
        sdf.setTimeZone(java.util.TimeZone.getTimeZone("GMT+3"));
        String formattedDate = sdf.format(date);
        System.out.println(formattedDate);
    }

}
