

<!-- ======================== TIMESHEET ========================= -->

<!-- TIMESHEET LIST -->
<c:if test="${view == 'timesheets/list'}">
    <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_timesheets = "<li class='active'>Timesheets</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_timesheets);
        
        // highlight nav menu "Timesheets" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_timesheets").parent().addClass("active");
    </script> 
</c:if>

<!-- TIMESHEET VIEW -->
<c:if test='${view == "timesheets/" }'>
    <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_timesheets = "<li><a href='/timesheet/timesheets'>Timesheets</a></li>";
        
        var li_timesheets_name = "<li class='active'>${tsCommand.timesheet.id}</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_timesheets);
        $("#bread").append(li_timesheets_name);
        
        // highlight nav menu "Timesheets" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_timesheets").parent().addClass("active");
    </script>
</c:if>
        
<!-- TIMESHEET UPDATE -->
<c:if test='${view == "timesheets/update_get" }'>
    <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_timesheets = "<li><a href='/timesheet/timesheets'>Timesheets</a></li>";
        
        var li_timesheets_view = "<li><a href='/timesheet/timesheets/${tsCommand.timesheet.id}'>${tsCommand.timesheet.who.name}</a></li>";
        
        var li_timesheets_update = "<li class='active'>Update</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_timesheets);
        $("#bread").append(li_timesheets_view);
        $("#bread").append(li_timesheets_update);
        
        // highlight nav menu "Timesheets" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_timesheets").parent().addClass("active");
    </script> 
</c:if>

<!-- TIMESHEET UPDATE RESULT -->
<c:if test='${view == "timesheets/update_post" }'>
     <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_timesheets = "<li><a href='/timesheet/timesheets'>Timesheets</a></li>";
        
        var li_timesheets_view = "<li><a href='/timesheet/timesheets/${tsCommand.timesheet.id}'>${tsCommand.timesheet.who.name}</a></li>";
        
        var li_timesheets_update = "<li class='active'>Update</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_timesheets);
        $("#bread").append(li_timesheets_view);
        $("#bread").append(li_timesheets_update);
        
        // highlight nav menu "Timesheets" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_timesheets").parent().addClass("active");
    </script>
</c:if>

<!-- TIMESHEET CREATE -->
<c:if test='${view == "timesheets/create_get" }'>
    <script>
        $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_timesheets = "<li><a href='/timesheet/timesheets'>Timesheets</a></li>";
        
        var li_timesheets_create = "<li class='active'>Create Timesheet</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_timesheets);
        $("#bread").append(li_timesheets_create);
        
        // highlight nav menu "Timesheet" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_timesheets").parent().addClass("active");
    </script>  
</c:if>
<!-- TIMESHEET CREATE RESULT -->
<c:if test='${view == "timesheets/create_post" }'>
    <script>
         $("#bread").addClass("breadcrumb");
       
        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";
        
        var li_timesheets = "<li><a href='/timesheet/timesheets'>Timesheets</a></li>";
        
        var li_timesheets_create = "<li class='active'>Create Timesheet</a></li>";
        
        $("#bread").append(li_home);
        $("#bread").append(li_timesheets);
        $("#bread").append(li_timesheets_create);
        
        // highlight nav menu "Timesheet" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_timesheets").parent().addClass("active");
    </script>  
</c:if>

<!-- ======================== TIMESHEET END ========================= -->

