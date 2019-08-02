<%@taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Spring MVC Form Handling</title>
    </head>
    <body>
        <h2>Submitted User Information</h2>
        <table>
            <tr>
                <td>Task</td>
                <td>${task}</td>
            </tr>
            <tr>
                <td>Completed</td>
                <td>${completed}</td>
            </tr>
            <tr>
                <td>Description</td>
                <td>${description}</td>
            </tr>
             <tr>
                <td>Manager</td>
                <td>${manager}</td>
            </tr>        
            <tr>
                <td> Assigned Employees</td>
                <c:forEach var="employee" items="${assignedEmployees}">
                <tr>
                   <td>${employee.id}</td>
                   <td>${employee.department}</td>
                    <td>${employee.name}</td>
                </tr>
            </c:forEach>
        </tr> 
        <tr>
                <td> Unassigned Employees</td>
                <c:forEach var="employee" items="${unassignedEmployees}">
                <tr>
                    <td>${employee.id}</td>
                    <td>${employee.department}</td>
                    <td>${employee.name}</td>
                </tr>
            </c:forEach>
        </tr>        
    </table>  
</body>
</html>