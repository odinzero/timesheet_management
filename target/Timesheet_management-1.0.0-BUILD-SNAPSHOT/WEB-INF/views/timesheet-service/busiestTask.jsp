<h1>
    Busiest Task  
</h1>    
<span><!--{busiestTask} --></span>

<p>
    <input type = "submit" class="btn btn-primary" id="busiestTask" value = " >>> show ... "/>
</p>

<table class="table table-bordered table-condensed" id="table_busiestTask" style="display: none;">
    <thead>
        <tr class="alert-success">
            <th>ID</th>
            <th>Completed</th>
            <th>Description</th>
            <th id="empolyees">Employee</th>
            <th id="managers">Manager</th> 
        </tr>
    </thead>
    <!-- create an html table row -->
    <tbody>
        <tr>
            <!-- create cells of row -->
            <td>${busiestTask.id}</td>
            <td>${busiestTask.completed}</td>
            <td>${busiestTask.description}</td>
            <!-- employee ASSIGNED -->
            <td> 
                <table class="table" id="tableInside">
                    <c:forEach var="assigned" items="${busiestTask.assignedEmployees}">
                        <tr>
                            <td>
                                <a href="http://localhost:8083/timesheet/employees/${assigned.id}">${assigned.name}</a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </td>
            <!-- manager ASSIGNED -->
            <td> 
                <a href="http://localhost:8083/timesheet/managers/${busiestTask.manager.id}">${busiestTask.manager.name}</a>       
            </td>
            <!-- close row -->
        </tr>
    </tbody>
    <!-- close table -->
</table>

<script>
     
     $("#busiestTask").click(function(){
         
         if($("#table_busiestTask").is(":visible")) {
           $("#table_busiestTask").hide();
           $(this).val(" >>> show ...");
         } else {
           $("#table_busiestTask").show();
           $(this).val(" <<< hide ...");
         }
     });

</script>            