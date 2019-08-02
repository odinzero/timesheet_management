
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

<h2> Update Task ${task.id} </h2>
<!-- commandName = "taskCreate"   /timesheet/tasks -->

<div  class="errorblock"  style="display: none;"></div>

<!-- FIELD =DESCRIPTION= -->
<div class="form-group required">
    <label path =  "description" class="control-label" style="width: 100px;">Description</label>
    <input type="text" id="description" class="form-control" value="" style="display: inline; width: 300px;"  />
    <button type="submit" id="but_description" class="btn btn-primary">Load Description</button>
    <span  id="errDesc" class="help-block" ></span>
</div>

<!-- DROPDOWN LIST =MANAGERS= -->
<div class="form-group required">
    <label path = "managers" class="control-label" style="width: 100px;" >Manager</label>
    <select  path="managers" id="managers" class="form-control" style="display: inline; width: 300px;">
        <option value="">-Please Select-</option> 
    </select>
    <button type="submit" id="but_managers" class="btn btn-primary">Load Managers</button>
    <span  id="errManagers" class="help-block" ></span>
</div>

<!-- CHECKBOX =COMPLETED= -->
<div class="form-group">
    <label path = "completed" class="control-label" style="width: 80px;">Completed</label>
    <input type="checkbox"  id="completed"  checked=""/>
    <button type="submit" id="but_completed" class="btn btn-primary">Load Completed</button>
</div>

<!-- DROPDOWN LIST =ASSIGNED EMPLOYEES= --> 
<div class="form-group required">
    <table class="table-condensed">
        <td><label path = "assignedEmployees" class="control-label" >Employees</label></td>
        <td><select  id="assignedEmployees" class="form-control"  multiple="true" colspan = "0"  style="width: 150px;">
            </select>        
        <td>
            <!-- button >> REMOVE assigned employee -->
            <button type="reset" id="removeAssignedEmployee" class="btn btn-info" >>></button>
            <!-- button << ADD assigned employee -->
            <button type="reset" id="removeUnassignedEmployee" class="btn btn-info" ><<</button> 
        </td>
        </td>
        <!-- DROPDOWN LIST =UNASSIGNED EMPLOYEES= --> 
        <td> <select  id="unassignedEmployees" class="form-control"  multiple="true"  colspan = "2"  style="width: 150px;">
            </select>
        </td>
        <tr>
            <td></td>
            <td>
                <label id = "lab_assignedEmployees" class="control-label" style="display: none;">Assigned</label>
                <button type="submit" id="but_assignedEmployees" class="btn btn-primary">Load Assigned</button>
            </td>
            <td></td>
            <td>
                <label  id="lab_unassignedEmployees" class="control-label" style="display: none;">Unassigned</label>
                <button type="submit" id="but_unassignedEmployees" class="btn btn-primary">Load Unassigned</button>
            </td>
        </tr>
        <tr>
            <td colspan="7"><span  class = "help-block" id="errAssigneedEmployees" ></span></td>
        </tr>
    </table>
</div>

<div class="form-group">
    <button type = "reset"  id="but_update" class="btn btn-primary" >Update</button>
</div>

<%-- To display selected value from dropdown list. --%>
<script>
    // remove all selected values
    $("#assignedEmployees").val([]);
    // remove all selected values
    $("#unassignedEmployees").val([]);

    // BUTTON 'Update' 
    $(document).on('click', '#but_update', function() {

        alert("but_update");

        //$("#assignedEmployees").val([]);
        // select all employees in assigned dropdown list
        //$('#assignedEmployees').children('option').prop('selected', true);

        var task_description = $("#description").val();
        // dropdown list managers"
        //get selected option value
        var task_managerVal = $("#managers").find(":selected").val();
        if (task_managerVal == "undefined" || task_managerVal == "" || task_managerVal == null) {
            task_managerVal = "";
        } else {
            task_managerVal = $("#managers").find(":selected").val();
            var task_managerText = $("#managers").find(":selected").text();
        }

        var task_completed = $("#completed").prop("checked") ? true : false;
        // dropdown list "assigned employees"
        var optionValues = [];
        $('#assignedEmployees option').map(function() {
            optionValues.push($(this).val());
            return $(this).val();
        }).get();

        if (optionValues.length == 0)
            optionValues.push("");

        alert("start id:" + ${task.id} + " | " +
                "description:" + task_description + " | " +
                "managerVal:" + task_managerVal + " | " +
                "managerText:" + task_managerText + " | " +
                "completed:" + task_completed + " | " +
                "assignedEmployees:" + optionValues + " | ");

        $.post("http://localhost:8083/timesheet/task_ajax/updateTask", {
            id: ${task.id},
            description: task_description,
            manager_id: task_managerVal,
            managerText: task_managerText,
            completed: task_completed,
            assignedEmployees: optionValues
                    // assignedEmployees: JSON.stringify(optionValues) 
        }, function(data) {

            // alert("json:" + data);
        })
                .done(function(data) {
                    alert("done:" + data);

                    var validation = data.split("|");
                    //field description
                    if (validation[0] == "false") {
                        $('#errDesc').html("Description is empty");
                        // add bootstrap class "has-error" and remove class "has-success"
                        $("#description").closest('.form-group').addClass("has-error");
                        $("#description").closest('.form-group').removeClass("has-success");
                    } else {
                        $('#errDesc').html("");
                        // remove bootstrap class "has-error" and add class "has-success"
                        $("#description").closest('.form-group').removeClass("has-error");
                        $("#description").closest('.form-group').addClass("has-success");
                    }
                    // dropdown list "Managers"
                    if (validation[1] == "false") {
                        $('#errManagers').html("Managers is not selected");
                        // add bootstrap class "has-error" and remove class "has-success"
                        $("#managers").closest('.form-group').addClass("has-error");
                        $("#managers").closest('.form-group').removeClass("has-success");
                    } else {
                        $('#errManagers').html("");
                        // remove bootstrap class "has-error" and add class "has-success"
                        $("#managers").closest('.form-group').removeClass("has-error");
                        $("#managers").closest('.form-group').addClass("has-success");
                    }
                    // dropdown list assigned Employees
                    if (validation[2] == "false") {
                        $('#errAssigneedEmployees').html("Assigneed Employees is empty");
                        // add bootstrap class "has-error" and remove class "has-success"
                        $("#assignedEmployees").closest('.form-group').addClass("has-error");
                        $("#assignedEmployees").closest('.form-group').removeClass("has-success");
                    } else {
                        $('#errAssigneedEmployees').html("");
                        // remove bootstrap class "has-error" and add class "has-success"
                        $("#assignedEmployees").closest('.form-group').removeClass("has-error");
                        $("#assignedEmployees").closest('.form-group').addClass("has-success");
                    }

                    if (validation[0] == "true" && validation[1] == "true" && validation[2] == "true") {
                        // redirect to specified task view
                        var url = "/timesheet/tasks/" + ${task.id};
                        window.location.href = url;
                    }

                })
                .fail(function(xhr, textStatus, errorThrown) {
                    alert("fail:" + xhr + "  " + textStatus + "  " + errorThrown);
                });

    });

    // BUTTON "Load Description"
    $(document).on('click', '#but_description', function() {

        // alert("but_description");

        $.post("http://localhost:8083/timesheet/task_ajax/description", {
            id: ${task.id}
        }, function(data) {

            //var json = JSON.parse(data); 
            var json = JSON.stringify(data);

            $("#description").val(data);

        })
                .done(function(msg) {
                    // alert("done:" + msg);
                    // hide BUTTON 'Load description'
                    $('#but_description').css('display', 'none');
                })
                .fail(function(xhr, textStatus, errorThrown) {
                    alert("fail:" + xhr + "  " + textStatus + "  " + errorThrown);
                })
                .complete(function() {
                    alert("complete");

                });

    });

    // BUTTON  "Load managers"
    $(document).on('click', '#but_managers', function() {

        // alert("but_managers");

        // $(this).hide();
        // $("#lab_unassignedEmployees").show();

        $.post("http://localhost:8083/timesheet/task_ajax/managers", {
            id: ${task.id}
        }, function(data) {

            //var json = JSON.parse(data); 
            var json = JSON.stringify(data);

             alert(" managers json:" + data);
            
            var arrManagers = data.split(":");
            // default selected manager for updating
            var selectedManager = arrManagers[1];
            
             alert(" selectedManager:" + selectedManager);
            
            // remove from begin string "["
            var str = arrManagers[0].substr(2);
            // remove from end string "]"
            str = str.slice(0, -2);

            var array = str.split("],");

            //alert("json22:" + data);

            var arr_id = [];
            var arr_name = [];
            for (var i = 0; i < array.length; i++) {

                // alert("json33:" + array[i]);

                var myRegexp = /id=(\d+),\s*name=(.+)/gm;
                var m = myRegexp.exec(array[i]);
                //alert(m[1] + " " + m[2]);
                arr_id[i] = m[1];
                arr_name[i] = m[2];

                //  alert(arr_id[i] + " " + arr_name[i]);
            }

            for (var i = 0; i < array.length; i++) {

                var option = "<option value=" + arr_id[i] + ">" + arr_name[i] + "</option>";
                // add option to unassigned employees
                $('#managers').append(option);
            }
            // set selected manager
            $("#managers").val(selectedManager);

            // alert("json1:" + array);
        })
                .done(function(msg) {
                    alert("done:" + msg);
                    // hide BUTTON 'Load managers'
                    $('#but_managers').css('display', 'none');
                })
                .fail(function(xhr, textStatus, errorThrown) {
                    alert("fail:" + xhr + "  " + textStatus + "  " + errorThrown);
                })
                .complete(function() {
                    alert("complete");

                });
    });


    // CHECKBOX "COMPLETED"
    $(document).on('click', '#but_completed', function() {

        //  alert("but_completed");

        $.post("http://localhost:8083/timesheet/task_ajax/completed", {
            id: ${task.id}
        }, function(data) {

            //var json = JSON.parse(data); 
            // var json = JSON.stringify(data);
            // alert(data);

            if (data == "false")
                $("#completed").prop('checked', false);
            if (data == "true")
                $("#completed").prop('checked', true);
        })
                .done(function(msg) {
                    // alert("done:" + msg);
                    // hide BUTTON 'Load completed'
                    $('#but_completed').css('display', 'none');
                })
                .fail(function(xhr, textStatus, errorThrown) {
                    alert("fail:" + xhr.toString() + "  " + textStatus + "  " + errorThrown);
                })
                .complete(function() {
                    alert("complete");

                });
    });


    // BUTTON "LOAD ASSIGNED"
    $(document).on('click', '#but_assignedEmployees', function() {

        alert("but_assignedEmployees");

        // $(this).hide();
        // $("#lab_unassignedEmployees").show();

        $.post("http://localhost:8083/timesheet/task_ajax/assignedEmployees", {
            id: ${task.id}
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
                $('#assignedEmployees').append(option);
            }
            // alert("json:" + array);
        })
                .done(function(msg) {
                    alert("done:" + msg);
                    // hide BUTTON 'Load assigned'
                    $("#but_assignedEmployees").hide();
                    $("#lab_assignedEmployees").show();
                })
                .fail(function(xhr, textStatus, errorThrown) {
                    alert("fail:" + xhr + "  " + textStatus + "  " + errorThrown);
                })
                .complete(function() {
                    alert("complete");
                });
    });

    // BUTTON "LOAD UNASSIGNED"
    $(document).on('click', '#but_unassignedEmployees', function() {

        alert("but_unassignedEmployees");

        // $(this).hide();
        // $("#lab_unassignedEmployees").show();

        $.post("http://localhost:8083/timesheet/task_ajax/unassignedEmployees", {
            id: ${task.id}
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
                // add option to unassigned employees
                $('#unassignedEmployees').append(option);
            }

            // alert("json:" + array);
        })
                .done(function(msg) {
                    alert("done:" + msg);
                    // hide BUTTON 'Load assigned'
                    $("#but_unassignedEmployees").hide();
                    $("#lab_unassignedEmployees").show();
                })
                .fail(function(xhr, textStatus, errorThrown) {
                    alert("fail:" + xhr + "  " + textStatus + "  " + errorThrown);
                })
                .complete(function() {
                    alert("complete");
                });
    });

    var val = null; // option value
    var text = null; // option text
    var option = null; // html element option

    //alert(val + "  " + text);

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

