


<nav id="w1" class="navbar-inverse navbar-fixed-top navbar">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#w1-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>

            <a class="navbar-brand" href="/timesheet/site/home">Timesheet management</a>

        </div>

        <div id="w1-collapse" class="collapse navbar-collapse">
            <ul id="my_header" class="navbar-nav navbar-right nav">
                <li><a href="/timesheet/site/home" id="menu_home" >Home</a></li>
                <li><a href="/timesheet/employees" id="menu_employees">Employees</a></li>
                <li><a href="/timesheet/managers" id="menu_managers">Managers</a></li>
                <li><a href="/timesheet/tasks" id="menu_tasks">Tasks</a></li>
                <li><a href="/timesheet/timesheet-service" id="menu_service">Service</a></li>
                <li><a href="/timesheet/timesheets" id="menu_timesheets">Timesheets</a></li>
                
                <li><a href="/timesheet/site/signup?new" id="menu_signup">Signup</a></li>
                <li><a href="/timesheet/site/login" id="menu_login">Login</a></li>
                
                <li>
                    <form action="/MYBLOG/web/site/logout" method="post">
                        <input type="hidden" name="_csrf" value="scrf">
                        <button type="submit" class="btn btn-link logout">logout(admin)</button>
                    </form>
                </li>
            </ul>
        </div>
    </div>
</nav>


<ul class="breadcrumb" id="bread" style="margin-top: 80px;">
    <%@include file="breadcrumbs_site.jsp" %>
    <%@include file="breadcrumbs_employee.jsp" %>
    <%@include file="breadcrumbs_manager.jsp" %>
    <%@include file="breadcrumbs_task.jsp" %>
    <%@include file="breadcrumbs_timesheet.jsp" %>
    <%@include file="breadcrumbs_service.jsp" %>
</ul>
