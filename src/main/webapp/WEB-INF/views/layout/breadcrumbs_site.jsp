

<!-- ======================== SITE ========================= -->

<!-- SIGNUP -->
<c:if test="${view == 'site/signup_get'}">
    <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_signup = "<li class='active'>Signup</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_signup);
        
        // highlight nav menu "Managers" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_managers").parent().addClass("active");
    </script> 
</c:if>

<!-- SIGNUP RESULT-->
<c:if test="${view == 'site/signup_post'}">
    <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_signup = "<li class='active'>Signup</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_signup);
        
        // highlight nav menu "Managers" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_managers").parent().addClass("active");
    </script> 
</c:if>
    
    
<!-- LOGIN -->
<c:if test="${view == 'site/login_get'}">
    <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_login = "<li class='active'>Login</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_login);
        
        // highlight nav menu "Managers" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_managers").parent().addClass("active");
    </script> 
</c:if>
    
<!-- LOGIN RESULT -->
<c:if test="${view == 'site/login_post'}">
    <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_login = "<li class='active'>Login</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_login);
        
        // highlight nav menu "Managers" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_managers").parent().addClass("active");
    </script> 
</c:if>    

<!-- ======================== SITE END ========================= -->

