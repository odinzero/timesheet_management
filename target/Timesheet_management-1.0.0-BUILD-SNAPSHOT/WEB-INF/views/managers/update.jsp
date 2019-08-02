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


<h2>Update Manager</h2>
<!-- commandName = "employeeCreate" -->
<form:form method = "POST" action = "/timesheet/managers/${manager.id}" commandName = "managerUpdate" >
    <form:errors path = "*" cssClass = "errorblock" element = "div" />

    <div class="form-group required">
        <form:label path = "name" cssClass="control-label">Name</form:label>
        <form:input path = "name" cssClass="form-control" id="manager_name_id" value="${manager.name}" />
        <form:errors path = "name" cssClass = "help-block" />
    </div>   

    <div class="form-group required">
        <form:label path = "id" cssClass="control-label">Id</form:label>
        <form:input path = "id" cssClass="form-control" value="${manager.id}" disabled="true" />
    </div>

    <div class="form-group"> 
        <input type = "submit" class="btn btn-primary" value = "Update"/>
    </div>

</form:form>

<!-- when button "Update" has been already clicked add and remove classes for error and right filled fields  -->
<c:if test='${try_update == "updated" }'>
    <script>
      
        var mn = $("#manager_name_id");
        if (mn.val().length <= 0) {
            mn.closest('.form-group').addClass("has-error");
            mn.closest('.form-group').removeClass("has-success");
            // $("#comprarButtonId").prop('disabled', true);
        } else {
            mn.closest('.form-group').removeClass("has-error");
            mn.closest('.form-group').addClass("has-success");
        }
    </script>
</c:if>    
