<!--  <P> $ {timesheets} </P> -->
<h1> Timesheet's List  </h1>
<!-- BUTTON "Create Employee" -->
<p><a class="btn btn-success" href="/timesheet/timesheets?new">Create Timesheet</a></p>
<!--provide an html table start tag -->
<table class="table table-striped table-bordered">
    <thead>
        <tr>
            <th><a href="/MYBLOG/web/post/search?sort=description" data-sort="description">ID</a></th>     
            <th><a href="/MYBLOG/web/post/search?sort=description" data-sort="description">Hours</a></th>
            <th><a href="/MYBLOG/web/post/search?sort=description" data-sort="description">Who</a></th>
            <th><a href="/MYBLOG/web/post/search?sort=description" data-sort="description">Task</a></th> 
            <th>View</th>
            <th>Update</th>
            <th>Delete</th>
        </tr>
        <tr id="w0-filters" class="filters">
            <td><input type="text" class="form-control" name="PostSearch[id]" value=""></td>
            <td><input type="text" class="form-control" name="PostSearch[title]" value=""></td>
            <td><input type="text" class="form-control" name="PostSearch[description]" value=""></td>
            <td><input type="text" class="form-control" name="PostSearch[description]" value=""></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </thead>
    <tbody>
        <!-- iterate over the collection using forEach loop -->
    <c:forEach var="timesheet" items="${timesheets}">
        <!-- create an html table row -->
        <tr>
            <!-- create cells of row -->
            <td>${timesheet.id}</td>
            <td>${timesheet.hours}</td>
            <td>
                <a href="http://localhost:8083/timesheet/employees/${timesheet.who.id}">${timesheet.who.name}</a>
            </td>
            <td>
                <a href="http://localhost:8083/timesheet/tasks/${timesheet.task.id}">Task ${timesheet.task.id} </a>
            </td>
            <td>
                <a href="http://localhost:8083/timesheet/timesheets/${timesheet.id}">
                    <span class="glyphicon glyphicon-eye-open"></span>
                </a>
            </td>
            <td>
                <a href="http://localhost:8083/timesheet/timesheets/${timesheet.id}?update">
                    <span class="glyphicon glyphicon-pencil"></span>
                </a>
            </td>
            <td>
                <a href="http://localhost:8083/timesheet/timesheets/delete/${timesheet.id}">
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
