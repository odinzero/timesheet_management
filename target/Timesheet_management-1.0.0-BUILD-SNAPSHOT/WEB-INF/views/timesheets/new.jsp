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

<!-- commandName = "employeeCreate" -->
<form:form method = "POST" action = "/timesheet/timesheets" commandName = "timesheetCreate" >
    <form:errors path = "*" cssClass = "errorblock" element = "div" />

    <!-- FIELD "HOURS" -->
    <div class="form-group required">
        <form:label path = "hours" cssClass="control-label">Hours</form:label>
        <form:input path = "hours" id="hours" cssClass="form-control"/>
        <form:errors path = "hours" cssClass = "help-block" />
    </div>

    <!-- DROPDOWN LIST "TASKS" -->
    <div class="form-group">
        <form:label path = "tasks" cssClass="control-label">Tasks</form:label>
        <form:select  path="tasks" id="tasks"  multiple="false" cssClass="form-control">
            <form:option value="">-Please Select-</form:option>
            <c:forEach var="task" items="${tasks}">

                <form:option value="${task.id}">${task.description}</form:option>

                </c:forEach> 
        </form:select>
        <form:errors path = "tasks" cssClass = "help-block" />
    </div>

    <!-- DROPDOWN LIST "EMPLOYEES" -->
    <div class="form-group required">
        <form:label path = "who" cssClass="control-label">Employees</form:label>
        <form:select  path="who" id="who"  multiple="false" cssClass="form-control">
            <form:option value="">-Please Select-</form:option>
            <c:forEach var="emp" items="${who}">

                <form:option value="${emp.id}">${emp.name}</form:option>

                </c:forEach> 
        </form:select>
        <form:errors path = "who" cssClass = "help-block" />
    </div>

    <div class="form-group">
        <input type = "submit" class="btn btn-primary" value = "Create"/>
    </div>

</form:form>

<script>

    $(document).on('change', '#tasks', function() {
        // get TASK value
        var task_id = $("#tasks").val();

        alert("change: " + task_id);

        // remove all options from DROPDOWN LIST "EMPLOYEES"
        $('#who').children('option').remove();
        // ADD option -Please Select-
        var option = "<option value=\"\">-Please Select-</option>";
        // add option to assigned employees
        $('#who').append(option);

        $.post("http://localhost:8083/timesheet/timesheets/assignedEmployees", {
            id: task_id
        }, function(data) {

            //var json = JSON.parse(data); 
            var json = JSON.stringify(data);
            // remove from begin string "["
            var str = json.substr(2);
            // remove from end string "]"
            str = str.slice(0, -2);

            var array = str.split("],");

            var arr_id = [];
            var arr_name = [];
            for (var i = 0; i < array.length; i++) {

                var myRegexp = /id=(\d+),\s*name=(.+),/gm;
                var m = myRegexp.exec(array[i]);
                //alert(m[1] + " " + m[2]);
                arr_id[i] = m[1];
                arr_name[i] = m[2];

                // alert(arr_id[i] + " " + arr_name[i]);
            }

            for (var i = 0; i < array.length; i++) {

                var option = "<option value=" + arr_id[i] + ">" + arr_name[i] + "</option>";
                // add option to assigned employees
                $('#who').append(option);
            }
            // alert("json:" + array);
        })
                .done(function(msg) {
                    alert("done:" + msg);
                })
                .fail(function(xhr, textStatus, errorThrown) {
                    alert("fail:" + xhr + "  " + textStatus + "  " + errorThrown);
                })
                .complete(function() {
                    alert("complete");
                });
    });
</script>

<!-- when button "Create" already is pressed add and remove bootstrap classes for check validation errors -->
<c:if test='${try_create == "created" }'>
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
        
        var t = $("#tasks");
        if (t.val().length <= 0) {
            t.closest('.form-group').addClass("has-error");
            t.closest('.form-group').removeClass("has-success");
            // $("#comprarButtonId").prop('disabled', true);
        } else {
            t.closest('.form-group').removeClass("has-error");
            t.closest('.form-group').addClass("has-success");
        }
        
        var w = $("#who");
        if (w.val().length <= 0) {
            w.closest('.form-group').addClass("has-error");
            w.closest('.form-group').removeClass("has-success");
            // $("#comprarButtonId").prop('disabled', true);
        } else {
            w.closest('.form-group').removeClass("has-error");
            w.closest('.form-group').addClass("has-success");
        }
    </script>
</c:if>
