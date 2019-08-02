
package org.timesheet.security;

import org.timesheet.security.libs.scrypt.crypto.SCryptUtil;

public class SCrypt {
    
    public static void main(String[] args) {
        String originalPassword = "password";
        String generatedSecuredPasswordHash = SCryptUtil.scrypt(originalPassword, 16, 16, 16);
        System.out.println(generatedSecuredPasswordHash);
         
        boolean matched = SCryptUtil.check("password", generatedSecuredPasswordHash);
        System.out.println(matched);
         
        matched = SCryptUtil.check("passwordno", generatedSecuredPasswordHash);
        System.out.println(matched);
    }
    
}
