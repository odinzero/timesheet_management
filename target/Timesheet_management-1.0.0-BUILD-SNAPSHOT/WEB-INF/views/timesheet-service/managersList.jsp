
<h2>
    Manager's List  
</h2>

<p>
    <input type = "submit" class="btn btn-primary" id="managers_list" value = " >>> show ... "/>
</p>
<!--provide an html table start tag -->
<table class="table table-bordered  table-condensed" id="table_managers_list" style="display: none;">
    <thead>
        <tr class="alert-success">
            <th>ID</th>
            <th>Name</th>
        </tr>
    </thead>
    <!-- iterate over the collection using forEach loop -->
    <tbody>
    <c:forEach var="manager" items="${managers}">
        <!-- create an html table row -->
        <tr>
            <!-- create cells of row -->
            <td>${manager.id}</td>
            <td><a href="http://localhost:8083/timesheet/timesheet-service/manager-tasks/${manager.id}" >${manager.name}</a></td>
            <!-- close row -->
        </tr>
        <!-- close the loop -->
    </c:forEach>
</tbody>
<!-- close table -->
</table>
            
<script>
     
     $("#managers_list").click(function(){
         
         if($("#table_managers_list").is(":visible")) {
           $("#table_managers_list").hide();
           $(this).val(" >>> show ...");
         } else {
           $("#table_managers_list").show();
           $(this).val(" <<< hide ...");
         }
     });

</script>             