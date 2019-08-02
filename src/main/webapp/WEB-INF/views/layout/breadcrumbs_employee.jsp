

<!--
<ul class="breadcrumb" style="margin-top: 80px;">
        <li>
            <a href="/timesheet/site/home">Home</a>
        </li>
        <li class="active">Posts</li>
    </ul> 
-->

<!-- MAIN PAGE -->
<c:if test="${view == 'site/home'}">
    <script>
        $("#bread").removeClass("breadcrumb");
        // highlight nav menu "Home" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_home").parent().addClass("active");
    </script>
</c:if>

<!-- ======================== EMPLOYEE ========================= -->

<!-- EMPLOYEE LIST -->
<c:if test="${view == 'employees/list'}">
    <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_employees = "<li class='active'>Employees</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_employees);
        
        // highlight nav menu "Employees" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_employees").parent().addClass("active");
    </script> 
</c:if>

<!-- EMPLOYEE VIEW -->
<c:if test='${view == "employees/" }'>
    <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_employees = "<li><a href='/timesheet/employees'>Employees</a></li>";
        
        var li_employees_name = "<li class='active'>${employee.name}</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_employees);
        $("#bread").append(li_employees_name);
        
        // highlight nav menu "Employees" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_employees").parent().addClass("active");
    </script>
</c:if>
        
<!-- EMPLOYEE UPDATE -->
<c:if test='${view == "employees/update_get" }'>
    <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_employees = "<li><a href='/timesheet/employees'>Employees</a></li>";
        
        var li_employees_view = "<li><a href='/timesheet/employees/${employee.id}'>${employee.name}</a></li>";
        
        var li_employees_update = "<li class='active'>Update</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_employees);
        $("#bread").append(li_employees_view);
        $("#bread").append(li_employees_update);
        
        // highlight nav menu "Employees" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_employees").parent().addClass("active");
    </script> 
</c:if>

<!-- EMPLOYEE UPDATE RESULT -->
<c:if test='${view == "employees/update_post" }'>
     <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_employees = "<li><a href='/timesheet/employees'>Employees</a></li>";
        
        var li_employees_view = "<li><a href='/timesheet/employees/${employee.id}'>${employee.name}</a></li>";
        
        var li_employees_update = "<li class='active'>Update</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_employees);
        $("#bread").append(li_employees_view);
        $("#bread").append(li_employees_update);
        
        // highlight nav menu "Employees" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_employees").parent().addClass("active");
    </script>
</c:if>

<!-- EMPLOYEE CREATE -->
<c:if test='${view == "employees/create_get" }'>
    <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_employees = "<li><a href='/timesheet/employees'>Employees</a></li>";
        
        var li_employees_create = "<li class='active'>Create Employee</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_employees);
        $("#bread").append(li_employees_create);
        
        // highlight nav menu "Employees" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_employees").parent().addClass("active");
    </script>  
</c:if>
<!-- EMPLOYEE CREATE RESULT -->
<c:if test='${view == "employees/create_post" }'>
    <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_employees = "<li><a href='/timesheet/employees'>Employees</a></li>";
        
        var li_employees_create = "<li class='active'>Create Employee</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_employees);
        $("#bread").append(li_employees_create);
        
        // highlight nav menu "Employees" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_employees").parent().addClass("active");
    </script>  
</c:if>

<!-- ======================== EMPLOYEE END ========================= -->

