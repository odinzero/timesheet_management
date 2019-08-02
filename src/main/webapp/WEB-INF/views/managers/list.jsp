
<h1>
    Managers's List  
</h1>

<!-- BUTTON "Create Employee" -->
<p><a class="btn btn-success" href="/timesheet/managers?new">Create Manager</a></p>
<!--provide an html table start tag -->
<table class="table table-striped table-bordered">
    <thead>
        <tr>
            <th><a href="/MYBLOG/web/post/search?sort=description" data-sort="description">ID</a></th>     
            <th><a href="/MYBLOG/web/post/search?sort=description" data-sort="description">Name</a></th>   
            <th>View</th>
            <th>Update</th>
            <th>Delete</th>
        </tr>
        <tr id="w0-filters" class="filters">
                <td><input type="text" class="form-control" name="PostSearch[id]" value=""></td>
                <td><input type="text" class="form-control" name="PostSearch[name]" value=""></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
        </tr>
    </thead>
    <tbody>
        <!-- iterate over the collection using forEach loop -->
    <c:forEach var="manager" items="${managers}">
        <!-- create an html table row -->
        <tr>
            <!-- create cells of row -->
            <td>${manager.id}</td>
            <td>${manager.name}</td>
            <td>
                <a href="http://localhost:8083/timesheet/managers/${manager.id}">
                   <span class="glyphicon glyphicon-eye-open"></span>
                </a>
            </td>
            <td>
                <a href="http://localhost:8083/timesheet/managers/${manager.id}?update">
                    <span class="glyphicon glyphicon-pencil"></span>
                </a>
            </td>
            <td>
                <a href="http://localhost:8083/timesheet/managers/delete/${manager.id}">
                    <span class="glyphicon glyphicon-trash"></span>
                </a>
            </td>
            <!-- close row -->
        </tr>
        <!-- close the loop -->
    </c:forEach>
    <!-- close table -->
</tbody>
</table>

