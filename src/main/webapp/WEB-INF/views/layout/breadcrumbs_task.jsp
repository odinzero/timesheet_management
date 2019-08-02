

<!-- ======================== TASK ========================= -->

<!-- TASK LIST -->
<c:if test="${view == 'tasks/list'}">
    <script>
        $("#bread").addClass("breadcrumb");

        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";

        var li_tasks = "<li class='active'>Tasks</a></li>";

        $("#bread").append(li_home);
        $("#bread").append(li_tasks);

        // highlight nav menu "Tasks" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_tasks").parent().addClass("active");
    </script> 
</c:if>

<!-- TASK VIEW -->
<c:if test='${view == "tasks/" }'>
    <script>
        $("#bread").addClass("breadcrumb");

        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";

        var li_tasks = "<li><a href='/timesheet/tasks'>Tasks</a></li>";

        var li_tasks_name = "<li class='active'>${task.id}</a></li>";

        $("#bread").append(li_home);
        $("#bread").append(li_tasks);
        $("#bread").append(li_tasks_name);

        // highlight nav menu "Tasks" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_tasks").parent().addClass("active");
    </script>
</c:if>

<!-- TASK UPDATE -->
<c:if test='${view == "tasks/update_get" }'>
    <script>
        $("#bread").addClass("breadcrumb");

        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";

        var li_tasks = "<li><a href='/timesheet/tasks'>Tasks</a></li>";

        var li_tasks_view = "<li><a href='/timesheet/tasks/${task.id}'>${task.id}</a></li>";

        var li_tasks_update = "<li class='active'>Update</a></li>";

        $("#bread").append(li_home);
        $("#bread").append(li_tasks);
        $("#bread").append(li_tasks_view);
        $("#bread").append(li_tasks_update);

        // highlight nav menu "Tasks" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_tasks").parent().addClass("active");
    </script> 
</c:if>

<!-- TASKS UPDATE AJAX -->
<c:if test='${view == "tasks/updateAjax" }'>
    <script>
        $("#bread").addClass("breadcrumb");

        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";

        var li_tasks = "<li><a href='/timesheet/tasks'>Tasks</a></li>";

        var li_tasks_view = "<li><a href='/timesheet/tasks/${task.id}'>${task.id}</a></li>";

        var li_tasks_update = "<li class='active'>Update Ajax</a></li>";

        $("#bread").append(li_home);
        $("#bread").append(li_tasks);
        $("#bread").append(li_tasks_view);
        $("#bread").append(li_tasks_update);

        // highlight nav menu "Tasks" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_tasks").parent().addClass("active");
    </script>
</c:if>

<!-- TASKS UPDATE AJAX 2 -->
<c:if test='${view == "tasks/updateAjax2" }'>
     <script>
        $("#bread").addClass("breadcrumb");

        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";

        var li_tasks = "<li><a href='/timesheet/tasks'>Tasks</a></li>";

        var li_tasks_view = "<li><a href='/timesheet/tasks/${task.id}'>${id}</a></li>";

        var li_tasks_update = "<li class='active'>Update Ajax 2</a></li>";

        $("#bread").append(li_home);
        $("#bread").append(li_tasks);
        $("#bread").append(li_tasks_view);
        $("#bread").append(li_tasks_update);

        // highlight nav menu "Tasks" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_tasks").parent().addClass("active");
    </script>
</c:if>
<!-- TASKS UPDATE AJAX FORM -->
<c:if test='${view == "tasks/updateAjaxForm" }'>
     <script>
        $("#bread").addClass("breadcrumb");

        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";

        var li_tasks = "<li><a href='/timesheet/tasks'>Tasks</a></li>";

        var li_tasks_view = "<li><a href='/timesheet/tasks/${task.id}'>${id}</a></li>";

        var li_tasks_update = "<li class='active'>Update Ajax Form</a></li>";

        $("#bread").append(li_home);
        $("#bread").append(li_tasks);
        $("#bread").append(li_tasks_view);
        $("#bread").append(li_tasks_update);

        // highlight nav menu "Tasks" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_tasks").parent().addClass("active");
    </script>
</c:if>
<!-- TASKS UPDATE AJAX SERVLET -->
<c:if test='${view == "tasks/updateAjaxServlet" }'>
     <script>
        $("#bread").addClass("breadcrumb");

        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";

        var li_tasks = "<li><a href='/timesheet/tasks'>Tasks</a></li>";

        var li_tasks_view = "<li><a href='/timesheet/tasks/${task.id}'>${task.id}</a></li>";

        var li_tasks_update = "<li class='active'>Update Ajax Servlet</a></li>";

        $("#bread").append(li_home);
        $("#bread").append(li_tasks);
        $("#bread").append(li_tasks_view);
        $("#bread").append(li_tasks_update);

        // highlight nav menu "Tasks" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_tasks").parent().addClass("active");
    </script>
</c:if>        

<!-- TASK UPDATE RESULT -->
<c:if test='${view == "managers/update_post" }'>
    <script>
        $("#bread").addClass("breadcrumb");

        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";

        var li_tasks = "<li><a href='/timesheet/tasks'>Tasks</a></li>";

        var li_tasks_view = "<li><a href='/timesheet/tasks/${task.id}'>${task.id}</a></li>";

        var li_tasks_update = "<li class='active'>Update</a></li>";

        $("#bread").append(li_home);
        $("#bread").append(li_tasks);
        $("#bread").append(li_tasks_view);
        $("#bread").append(li_tasks_update);

        // highlight nav menu "Tasks" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_tasks").parent().addClass("active");
    </script>
</c:if>

<!-- TASK CREATE -->
<c:if test='${view == "tasks/create_get" }'>
    <script>
        $("#bread").addClass("breadcrumb");

        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";

        var li_tasks = "<li><a href='/timesheet/tasks'>Tasks</a></li>";

        var li_tasks_create = "<li class='active'>Create Task</a></li>";

        $("#bread").append(li_home);
        $("#bread").append(li_tasks);
        $("#bread").append(li_tasks_create);

        // highlight nav menu "Tasks" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_tasks").parent().addClass("active");
    </script>  
</c:if>
<!-- TASK CREATE RESULT -->
<c:if test='${view == "tasks/create_post" }'>
    <script>
        $("#bread").addClass("breadcrumb");

        var li_home = "<li><a href='/timesheet/site/home'>Home</a></li>";

        var li_tasks = "<li><a href='/timesheet/tasks'>Tasks</a></li>";

        var li_tasks_create = "<li class='active'>Create Task</a></li>";

        $("#bread").append(li_home);
        $("#bread").append(li_tasks);
        $("#bread").append(li_tasks_create);

        // highlight nav menu "Tasks" see file header.jsp
        $(".nav").find(".active").removeClass("active");
        $("#menu_tasks").parent().addClass("active");
    </script>  
</c:if>

<!-- ======================== TASK END ========================= -->

