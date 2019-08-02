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

<h2>Update timesheet's  ${tsCommand.timesheet.who.name}</h2>
<!-- commandName = "employeeUpdate" -->
<form:form method = "POST" action = "/timesheet/timesheets/${tsCommand.timesheet.id}" commandName = "tsCommand" >
    <form:errors path = "*" cssClass = "errorblock" element = "div" />

    <div class="form-group required">
        <form:label path = "hours" cssClass="control-label">Hours</form:label>
        <form:input path = "hours" id="hours" cssClass="form-control"/>
        <form:errors path = "hours" cssClass = "help-block" />
    </div>    

    <div class="form-group">
        <form:label path="" cssClass="control-label">Tasks</form:label>
        <form:input path = "" disabled="true" cssClass="form-control" value="${tsCommand.timesheet.task.description}"/>
    </div>    

    <div class="form-group">
        <td><form:label path = ""  cssClass="control-label">Manager</form:label></td>
        <td><form:input path = "" disabled="true" cssClass="form-control" value="${tsCommand.timesheet.task.manager.name}"/></td>
    </div>    

    <form:hidden path = "id"  value="${tsCommand.timesheet.id}" disabled="true" />

    <div class="form-group">
        <input type = "submit" class="btn btn-primary" value = "Update"/>
    </div>

</form:form>

<c:if test='${try_update == "updated" }'>
    <script>
      
        var h = $("#hours");
        if (h.val().length <= 0) {
            h.closest('.form-group').addClass("has-error");
            h.closest('.form-group').removeClass("has-success");
            // $("#comprarButtonId").prop('disabled', true);
        } else {
            h.closest('.form-group').removeClass("has-error");
            h.closest('.form-group').addClass("has-success");
        }
    </script>
</c:if>