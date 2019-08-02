<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>

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

<h2>Update Employee</h2>
<!-- commandName = "employeeCreate" -->
<form:form method = "POST" action = "/timesheet/employees/${employee.id}" commandName = "employeeUpdate" >
    <form:errors path = "*" cssClass = "errorblock" element = "div" />

    <div class="form-group required">
        <form:label path =  "department" cssClass="control-label">Department</form:label>
        <c:choose>
            <c:when test='${try_update != "updated" }'>  
                <form:select  path="department" id="department_id" cssClass="form-control" maxlength="64"  multiple="false">
                    <form:option value="">-Please Select-</form:option>    
                        <option value="management"
                        <c:if test="${employee.department == 'management'}">selected="selected"</c:if> >
                            Management</option>
                        <option value="engineering"
                        <c:if test="${employee.department == 'engineering'}">selected="selected"</c:if> >
                            Engineering</option>
                        <option value="R&D"
                        <c:if test="${employee.department == 'R&D'}">selected="selected"</c:if> >
                            R&D</option>
                    </form:select>
                </c:when>
                <c:otherwise>
                    <form:select  path="department" id="department_id" cssClass="form-control" maxlength="64"  multiple="false">
                        <form:option value="">-Please Select-</form:option>    
                        <option value="management"
                        <c:if test="${selectedDepartment == 'management'}">selected="selected"</c:if> >
                            Management</option>
                        <option value="engineering"
                        <c:if test="${selectedDepartment == 'engineering'}">selected="selected"</c:if> >
                            Engineering</option>
                        <option value="R&D"
                        <c:if test="${selectedDepartment == 'R&D'}">selected="selected"</c:if> >
                            R&D</option>
                    </form:select>
                </c:otherwise>
            </c:choose>
            <form:errors path = "department" cssClass = "help-block" />
    </div>         

    <div class="form-group required">     
        <form:label path = "name" cssClass="control-label">Name</form:label>
        <c:choose>
            <c:when test='${try_update != "updated" }'>  
                <form:input path = "name" id="name_id" cssClass="form-control" maxlength="64" value="${employee.name}" />
            </c:when>
            <c:otherwise>
                <form:input path = "name" id="name_id" cssClass="form-control" maxlength="64" value="" />
            </c:otherwise>
        </c:choose>
        <form:errors path = "name" cssClass = "help-block" />
    </div>     

    <div class="form-group"> 
        <form:label path = "id" cssClass="control-label">Id</form:label>
        <form:input path = "id" cssClass="form-control" maxlength="64" value="${employee.id}" disabled="true" />
    </div>        

    <div class="form-group"> 
        <input type = "submit" class="btn btn-primary" value = "Update"/>
    </div>

</form:form>

<!-- when button "Update" has been already clicked add and remove classes for error and right filled fields  -->
<c:if test='${try_update == "updated" }'>
    <script>
        //$("#department_id").blur(function(){
        var d = $("#department_id");
        if (d.val().length <= 0) {
            d.closest('.form-group').addClass("has-error");
            d.closest('.form-group').removeClass("has-success");
            // $("#comprarButtonId").prop('disabled', true);
        } else {
            d.closest('.form-group').removeClass("has-error");
            d.closest('.form-group').addClass("has-success");
        }

        var n = $("#name_id");
        if (n.val().length <= 0) {
            n.closest('.form-group').addClass("has-error");
            n.closest('.form-group').removeClass("has-success");
            // $("#comprarButtonId").prop('disabled', true);
        } else {
            n.closest('.form-group').removeClass("has-error");
            n.closest('.form-group').addClass("has-success");
        }

        //});
    </script>
</c:if>

