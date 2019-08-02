<%@taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title></title>
    </head>
    <style>
        .error {
            color: #ff0000;
        }

        .errorblock {
            color: #000;
            background-color: #ffEEEE;
            border: 3px solid #ff0000;
            padding: 8px;
            margin: 16px;
        }
    </style>

    <body>
        <h2>Task Information</h2>
        <!-- commandName = "taskCreate"   /timesheet/tasks -->
        <form:form method = "POST" action = "/timesheet/tasks" commandName = "taskCreate" >
            <form:errors path = "*" cssClass = "errorblock" element = "div" />
            <table>
                <tr>
                    <td><form:label path =  "description">Description</form:label></td>
                    <td><form:input path =  "description" /></td>
                    <td><form:errors path = "description" cssClass = "error" /></td>
                </tr>
                <tr>
                    <td><form:label path = "managers">Manager</form:label></td>
                        <td>
                        <form:select  path="managers"  multiple="false">
                            <form:option value="">-Please Select-</form:option>
                             <c:forEach var="man" items="${managers}">
                               
                              <form:option value="${man.id}">${man.name}</form:option>
                              
                           </c:forEach> 
                        </form:select>
                    </td>
                    <td><form:errors path = "managers" cssClass = "error" /></td>
                </tr>
                <tr>
                    <td colspan = "2">
                        <input type = "submit" value = "Submit"/>
                    </td>
                </tr>
            </table>  
        </form:form>
        <%-- To display selected value from dropdown list. --%>
    </body>
</html>