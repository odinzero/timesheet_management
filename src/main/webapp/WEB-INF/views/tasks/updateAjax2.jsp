
<style type="text/css">
    span.error{
        color: red;
        margin-left: 5px;
    }

    /* Start by setting display:none to make this hidden.
Then we position it in relation to the viewport window
with position:fixed. Width, height, top and left speak
speak for themselves. Background we set to 80% white with
our animation centered, and no-repeating */
    .modal {
        display:    none;
        position:   fixed;
        z-index:    1000;
        top:        0;
        left:       0;
        height:     100%;
        width:      100%;
        background: rgba( 255, 255, 255, .8 ) 
            url('http://sampsonresume.com/labs/pIkfp.gif') 
            50% 50% 
            no-repeat;
    }

    /* When the body has the loading class, we turn
       the scrollbar off with overflow:hidden */
    body.loading {
        overflow: hidden;   
    }

    /* Anytime the body has the loading class, our
       modal element will be visible */
    body.loading .modal {
        display: block;
    }
</style>

<script type="text/javascript">

    //  alert("OK");

    // FUNCTION LOAD MANAGERS
    (function($) {
        $.fn.loadData = function(arr, idOrClass, choice) {
            var json = JSON.stringify(arr);

            // alert("json:" + data)
            // remove from begin string "["
            var str = json.substr(2);
            // remove from end string "]"
            str = str.slice(0, -3);

            var array = str.split("],");

            //alert("json22:" + data);

            var arr_id = [];
            var arr_name = [];
            for (var i = 0; i < array.length; i++) {

                // alert("json33:" + array[i]);
                if (choice == "managers")
                    var myRegexp = /id=(\d+),\s*name=(.+)/gm;
                if (choice == "employees")
                    var myRegexp = /id=(\d+),\s*name=(.+),/gm;

                var m = myRegexp.exec(array[i]);
                //alert(m[1] + " " + m[2]);
                arr_id[i] = m[1];
                arr_name[i] = m[2];

                //  alert(arr_id[i] + " " + arr_name[i]);
            }

            for (var i = 0; i < array.length; i++) {

                var option = "<option value=" + arr_id[i] + ">" + arr_name[i] + "</option>";
                // add option to unassigned employees
                $(idOrClass).append(option);
            }
            return this;
        };
    })(jQuery);


    // BUTTON 'Load Data' 
    $(document).on('click', '#but_update', function() {

        alert("but_update");

        $('.modal').show();

        $.post("http://localhost:8083/timesheet/task_ajax2/loaddata", {
            id: ${id}
        }, function(data) {

            //$('#loading').css('display', 'inline');

            // alert("but_update");
            //var json = JSON.parse(data); 
            //var json = JSON.stringify(data);
            var array = data.split("&&");

            // LOAD DESCRIPTION
            $("#description").val(array[0]);
            // LOAD MANAGERS
            $(this).loadData(array[1], "#managers", "managers");
            // set selected manager
            $("#managers").val(array[5]);
            // LOAD CHECKBOX "COMPLETED"
            if (array[2] == "false")
                $("#completed").prop('checked', false);
            if (array[2] == "true")
                $("#completed").prop('checked', true);
            // LOAD DROPDOWNLIST "ASSIGNED EMPLOYEES"
            $(this).loadData(array[3], "#assignedEmployees", "employees");
            // LOAD DROPDOWNLIST "UNASSIGNED EMPLOYEES"
            $(this).loadData(array[4], "#unassignedEmployees", "employees");

            $('.modal').hide('slow');
        })
                .done(function(msg) {
                    alert("done:" + msg);
                    // hide  'Loading ...'
                    // $('#loading').css('display', 'none');
                    $('.modal').hide('slow');
                    //  $("body").removeClass('modal');
                })
                .fail(function(xhr, textStatus, errorThrown) {
                    alert("fail:" + xhr + "  " + textStatus + "  " + errorThrown);
                });

        $('.modal').hide('slow');

        $(this).prop('disabled', true);

    });


    // BUTTON "UPDATE"
    $(function() {
        /*  Submit form using Ajax */
        $('button[type=submit]').click(function(e) {

            alert("submit");


            //Remove all errors
            $('.error').remove();

            // select all employees in assigned dropdown list
            $('#assignedEmployees').children('option').prop('selected', true);

            var data = {};

            data["id"] = $("#task_id").val();
            data["description"] = $("#description").val();
            // dropdown list managers"
            //get selected option value
            data["managers"] = $("#managers").find(":selected").val();
            if (data["managers"] == "undefined" || data["managers"] == "" || data["managers"] == null) {
                data["managers"] = "";
            } else {
                data["managers"] = $("#managers").find(":selected").val();
                //var task_managerText = $("#managers").find(":selected").text();
            }
            // checkbox "completed"
            data["completed"] = $("#completed").prop("checked") ? true : false;
            // dropdown list "assigned employees"
            var optionValues = [];
            $('#assignedEmployees option').map(function() {
                optionValues.push($(this).val());
                //data["assignedEmployees"][].push($(this).val());
                return $(this).val();
            }).get();

            if (optionValues.length == 0)
                optionValues.push("");

            data["assignedEmployees"] = optionValues;

            alert("data: " + data.toString());

            $.ajax({
                type: "POST",
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                //contentType: "application/json",
                url: "http://localhost:8083/timesheet/task_ajax2/updateTask2",
                data: JSON.stringify(data),
                dataType: 'json',
                timeout: 600000,
                success: function(data) {


                    alert("data ajax:" + data.id);

                    // console.log(data);

                    // if not VALIDATION ERRORS redirect to task ID view
                    if (data.result == "OK") {
                        var url = "/timesheet/tasks/" + ${id};
                        window.location.href = url;
                    }

                    // show VALIDATION errors
                    // DESCRIPTION ERROR
                    if (data.description == "") {
                        $('#errDesc').html("Description is empty");
                        //$('#description').after('<span class="help-block">' + "Description is empty" + '</span>');
                        // add bootstrap class "has-error" and remove class "has-success"
                        $("#description").closest('.form-group').addClass("has-error");
                        $("#description").closest('.form-group').removeClass("has-success");
                    } else {
                        $('#errDesc').html("");
                        // remove bootstrap class "has-error" and add class "has-success"
                        $("#description").closest('.form-group').removeClass("has-error");
                        $("#description").closest('.form-group').addClass("has-success");
                    }
                        
                    // MANAGERS ERROR
                    if (data.managers == "") {
                        $('#errManagers').html("Managers is not selected");
                        //$('#managers').after('<span class="help-block">' + "Manager is not selected" + '</span>');
                        // add bootstrap class "has-error" and remove class "has-success"
                        $("#managers").closest('.form-group').addClass("has-error");
                        $("#managers").closest('.form-group').removeClass("has-success");
                    } else {
                        $('#errManagers').html("");
                        // remove bootstrap class "has-error" and add class "has-success"
                        $("#managers").closest('.form-group').removeClass("has-error");
                        $("#managers").closest('.form-group').addClass("has-success");
                    }
                    
                    // ASSIGNED EMPLOYEES ERROR   
                    if (data.assignedEmployees[0] == "") {
                        $('#errAssigneedEmployees').html("Assigneed Employees is empty");
                        //$('table').after('<span class="help-block">' + "Assigneed Employees is empty" + '</span>');
                        // add bootstrap class "has-error" and remove class "has-success"
                        $("#assignedEmployees").closest('.form-group').addClass("has-error");
                        $("#assignedEmployees").closest('.form-group').removeClass("has-success");
                    } else {
                        $('#errAssigneedEmployees').html("");
                        // remove bootstrap class "has-error" and add class "has-success"
                        $("#assignedEmployees").closest('.form-group').removeClass("has-error");
                        $("#assignedEmployees").closest('.form-group').addClass("has-success");
                    }

                    //Set response
                    $('#resultContainer pre code').text(JSON.stringify(data));
                    $('#resultContainer').show();

                },
                // XMLHttpRequest, textStatus, errorThrown    
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    alert("Error ajax:" + XMLHttpRequest + " " + textStatus + " " + errorThrown);
                    // console.log(data);
                }
            });


        });
    });

    var val = null; // option value
    var text = null; // option text
    var option = null; // html element option    

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

<h2>Update Task ${id} </h2>
<hr/>
<!-- LOAD DATA INTO FORM -->
<button type = "reset"  id="but_update" class="btn btn-primary" >Load Data</button>
<span id="loading" style="display: none;">Loading ...</span>
<br><br>

<!-- commandName = "taskCreate"   /timesheet/tasks -->

<div  class="errorblock"  style="display: none;"></div>

<!-- TASK ID -->
<input type="hidden" id="task_id" name="id" value="${id}">

<!-- TEXT FIELD =DESCRIPTION= -->
<div class="form-group required">
    <label class="control-label" style="width: 100px;">Description</label>
    <input name="description" id="description" class="form-control" style="display: inline; width: 300px;" value="" />
    <span  class="help-block" id="errDesc" ></span>
</div>

<!-- DROPDOWN LIST =MANAGERS= -->
<div class="form-group required">
    <label class="control-label" style="width: 100px;">Manager</label>
    <select  name="managers" id="managers"  class="form-control" style="display: inline; width: 300px;">
        <option value="">-Please Select-</option> 
    </select>
    <span  class = "help-block" id="errManagers" ></span>
</div>

<!-- TEXT FIELD =COMPLETED= -->
<div class="form-group">
    <label class="control-label" style="width: 100px;">Completed</label>
    <input type="checkbox" name="completed"  id="completed"  checked=""/>
</div>

<!-- DROPDOWN LIST =ASSIGNED EMPLOYEES= --> 
<div class="form-group required">
    <table class="table-condensed">
        <tr>
            <td><label class="control-label">Employees</label></td>
            <td><select  id="assignedEmployees" class="form-control" name="assignedEmployees"  multiple="true" colspan = "0"  style="width: 150px;">
                </select> 
            </td>    
            <td>
                <!-- button >> REMOVE assigned employee -->
                <button type="reset" id="removeAssignedEmployee" class="btn btn-info"  >>></button>
                <!-- button << ADD assigned employee -->
                <button type="reset" id="removeUnassignedEmployee" class="btn btn-info" ><<</button> 
            </td>
            <!-- DROPDOWN LIST =UNASSIGNED EMPLOYEES= --> 
            <td> <select  id="unassignedEmployees" class="form-control"  multiple="true"  colspan = "2"  style="width: 150px;">
                </select>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <label id = "lab_assignedEmployees" class="control-label">Assigned</label>
            </td>
            <td></td>
            <td>
                <label  id="lab_unassignedEmployees" class="control-label">Unassigned</label>
            </td>
        </tr>
        
        <tr>
            <td colspan="7"><span  class = "help-block" id="errAssigneedEmployees" ></span></td>
        </tr>
    </table>
</div>

<div class="form-group">
    <button type="submit" class="btn btn-primary">Update</button>
</div>

</table>

<!-- Result Container  -->
<div id="resultContainer" style="display: none;">
    <hr/>
    <h4 style="color: green;">JSON Response From Server</h4>
    <pre style="color: green;">
    <code></code>
    </pre>
</div>


<div class="modal"></div>