
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
    // FUNCTION check FIELDS and DROPDOWNS for VALIDATION ERRORS
    (function($) {
        $.fn.removeErrors = function(idOrClass_err, idOrClass) {
            $(idOrClass_err).html("");
            // remove bootstrap class "has-error" and add class "has-success"
            $(idOrClass).closest('.form-group').removeClass("has-error");
            $(idOrClass).closest('.form-group').addClass("has-success");
            
           return this;
        };
    })(jQuery);
    
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

        $('.modal').show();

        $.post("http://localhost:8083/timesheet/task_ajaxform/loaddata", {
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
        // remove  VALIDATION ERRORS if exists 
        $(this).removeErrors("#errDesc","#description");
        $(this).removeErrors("#errManagers","#managers");
        $(this).removeErrors("#errAssigneedEmployees","#assignedEmployees");
    });


    // BUTTON "UPDATE"
    $(function() {
        /*  Submit form using Ajax */
        $('button[type=submit]').click(function(e) {

            alert("submit");

            //Prevent default submission of form
            e.preventDefault();

            //Remove all errors
            $('.error').remove();

            // select all employees in assigned dropdown list
            $('#assignedEmployees').children('option').prop('selected', true);
            // set default state (has-success) for field "DESCRIPTION"
            $('#errDesc').html("");
            // remove bootstrap class "has-error" and add class "has-success"
            $("#description").closest('.form-group').removeClass("has-error");
            $("#description").closest('.form-group').addClass("has-success");

            // set default state (has-success) for dropdown list "MANAGERS"
            $('#errManagers').html("");
            // remove bootstrap class "has-error" and add class "has-success"
            $("#managers").closest('.form-group').removeClass("has-error");
            $("#managers").closest('.form-group').addClass("has-success");

            // set default state (has-success) for checkbox "COMPLETED"
            $('#errAssigneedEmployees').html("");
            // remove bootstrap class "has-error" and add class "has-success"
            $("#assignedEmployees").closest('.form-group').removeClass("has-error");
            $("#assignedEmployees").closest('.form-group').addClass("has-success");


            $.post({
                url: "http://localhost:8083/timesheet/task_ajaxform/updateTask2",
                data: $('form[name=taskAjaxForm]').serialize(),
                success: function(res) {

                    alert(res);

                    // if not VALIDATION ERRORS redirect to task ID view
                    if (res == "OK") {
                        var url = "/timesheet/tasks/" + ${id};
                        window.location.href = url;
                    }

                    // remove from start string "{"
                    var str = res.substr(1);
                    // remove from end string "}"
                    str = str.slice(0, -1);

                    var array = str.split(",");

                    // alert("json22:" + array);

                    var arr_id = [];
                    var arr_name = [];
                    for (var i = 0; i < array.length; i++) {

                        // alert("json33:" + array[i]);

                        var myRegexp = /(.+)=(.+\s+.+)/gm;
                        var m = myRegexp.exec(array[i]);
                        // alert(m[1] + " " + m[2]);
                        arr_id[i] = m[1];
                        arr_name[i] = m[2];

                        alert("::" + arr_id[i] + " " + arr_name[i]);
                    }
                    // show errors
                    for (var i = 0; i < array.length; i++) {

                        // DESCRIPTION ERROR
                        if (arr_id[i].trim() == "description") {

                            //$('input[name=' + arr_id[i] + ']').after('<span class="error">' + arr_name[i] + '</span>');
                            $('#errDesc').html(arr_name[i]);
                            // add bootstrap class "has-error" and remove class "has-success"
                            $("#description").closest('.form-group').addClass("has-error");
                            $("#description").closest('.form-group').removeClass("has-success");
                        }

                        // MANAGERS ERROR
                        if (arr_id[i].trim() == "managers") {
                            //$('#managers').after('<span class="error">' + arr_name[i] + '</span>');
                            $('#errManagers').html(arr_name[i]);
                            // add bootstrap class "has-error" and remove class "has-success"
                            $("#managers").closest('.form-group').addClass("has-error");
                            $("#managers").closest('.form-group').removeClass("has-success");
                        }
                        // ASSIGNED EMPLOYEES ERROR
                        if (arr_id[i].trim() == "assignedEmployees") {
                            //$('#assignedEmployees').after('<span class="error">' + arr_name[i] + '</span>');
                            $('#errAssigneedEmployees').html(arr_name[i]);
                            // add bootstrap class "has-error" and remove class "has-success"
                            $("#assignedEmployees").closest('.form-group').addClass("has-error");
                            $("#assignedEmployees").closest('.form-group').removeClass("has-success");
                        }
                    }

                    //Set response
                    $('#resultContainer pre code').text(JSON.stringify(res));
                    $('#resultContainer').show();

                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    alert(XMLHttpRequest + " " + textStatus + " " + errorThrown);
                }
            })
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
        
        $("#description").val("hhh");
       // $("#managers").val($("#managers").val());
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
        
        // save 
        $("#description").val($("#description").val());
        $("#managers").val($("#managers").val());
    });
</script>

<h2>Update Task ${id}</h2>
<hr/>
<!-- LOAD DATA INTO FORM -->
<button type = "reset"  id="but_update" class="btn btn-primary" >Load Data</button>
<span id="loading" style="display: none;">Loading ...</span>
<br><br>

<form action="#" method="post" name="taskAjaxForm">
    <!-- commandName = "taskCreate"   /timesheet/tasks -->

    <div  class="errorblock"  style="display: none;"></div>

    <!-- TASK ID -->
    <input type="hidden" id="task_id" name="id" value="${id}">

    <!-- TEXT FIELD =DESCRIPTION= -->
    <div class="form-group required">
        <label class="control-label" style="width: 100px;">Description</label>
        <input name="description" id="description" class="form-control" style="display: inline; width: 300px;" value=""  />
        <span  class = "help-block" id="errDesc" ></span>
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
            <td><label class="control-label">Employees</label></td>
            <td><select  id="assignedEmployees" class="form-control" name="assignedEmployees"  multiple="true" colspan = "0"  style="width: 150px;">
                </select>        
            <td>
                <!-- button >> REMOVE assigned employee -->
                <button type="reset" id="removeAssignedEmployee" class="btn btn-info"  >>></button>
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

</form>

<!-- Result Container  -->
<div id="resultContainer" style="display: none;">
    <hr/>
    <h4 style="color: green;">JSON Response From Server</h4>
    <pre style="color: green;">
    <code></code>
    </pre>
</div>


<div class="modal"></div>