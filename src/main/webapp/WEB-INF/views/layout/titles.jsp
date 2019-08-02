
<% String title = "";%>

<!-- MAIN PAGE -->
<c:if test="${view == 'site/home'}">
    <% title = "Home";%> 
</c:if>

<!-- ======================== EMPLOYEE ========================= -->

<!-- EMPLOYEE LIST -->
<c:if test="${view == 'employees/list'}">
    <% title = "Employees's list";%> 
</c:if>
<!-- EMPLOYEE VIEW -->
<c:if test='${view == "employees/" }'>
    <% title = "View Employee";%> 
</c:if>
<!-- EMPLOYEE UPDATE -->
<c:if test='${view == "employees/update_get" }'>
    <% title = "Update Employee";%> 
</c:if>
<!-- EMPLOYEE UPDATE RESULT -->
<c:if test='${view == "employees/update_post" }'>
    <% title = "Update Employee";%> 
</c:if>
<!-- EMPLOYEE CREATE -->
<c:if test='${view == "employees/create_get" }'>
    <% title = "Create Employee";%>  
</c:if>
<!-- EMPLOYEE CREATE RESULT -->
<c:if test='${view == "employees/create_post" }'>
    <% title = "Create Employee";%>  
</c:if>

<!-- ======================== MANAGERS ========================= -->

<!-- MANAGER LIST -->
<c:if test="${view == 'managers/list'}">
    <% title = "Managers's list";%> 
</c:if>
<!-- MANAGER VIEW -->
<c:if test='${view == "managers/" }'>
    <% title = "View Manager";%> 
</c:if>
<!-- MANAGER UPDATE -->
<c:if test='${view == "managers/update_get" }'>
    <% title = "Update Manager";%> 
</c:if>
<!-- MANAGER UPDATE RESULT -->
<c:if test='${view == "managers/update_post" }'>
    <% title = "Update Manager";%> 
</c:if>
<!-- MANAGER CREATE -->
<c:if test='${view == "managers/create_get" }'>
    <% title = "Create Manager";%>  
</c:if>
<!-- MANAGER CREATE RESULT -->
<c:if test='${view == "managers/create_post" }'>
    <% title = "Create Manager";%>  
</c:if>

<!-- ======================== TASKS ========================= -->

<!-- TASKS LIST -->
<c:if test="${view == 'tasks/list'}">
    <% title = "Task's list";%>
</c:if>
<!-- TASKS VIEW -->
<c:if test='${view == "tasks/" }'>
    <% title = "View task";%> 
</c:if>
<!-- TASKS UPDATE -->
<c:if test='${view == "tasks/update_get" }'>
    <% title = "Update Task";%> 
</c:if>
<!-- TASKS UPDATE RESULT -->
<c:if test='${view == "tasks/update_post" }'>
    <% title = "Update Task";%> 
</c:if>
<!-- TASKS CREATE -->
<c:if test='${view == "tasks/create_get" }'>
    <% title = "Create Task";%> 
</c:if>
<!-- TASKS CREATE RESULT -->
<c:if test='${view == "tasks/create_post" }'>
    <% title = "Create Task";%> 
</c:if>


<!-- TASKS UPDATE AJAX -->
<c:if test='${view == "tasks/updateAjax" }'>
    <% title = "Update Task Ajax";%> 
</c:if>
<!-- TASKS UPDATE AJAX 2 -->
<c:if test='${view == "tasks/updateAjax2" }'>
    <% title = "Update Task Ajax2";%>  
</c:if>
<!-- TASKS UPDATE AJAX FORM -->
<c:if test='${view == "tasks/updateAjaxForm" }'>
    <% title = "Update Task Ajax Form";%>  
</c:if>
<!-- TASKS UPDATE AJAX SERVLET -->
<c:if test='${view == "tasks/updateAjaxServlet" }'>
    <% title = "Update Task Ajax Servlet";%>  
</c:if>

<!-- ==================== TIMESHEETS =========================== -->

<!-- TIMESHEETS LIST -->
<c:if test="${view == 'timesheets/list'}">
    <% title = "Task's list";%> 
</c:if>
<!-- TIMESHEETS VIEW -->
<c:if test='${view == "timesheets/" }'>
    <% title = "View Timesheet";%>  
</c:if>
<!-- TIMESHEETS UPDATE -->
<c:if test='${view == "timesheets/update_get" }'>
    <% title = "Update timesheet";%> 
</c:if>
<!-- TIMESHEETS UPDATE RESULT -->
<c:if test='${view == "timesheets/update_post" }'>
    <% title = "Update timesheet";%>
</c:if>
<!-- TIMESHEETS CREATE -->
<c:if test='${view == "timesheets/create_get" }'>
    <% title = "Create timesheet";%> 
</c:if>
<!-- TIMESHEETS CREATE RESULT -->
<c:if test='${view == "timesheets/create_post" }'>
    <% title = "Create timesheet";%> 
</c:if>

<!-- ================ TIMESHEET-SERVICE========================= -->

<!-- TIMESHEET-SERVICE MENU -->
<c:if test="${view == 'timesheet-service/menu'}">
    <% title = "Service";%>
</c:if>
<!-- TIMESHEET-SERVICE MANAGER TASKS -->
<c:if test="${view == 'timesheet-service/manager-tasks'}">
    <% title = "Manager's Tasks"; %> 
</c:if>
<!-- TIMESHEET-SERVICE EMPLOYEE TASKS -->
<c:if test="${view == 'timesheet-service/employee-tasks'}">
    <% title = "Employee's Tasks";%> 
</c:if>

<!-- ================ SITE ========================= -->

<!-- SIGNUP -->
<c:if test="${view == 'site/signup_get'}">
    <% title = "Signup";%> 
</c:if>
<!-- SIGNUP -->
<c:if test="${view == 'site/signup_post'}">
    <% title = "Signup";%> 
</c:if>
<!-- LOGIN -->
<c:if test="${view == 'site/login_get'}">
    <% title = "Login";%> 
</c:if>
<!-- LOGIN -->
<c:if test="${view == 'site/login_post'}">
    <% title = "Login";%> 
</c:if>