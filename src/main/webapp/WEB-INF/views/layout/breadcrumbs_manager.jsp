

<!-- ======================== MANAGER ========================= -->

<!-- MANAGER LIST -->
<c:if test="${view == 'managers/list'}">
    <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_managers = "<li class='active'>Managers</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_managers);
        
        // highlight nav menu "Managers" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_managers").parent().addClass("active");
    </script> 
</c:if>

<!-- MANAGER VIEW -->
<c:if test='${view == "managers/" }'>
    <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_managers = "<li><a href='/timesheet/managers'>Managers</a></li>";
        
        var li_managers_name = "<li class='active'>${manager.name}</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_managers);
        $("#bread").append(li_managers_name);
        
        // highlight nav menu "Managers" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_managers").parent().addClass("active");
    </script>
</c:if>
        
<!-- MANAGER UPDATE -->
<c:if test='${view == "managers/update_get" }'>
    <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_managers = "<li><a href='/timesheet/managers'>Managers</a></li>";
        
        var li_managers_view = "<li><a href='/timesheet/managers/${manager.id}'>${manager.name}</a></li>";
        
        var li_managers_update = "<li class='active'>Update</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_managers);
        $("#bread").append(li_managers_view);
        $("#bread").append(li_managers_update);
        
        // highlight nav menu "Managers" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_managers").parent().addClass("active");
    </script> 
</c:if>

<!-- MANAGER UPDATE RESULT -->
<c:if test='${view == "managers/update_post" }'>
     <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_managers = "<li><a href='/timesheet/managers'>Managers</a></li>";
        
        var li_managers_view = "<li><a href='/timesheet/managers/${manager.id}'>${manager.name}</a></li>";
        
        var li_managers_update = "<li class='active'>Update</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_managers);
        $("#bread").append(li_managers_view);
        $("#bread").append(li_managers_update);
        
        // highlight nav menu "managers" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_managers").parent().addClass("active");
    </script>
</c:if>

<!-- MANAGER CREATE -->
<c:if test='${view == "managers/create_get" }'>
    <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_managers = "<li><a href='/timesheet/managers'>Managers</a></li>";
        
        var li_managers_create = "<li class='active'>Create Manager</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_managers);
        $("#bread").append(li_managers_create);
        
        // highlight nav menu "Managers" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_managers").parent().addClass("active");
    </script>  
</c:if>
<!-- MANAGER CREATE RESULT -->
<c:if test='${view == "managers/create_post" }'>
    <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_managers = "<li><a href='/timesheet/managers'>Managers</a></li>";
        
        var li_managers_create = "<li class='active'>Create Manager</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_managers);
        $("#bread").append(li_managers_create);
        
        // highlight nav menu "Managers" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_managers").parent().addClass("active");
    </script>  
</c:if>

<!-- ======================== MANAGER END ========================= -->

