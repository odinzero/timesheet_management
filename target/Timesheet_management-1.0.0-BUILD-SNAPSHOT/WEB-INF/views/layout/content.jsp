<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="<spring:url value="/resources/css/bootstrap-3.3.7-dist/css/bootstrap.css"/>">
        <script type="text/javascript" src="<spring:url value="/resources/js/jquery-3.4.1.js"/>"></script>
        <script type="text/javascript" src="<spring:url value="/resources/css/bootstrap-3.3.7-dist/js/bootstrap.js"/>"></script>     

        <%@include file="titles.jsp" %>
        <title><%= title%></title>

        <style>
            .wrap {
                min-height: 100%;
                height: auto;
                margin: 0 auto -60px;
                padding: 0 0 60px;
            }
            .footer {
                height: 60px;
                background-color: #f5f5f5;
                border-top: 1px solid #ddd;
                padding-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class="wrap">
            <div class="container">

                <!-- HEADER -->
                <%@include file="../layout/header.jsp" %>

                <!-- MAIN PAGE -->
                <c:if test="${view == 'site/home'}">
                    <%@include file="../../views/home.jsp" %> 
                </c:if>

                <!-- ======================== EMPLOYEE ========================= -->

                <!-- EMPLOYEE LIST -->
                <c:if test="${view == 'employees/list'}">
                    <%@include file="../employees/list.jsp" %> 
                </c:if>
                <!-- EMPLOYEE VIEW -->
                <c:if test='${view == "employees/" }'>
                    <%@include file="../employees/view.jsp" %> 
                </c:if>
                <!-- EMPLOYEE UPDATE -->
                <c:if test='${view == "employees/update_get" }'>
                    <%@include file="../employees/update.jsp" %> 
                </c:if>
                <!-- EMPLOYEE UPDATE RESULT -->
                <c:if test='${view == "employees/update_post" }'>
                    <%@include file="../employees/update.jsp" %> 
                </c:if>
                <!-- EMPLOYEE CREATE -->
                <c:if test='${view == "employees/create_get" }'>
                    <%@include file="../employees/new.jsp" %> 
                </c:if>
                <!-- EMPLOYEE CREATE RESULT -->
                <c:if test='${view == "employees/create_post" }'>
                    <%@include file="../employees/new.jsp" %> 
                </c:if>

                <!-- ======================== MANAGERS ========================= -->

                <!-- MANAGERS LIST -->
                <c:if test="${view == 'managers/list'}">
                    <%@include file="../managers/list.jsp" %> 
                </c:if>
                <!-- MANAGER VIEW -->
                <c:if test='${view == "managers/" }'>
                    <%@include file="../managers/view.jsp" %> 
                </c:if>
                <!-- MANAGERS UPDATE -->
                <c:if test='${view == "managers/update_get" }'>
                    <%@include file="../managers/update.jsp" %> 
                </c:if>
                <!-- MANAGERS UPDATE RESULT -->
                <c:if test='${view == "managers/update_post" }'>
                    <%@include file="../managers/update.jsp" %> 
                </c:if>
                <!-- MANAGERS CREATE -->
                <c:if test='${view == "managers/create_get" }'>
                    <%@include file="../managers/new.jsp" %> 
                </c:if>
                <!-- MANAGERS CREATE RESULT -->
                <c:if test='${view == "managers/create_post" }'>
                    <%@include file="../managers/new.jsp" %> 
                </c:if>

                <!-- ======================== TASKS ============================ -->

                <!-- TASKS LIST -->
                <c:if test="${view == 'tasks/list'}">
                    <%@include file="../tasks/list.jsp" %> 
                </c:if>
                <!-- TASKS VIEW -->
                <c:if test='${view == "tasks/" }'>
                    <%@include file="../tasks/view.jsp" %> 
                </c:if>
                <!-- TASKS UPDATE -->
                <c:if test='${view == "tasks/update_get" }'>
                    <%@include file="../tasks/update.jsp" %> 
                </c:if>
                <!-- TASKS UPDATE RESULT -->
                <c:if test='${view == "tasks/update_post" }'>
                    <%@include file="../tasks/update.jsp" %> 
                </c:if>
                <!-- TASKS CREATE -->
                <c:if test='${view == "tasks/create_get" }'>
                    <%@include file="../tasks/new.jsp" %> 
                </c:if>
                <!-- TASKS CREATE RESULT -->
                <c:if test='${view == "tasks/create_post" }'>
                    <%@include file="../tasks/new.jsp" %> 
                </c:if>


                <!-- TASKS UPDATE AJAX -->
                <c:if test='${view == "tasks/updateAjax" }'>
                    <%@include file="../tasks/updateAjax.jsp" %> 
                </c:if>
                <!-- TASKS UPDATE AJAX 2 -->
                <c:if test='${view == "tasks/updateAjax2" }'>
                    <%@include file="../tasks/updateAjax2.jsp" %> 
                </c:if>
                <!-- TASKS UPDATE AJAX FORM -->
                <c:if test='${view == "tasks/updateAjaxForm" }'>
                    <%@include file="../tasks/updateAjaxForm.jsp" %> 
                </c:if>
                <!-- TASKS UPDATE AJAX SERVLET -->
                <c:if test='${view == "tasks/updateAjaxServlet" }'>
                    <%@include file="../tasks/updateAjaxServlet.jsp" %> 
                </c:if>


                <!-- ================ TIMESHEET-SERVICE========================= -->

                <!-- TIMESHEET-SERVICE MENU -->
                <c:if test="${view == 'timesheet-service/menu'}">
                    <%@include file="../timesheet-service/menu.jsp" %> 
                </c:if>
                <!-- TIMESHEET-SERVICE MANAGER TASKS -->
                <c:if test="${view == 'timesheet-service/manager-tasks'}">
                    <%@include file="../timesheet-service/manager-tasks.jsp" %> 
                </c:if>
                <!-- TIMESHEET-SERVICE EMPLOYEE TASKS -->
                <c:if test="${view == 'timesheet-service/employee-tasks'}">
                    <%@include file="../timesheet-service/employee-tasks.jsp" %> 
                </c:if>

                <!-- ==================== TIMESHEETS =========================== -->

                <!-- TIMESHEETS LIST -->
                <c:if test="${view == 'timesheets/list'}">
                    <%@include file="../timesheets/list.jsp" %> 
                </c:if>
                <!-- TIMESHEETS VIEW -->
                <c:if test='${view == "timesheets/" }'>
                    <%@include file="../timesheets/view.jsp" %> 
                </c:if>
                <!-- TIMESHEETS UPDATE -->
                <c:if test='${view == "timesheets/update_get" }'>
                    <%@include file="../timesheets/update.jsp" %> 
                </c:if>
                <!-- TIMESHEETS UPDATE RESULT -->
                <c:if test='${view == "timesheets/update_post" }'>
                    <%@include file="../timesheets/update.jsp" %> 
                </c:if>
                <!-- TIMESHEETS CREATE -->
                <c:if test='${view == "timesheets/create_get" }'>
                    <%@include file="../timesheets/new.jsp" %> 
                </c:if>
                <!-- TIMESHEETS CREATE RESULT -->
                <c:if test='${view == "timesheets/create_post" }'>
                    <%@include file="../timesheets/new.jsp" %> 
                </c:if>

                <!-- ==================== SITE =========================== -->

                <!-- SIGNUP -->
                <c:if test="${view == 'site/signup_get'}">
                    <%@include file="../site/signup.jsp" %> 
                </c:if>
                <!-- SIGNUP -->
                <c:if test="${view == 'site/signup_post'}">
                    <%@include file="../site/signup.jsp" %> 
                </c:if>
                <!-- LOGIN -->
                <c:if test="${view == 'site/login_get'}">
                    <%@include file="../site/login.jsp" %> 
                </c:if>
                <!-- LOGIN -->
                <c:if test="${view == 'site/login_post'}">
                    <%@include file="../site/login.jsp" %> 
                </c:if>

            </div>
        </div>
        
                  <!-- FOOTER -->
                <%@include file="../layout/footer.jsp" %>    

    </body>
</html>
