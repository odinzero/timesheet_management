
<h2>
    Employees's List  
</h2>

<p>
    <input type = "submit" class="btn btn-primary" id="employees_list" value = " >>> show ... "/>
</p>
<!--provide an html table start tag -->
<table class="table table-bordered  table-condensed" id="table_employees_list" style="display: none;">
    <thead>
        <tr class="alert-success">
            <th>ID</th>
            <th>Department</th>
            <th>Name</th>
        </tr>
    </thead>
    <!-- iterate over the collection using forEach loop -->
    <tbody>
    <c:forEach var="employee" items="${employees}">
        <!-- create an html table row -->
        <tr>
            <!-- create cells of row -->
            <td>${employee.id}</td>
            <td>${employee.department}</td>
            <td><a href="http://localhost:8083/timesheet/timesheet-service/employee-tasks/${employee.id}" >${employee.name}</a></td>
            <!-- close row -->
        </tr>
        <!-- close the loop -->
    </c:forEach>
</tbody>
<!-- close table -->
</table>
            
<script>
     
     $("#employees_list").click(function(){
         
         if($("#table_employees_list").is(":visible")) {
           $("#table_employees_list").hide();
           $(this).val(" >>> show ...");
         } else {
           $("#table_employees_list").show();
           $(this).val(" <<< hide ...");
         }
     });

</script>             