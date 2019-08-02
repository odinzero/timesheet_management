package org.timesheet.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.RememberMeAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.timesheet.domain.User;
import org.timesheet.forms.LoginForm;
import org.timesheet.forms.SignupForm;
import org.timesheet.security.MD5;
import org.timesheet.service.dao.UserDao;

/**
 * Controller for handling login, registration and others.
 */
@Controller
@RequestMapping("/site")
public class SiteController {

    static final Logger logger = Logger.getLogger(SiteController.class);

    private UserDao userDao;

    @Autowired
    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    public UserDao getUserDao() {
        return userDao;
    }

    /**
     * This is main page
     *
     */
    // http://localhost:8083/timesheet/site/home
    @RequestMapping(value = { "/", "/home**" }, method = RequestMethod.GET)
    public String Home(Model model) {

        model.addAttribute("view", "site/home");

        return "layout/content";
    }

    // ========================== CREATE USER =======================================
    @ModelAttribute("userCreate")
    public SignupForm createEmployeeForm() {
        return new SignupForm();
    }

    /**
     * Creates form for new user
     *
     * @param model Model to bind to HTML form
     */
    // http://localhost:8083/timesheet/site/signup
    @RequestMapping(value = "signup", params = "new", method = RequestMethod.GET)
    public String createUserForm(Model model) {

        model.addAttribute("view", "site/signup_get");

        return "layout/content";
    }

    /**
     * Saves new user to the database
     *
     * @param user User to save
     * @return redirects to login
     */
    // http://localhost:8083/site/signup
    @RequestMapping(value = "signup", method = RequestMethod.POST)
    public String addUser(@ModelAttribute("userCreate") @Validated SignupForm signupForm,
            BindingResult bindingResult, Model model) {

        logger.info("=== SiteController === method:addUser --- start");

        if (bindingResult.hasErrors()) {

            // when button "Signup" has been clicked             
            model.addAttribute("try_signup", "signup");
            // see file content.jsp
            model.addAttribute("view", "site/signup_post");

            return "layout/content";
        }

        User user = new User(signupForm.getUsername());
        user.setEmail(signupForm.getEmail());

        user.setPassword_hash(MD5.get_MD5_SecurePassword(signupForm.getPassword()));
        // not email approved
        user.setStatus(0);

        user.setPassword_reset_token("1");

        Date date = new Date();
        // convert milliseconds to seconds
        int currTime_sec = (int) (date.getTime() / 1000L);

        user.setCreated_at(currTime_sec);
        user.setUpdated_at(currTime_sec);

        userDao.add(user);

        logger.info("=== SiteController === method:addUser --- end");

        return "redirect:/site/login";
    }

    private int getDateTime(int unixSeconds) {

        // convert seconds to milliseconds
        Date date = new Date(unixSeconds * 1000L);
        // the format of your date
        SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss z");
        // give a timezone reference for formatting (see comment at the bottom)
        sdf.setTimeZone(java.util.TimeZone.getTimeZone("GMT+3"));
        String formattedDate = sdf.format(date);

        int d = Integer.parseInt(formattedDate);

        return d;
    }

    // =========================== LOGIN =======================================
    @ModelAttribute("userLogin")
    public LoginForm createLoginForm() {
        return new LoginForm();
    }

    /**
     * This is login
     *
     */
    // http://localhost:8083/timesheet/site/login
    @RequestMapping(value = "login", method = RequestMethod.GET)
    public String createLoginForm(Model model) {

        model.addAttribute("view", "site/login_get");

        return "layout/content";
    }

    /**
     * Try login user
     *
     * @param user User to login
     */
    // http://localhost:8083/site/login
    @RequestMapping(value = "login", method = RequestMethod.POST)
    public String login(@ModelAttribute("userLogin") @Validated LoginForm loginForm,
            BindingResult bindingResult, Model model) {

        logger.info("=== SiteController === method:login --- start");

        // when button "Login" has been clicked             
        model.addAttribute("try_login", "login");

        if (bindingResult.hasErrors()) {

            // see file content.jsp
            model.addAttribute("view", "site/login_post");

            return "layout/content";
        }

        String password = loginForm.getPassword();
        String username = loginForm.getUsername();

        User user = new User();
        user.setUsername(username);
        user.setPassword_hash(MD5.get_MD5_SecurePassword(password));

        boolean login = userDao.tryLogin(user);

        if (login) {
            logger.info("=== SiteController === method:login --- end");

            // when button "Login" has been clicked             
            model.addAttribute("user", "user_exists");
            // user 
            model.addAttribute("username", username);

            return "redirect:/site/home";
        } else {
            logger.info("=== SiteController === method:login --- end");

            // when button "Login" has been clicked             
            model.addAttribute("user", "user_not_exists");
            // see file content.jsp
            model.addAttribute("view", "site/login_post");

            return "layout/content";
        }

    }

    /**
     * both "normal login" and "login for update" shared this form.
     *
     */
    // http://localhost:8083/spring-security-remember-me/login
//    @RequestMapping(value = "/login", method = RequestMethod.GET)
//    public ModelAndView login(@RequestParam(value = "error", required = false) String error,
//            @RequestParam(value = "logout", required = false) String logout,
//            HttpServletRequest request) {
//
//        ModelAndView model = new ModelAndView();
//        if (error != null) {
//            model.addObject("error", "Invalid username and password!");
//
//            //login form for update, if login error, get the targetUrl from session again.
//            String targetUrl = getRememberMeTargetUrlFromSession(request);
//            System.out.println(targetUrl);
//            if (StringUtils.hasText(targetUrl)) {
//                model.addObject("targetUrl", targetUrl);
//                model.addObject("loginUpdate", true);
//            }
//
//        }
//
//        if (logout != null) {
//            model.addObject("msg", "You've been logged out successfully.");
//        }
//        model.setViewName("login");
//
//        return model;
//
//    }
//
//    /**
//     * If the login in from remember me cookie, refer
//     * org.springframework.security.authentication.AuthenticationTrustResolverImpl
//     */
    private boolean isRememberMeAuthenticated() {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null) {
            return false;
        }

        return RememberMeAuthenticationToken.class.isAssignableFrom(authentication.getClass());
    }

    /**
     * save targetURL in session
     */
    private void setRememberMeTargetUrlToSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.setAttribute("targetUrl", "/admin/update");
        }
    }

    /**
     * get targetURL from session
     */
    private String getRememberMeTargetUrlFromSession(HttpServletRequest request) {
        String targetUrl = "";
        HttpSession session = request.getSession(false);
        if (session != null) {
            targetUrl
                    = session.getAttribute("targetUrl") == null ? "" : session.getAttribute("targetUrl").toString();
        }
        return targetUrl;
    }

}
