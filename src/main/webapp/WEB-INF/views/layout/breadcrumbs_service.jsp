

<!-- ======================== TIMESHEET-SERVICE ========================= -->

<!-- TIMESHEET-SERVICE MENU -->
<c:if test="${view == 'timesheet-service/menu'}">
    <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_service = "<li class='active'>Service</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_service);
        
        // highlight nav menu "Service" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_service").parent().addClass("active");
    </script> 
</c:if>

<!-- TIMESHEET-SERVICE MANAGER TASKS -->
<c:if test='${view == "timesheet-service/manager-tasks" }'>
    <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_service = "<li><a href='/timesheet/timesheet-service'>Service</a></li>";
        
        var li_managers_name = "<li class='active'>${manager.name}</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_service);
        $("#bread").append(li_managers_name);
        
        // highlight nav menu "Service" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_service").parent().addClass("active");
    </script>
</c:if>
        
<!-- TIMESHEET-SERVICE EMPLOYEE TASKS -->
<c:if test='${view == "timesheet-service/employee-tasks" }'>
    <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_service = "<li><a href='/timesheet/timesheet-service'>Service</a></li>";
        
        var li_employees_name = "<li class='active'>${employee.name}</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_service);
        $("#bread").append(li_employees_name);
        
        // highlight nav menu "Service" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_service").parent().addClass("active");
    </script> 
</c:if>


<!-- ======================== TIMESHEET-SERVICE END ========================= -->

