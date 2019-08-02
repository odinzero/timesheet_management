
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>updateAjax2</title>

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

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script type="text/javascript">

              alert(${id});

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

                $.post("http://localhost:8083/timesheet/task_ajax_servlet", {
                    id: ${id},
                    loaddata: "1"
                }, function(data) {

                    //$('#loading').css('display', 'inline');

                     alert(data);
                    //var json = JSON.parse(data); 
                    //var json = JSON.stringify(data);
                    var array = data.split("&&");

                    // LOAD DESCRIPTION
                    $("#description").val(array[0]);
                    // LOAD MANAGERS
                    $(this).loadData(array[1], "#managers", "managers");
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

        </script>
    </head>
    <body>
        <h2>Task ${id} Information</h2>
        <hr/>
        <!-- LOAD DATA INTO FORM -->
        <button type = "reset"  id="but_update" >Load Data</button>
        <span id="loading" style="display: none;">Loading ...</span>
        <br><br>

        <!-- commandName = "taskCreate"   /timesheet/tasks -->

        <div  class="errorblock"  style="display: none;"></div>
        <table>
            <!-- TASK ID -->
            <input type="hidden" id="task_id" name="id" value="${id}">
            <tr>
                <td><label>Description</label></td>
                <td>
                    <input name="description" id="description" value="" />
                </td>
                <td><span  class = "error" id="errDesc" ></span></td>
            </tr>
            <tr>
                <!-- DROPDOWN LIST =MANAGERS= -->
                <td><label>Manager</label></td>
                <td>
                    <select  name="managers" id="managers"  multiple="false" style="width: 150px;height: 20px;">
                        <option value="">-Please Select-</option> 
                    </select>
                </td>
                <td><span  class = "error" id="errManagers" ></span></td>
            </tr>
            <tr>
                <td><label path = "completed">Completed</label></td>
                <td>
                    <input type="checkbox" name="completed"  id="completed"  checked=""/>
                </td>
            </tr>
            <!-- DROPDOWN LIST =ASSIGNED EMPLOYEES= --> 
            <tr>
            <table>
                <td><label>Employees</label></td>
                <td><select  id="assignedEmployees" name="assignedEmployees"  multiple="true" colspan = "0"  style="width: 150px;">
                    </select>        
                <td>
                    <!-- button >> REMOVE assigned employee -->
                    <button type="reset" id="removeAssignedEmployee"  >>></button>
                    <!-- button << ADD assigned employee -->
                    <button type="reset" id="removeUnassignedEmployee" ><<</button> 
                </td>
                </td>
                <!-- DROPDOWN LIST =UNASSIGNED EMPLOYEES= --> 
                <td> <select  id="unassignedEmployees"  multiple="true"  colspan = "2"  style="width: 150px;">
                    </select>
                </td>
                <td><span  class = "error" id="errAssigneedEmployees" ></span></td>
                <tr>
                    <td></td>
                    <td>
                        <label id = "lab_assignedEmployees">Assigned</label>
                    </td>
                    <td></td>
                    <td>
                        <label  id="lab_unassignedEmployees">Unassigned</label>
                    </td>
                    <td><errors path = "assignedEmployees" cssClass = "error" /></td>
                </tr>
            </table>
        </tr>
        <tr>
            <td colspan = "2">
            <td><button type="submit">Update</button></td>
            </td>
        </tr>


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
</body>
</html>