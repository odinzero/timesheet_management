
package org.timesheet.security;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

public class SHA {
     
    public static void main(String[] args) throws NoSuchAlgorithmException
    {
        String passwordToHash = "password";
        byte[] salt = getSalt();
         
        String securePassword1 = get_SHA_SecurePassword(passwordToHash, salt, "SHA-256");
        System.out.println("SHA-1 1 : " + securePassword1);
        
        String securePassword2 = get_SHA_SecurePassword(passwordToHash, salt, "SHA-256");
        System.out.println("SHA-1 2 : " + securePassword2);
        
        if(securePassword2.equals(securePassword1)) {
           System.out.println("passwords are equals" ); 
        }
      
    }
 
    // SHA algorithm :
    // They generate the following length hashes in comparison to MD5 (128-bit hash):
    // - "SHA-1" (Simplest one – 160 bits Hash)
    // - "SHA-256" (Stronger than SHA-1 – 256 bits Hash)
    // - "SHA-384" (Stronger than SHA-256 – 384 bits Hash)
    // - "SHA-512" (Stronger than SHA-384 – 512 bits Hash)
    public static String get_SHA_SecurePassword(String passwordToHash, byte[] salt, String  SHA_algorithm)
    {
        String generatedPassword = null;
        try {
            // Create MessageDigest instance for MD5
            MessageDigest md = MessageDigest.getInstance(SHA_algorithm);
            md.update(salt);
            //Add password bytes to digest
            byte[] bytes = md.digest(passwordToHash.getBytes());
            //This bytes[] has bytes in decimal format;
            //Convert it to hexadecimal format
            StringBuilder sb = new StringBuilder();
            for(int i=0; i < bytes.length ;i++)
            {
                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
            }
            //Get complete hashed password in hex format
            generatedPassword = sb.toString();
           // generatedPassword = new String(md.digest());
        }
        catch (NoSuchAlgorithmException e)
        {
            e.printStackTrace();
        }
        return generatedPassword;
    }
     
    //Add salt
    private static byte[] getSalt() throws NoSuchAlgorithmException
    {
        SecureRandom sr = SecureRandom.getInstance("SHA1PRNG");
        byte[] salt = new byte[16];
        sr.nextBytes(salt);
        return salt;
    }
}
