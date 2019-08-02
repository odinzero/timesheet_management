
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

<h2>Create Manager</h2>
<!-- commandName = "employeeCreate" -->
<form:form method = "POST" action = "/timesheet/managers" commandName = "managerCreate" >
    <form:errors path = "*" cssClass = "errorblock" element = "div" />

    <div class="form-group">
        <form:label path = "name" cssClass="control-label">Name</form:label>
        <form:input path = "name" id="create_manager_name" cssClass="form-control" maxlength="64" />
        <form:errors path = "name" cssClass = "help-block" />
    </div>

    <div class="form-group"> 
        <input type = "submit" class="btn btn-primary" value = "Create"/>
    </div>

</form:form>

<!-- when button "Create" has been already clicked add and remove classes for error and right filled fields  -->
<c:if test='${try_create == "created" }'>
    <script>
      
        var d = $("#create_manager_name");
        if (d.val().length <= 0) {
            d.closest('.form-group').addClass("has-error");
            d.closest('.form-group').removeClass("has-success");
            // $("#comprarButtonId").prop('disabled', true);
        } else {
            d.closest('.form-group').removeClass("has-error");
            d.closest('.form-group').addClass("has-success");
        }
    </script>
</c:if>

