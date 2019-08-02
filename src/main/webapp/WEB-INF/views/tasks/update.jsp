<%@taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
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

<h2>Update Task</h2>
<p>${newSelectedManager}</p>
<!-- commandName = "taskCreate"   /timesheet/tasks -->
<form:form method = "POST" action = "/timesheet/tasks/${task.id}" id="taskUpdate" commandName = "taskUpdate" >
    <form:errors path = "*" cssClass = "errorblock" element = "div" />

    <div class="form-group required">
        <form:label path =  "description" cssClass="control-label">Description</form:label>
        <form:input path =  "description" cssClass="form-control" id="description_id" maxlength="64" value="${task.description}" />
        <form:errors path = "description" cssClass="help-block" id="description_error" />
    </div>   

    <!-- DROPDOWN LIST =MANAGERS= -->
    <div class="form-group required">
        <form:label path = "managers" cssClass="control-label">Manager</form:label>
        <form:select  path="managers" cssClass="form-control" id="managers_id" multiple="false">
            <form:option value="">-Please Select-</form:option>
            <c:forEach var="man" items="${managers}">

                <option value="${man.id}"
                        <c:if test="${man.id eq selectedManId}">selected="selected"</c:if>>
                    ${man.name}
                </option>

            </c:forEach> 
        </form:select> 
        <form:errors path = "managers" cssClass = "help-block" id="managers_error" />
    </div>

    <div class="form-group">
        <form:label path = "completed" cssClass="control-label">Completed</form:label>&nbsp;&nbsp;&nbsp;
        <form:checkbox path = "completed" id="completed"  value="${task.completed}"/>
    </div>

    <!-- DROPDOWN LIST =ASSIGNED EMPLOYEES= --> 
    <div class="form-group required">
        <table class="table-condensed">
            <td><form:label path = "assignedEmployees" cssClass="control-label">Employees</form:label></td>
            <td><form:select  path="assignedEmployees" id="assignedEmployees"  multiple="true" cssClass="form-control"
                          colspan = "0"  style="width: 150px;">
                    <c:forEach var="aemployees" items="${assignedEmployees}">

                    <option value="${aemployees.id}">${aemployees.name}</option>

                </c:forEach> 
            </form:select>
            <td>
                <!-- button >> REMOVE assigned employee -->
                <button type="reset" id="removeAssignedEmployee" class="btn btn-info"  >>></button>
                <!-- button << ADD assigned employee -->
                <button type="reset" id="removeUnassignedEmployee" class="btn btn-info" ><<</button> 
            </td>
            </td>
            <!-- DROPDOWN LIST =UNASSIGNED EMPLOYEES= --> 
            <td><form:select  path="unassignedEmployees" id="unassignedEmployees" cssClass="form-control"  multiple="true"
                          colspan = "2"  style="width: 150px;">
                    <c:forEach var="uemployees" items="${unassignedEmployees}">

                    <option value="${uemployees.id}">${uemployees.name}</option>

                </c:forEach> 
            </form:select>
            </td>
            <tr>
                <td></td>
                <td><form:label path = "assignedEmployees" cssClass="control-label">Assigned</form:label></td>
                    <td></td>
                    <td><form:label path = "unassignedEmployees" >Unassigned</form:label></td>
            </tr>
            <tr>
                <td colspan="7"><form:errors path = "assignedEmployees" cssClass = "help-block" id="assignedEmployees_error" /></td> 
            </tr>
        </table>
    </div>

    <div class="form-group"> 
        <input type = "submit" class="btn btn-primary" value = "Update"/>
    </div>

</form:form>
<%-- To display selected value from dropdown list. --%>
<script>
    // checkbox "COMPLETED" set checked state
    $("#completed").prop("checked", ${task.completed} );
    
    $("#assignedEmployees").val([]);
    $("#unassignedEmployees").val([]);

    $(document).on('submit', 'form#taskUpdate', function() {

        $("#assignedEmployees").val([]);
        // select all employees in assigned dropdown list
        $('#assignedEmployees').children('option').prop('selected', true);


    });

    var val = null;
    var text = null;
    var option = null;

    // BUTTON '>>'  remove assigned employee
    $(document).on('click', '#removeAssignedEmployee', function() {

        // remove selected OPTION from aasigned employee
        $("#assignedEmployees option:selected").each(function() {

            val = $(this).val();
            text = $(this).text();

            $(this).remove();

            option = "<option value=" + val + ">" + text + "</option>";
            // add option to unassigned employees
            $('#unassignedEmployees').append(option);
        });

        $("#assignedEmployees").val([]);
        $("#unassignedEmployees").val([]);
        // select all employees in assigned dropdown list
        $('#assignedEmployees').children('option').prop('selected', false);
        $('#unassignedEmployees').children('option').prop('selected', false);
    });

    // BUTTON '<<'  add assigned employee
    $(document).on('click', '#removeUnassignedEmployee', function() {

        // alert('add');
        // remove selected OPTION from aasigned employee
        $("#unassignedEmployees option:selected").each(function() {

            val = $(this).val();
            text = $(this).text();

            $(this).remove();

            option = "<option value=" + val + ">" + text + "</option>";
            // add option to unassigned employees
            $('#assignedEmployees').append(option);
        });

        $("#assignedEmployees").val([]);
        $("#unassignedEmployees").val([]);
        // select all employees in assigned dropdown list
        $('#assignedEmployees').children('option').prop('selected', false);
        $('#unassignedEmployees').children('option').prop('selected', false);
    });
</script>

<!-- when button "Update" has been already clicked add and remove classes for error and good filled fields  -->
<c:if test='${try_update == "updated" }'>
    <script>
        // Field "Description"
        var de = $("#description_error");
        if (de.text() != "") {
            $("#description_id").closest('.form-group').addClass("has-error");
            $("#description_id").closest('.form-group').removeClass("has-success");
        } else {
            $("#description_id").closest('.form-group').removeClass("has-error");
            $("#description_id").closest('.form-group').addClass("has-success");
        }
        
        // DROPDOWN LIST =MANAGERS=
        var me = $("#managers_error");
        if (me.text() != "") {
            $("#managers_id").closest('.form-group').addClass("has-error");
            $("#managers_id").closest('.form-group').removeClass("has-success");
        } else {
            $("#managers_id").closest('.form-group').removeClass("has-error");
            $("#managers_id").closest('.form-group').addClass("has-success");
        }
        
        // DROPDOWN LIST =ASSIGNED EMPLOYEES=
         var ae = $("#assignedEmployees_error");
        if (ae.text() != "") {
            $("#assignedEmployees").closest('.form-group').addClass("has-error");
            $("#assignedEmployees").closest('.form-group').removeClass("has-success");
        } else {
            $("#assignedEmployees").closest('.form-group').removeClass("has-error");
            $("#assignedEmployees").closest('.form-group').addClass("has-success");
        }
    </script>
</c:if>
