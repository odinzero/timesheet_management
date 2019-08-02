
<h1>
    ${employee.name}  
</h1>

<p>
    <a class="btn btn-primary" href="/timesheet/employees/${employee.id}?update">Update</a>
    <a class="btn btn-danger" href="/timesheet/employees/delete/${employee.id}" 
       data-confirm="Are you sure you want to delete this item?" data-method="post">Delete</a>
</p>
<!--provide an html table start tag -->
<table class="table table-bordered table-striped">
    <tbody>
        <!-- create an html table row -->
        <tr>
            <!-- create cells of row -->
            <th>ID</th>
            <td>${employee.id}</td>
            <!-- close row -->
        </tr> 
        <tr>
            <th>Department</th>
            <td>${employee.department}</td>
        </tr> 
        <tr>
            <th>Name</th>
            <td>${employee.name}</td>
        </tr>       
    <tbody>
        <!-- close table -->
</table>

