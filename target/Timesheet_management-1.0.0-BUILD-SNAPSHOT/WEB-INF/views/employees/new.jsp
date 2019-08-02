<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

<h2> Create Employee </h2>
<!-- commandName = "employeeCreate" -->
<form:form method = "POST" action = "/timesheet/employees" commandName = "employeeCreate" >
    <form:errors path = "*" cssClass = "errorblock" element = "div" />

    <div class="form-group">
        <form:label path =  "department" cssClass="control-label">Department</form:label>
            <c:choose>
                <c:when test='${try_create != "created" }'>  
                <form:select  path="department" id="create_department" cssClass="form-control" maxlength="64"  multiple="false">
                    <form:option value="">-Please Select-</form:option>    
                    <option value="management" > Management</option>
                    <option value="engineering" > Engineering</option>
                    <option value="R&D" > R&D</option>
                </form:select>
            </c:when>
            <c:otherwise>
                <form:select  path="department" id="create_department" cssClass="form-control" maxlength="64"  multiple="false">
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

    <div class="form-group">
        <form:label path = "name">Name</form:label>
        <form:input path = "name" id="create_name" cssClass="form-control" maxlength="64" />
        <form:errors path = "name" cssClass = "help-block" />
    </div>

    <div class="form-group"> 
        <input type = "submit" class="btn btn-primary" value = "Create"/>
    </div>

</form:form>

<!-- when button "Create" has been already clicked add and remove classes for error and right filled fields  -->
<c:if test='${try_create == "created" }'>
    <script>
        //$("#department_id").blur(function(){
        var d = $("#create_department");
        if (d.val().length <= 0) {
            d.closest('.form-group').addClass("has-error");
            d.closest('.form-group').removeClass("has-success");
            // $("#comprarButtonId").prop('disabled', true);
        } else {
            d.closest('.form-group').removeClass("has-error");
            d.closest('.form-group').addClass("has-success");
        }

        var n = $("#create_name");
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
