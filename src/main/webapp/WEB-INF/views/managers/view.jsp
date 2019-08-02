
<h1>
    ${manager.name}  
</h1>

<p>
    <a class="btn btn-primary" href="/timesheet/managers/${manager.id}?update">Update</a>
    <a class="btn btn-danger" href="/timesheet/managers/delete/${manager.id}" 
       data-confirm="Are you sure you want to delete this item?" data-method="post">Delete</a>
</p>
<!--provide an html table start tag -->
<table class="table table-bordered table-striped">
    <tbody>
        <!-- create an html table row -->
        <tr>
            <!-- create cells of row -->
            <th>ID</th>
            <td>${manager.id}</td>
            <!-- close row -->
        </tr>
        <tr>
            <!-- create cells of row -->
            <th>Name</th>
            <td>${manager.name}</td>
            <!-- close row -->
        </tr>
        <!-- close table -->
    </tbody>
</table>

