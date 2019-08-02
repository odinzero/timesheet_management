
<h1>
    Task's List  
</h1>

<!-- BUTTON "Create Employee" -->
<p><a class="btn btn-success" href="/timesheet/tasks?new">Create Task</a></p>
<!--provide an html table start tag -->
<table class="table table-striped table-bordered">
    <thead>
        <tr>
            <th><a href="/MYBLOG/web/post/search?sort=description" data-sort="description">ID</a></th>     
            <th><a href="/MYBLOG/web/post/search?sort=description" data-sort="description">Completed</a></th>
            <th><a href="/MYBLOG/web/post/search?sort=description" data-sort="description">Description</a></th> 
            <th>View</th>
            <th>Update</th>
            <th>Delete</th>
        </tr>
        <tr id="w0-filters" class="filters">
            <td><input type="text" class="form-control" name="PostSearch[id]" value=""></td>
            <td><input type="text" class="form-control" name="PostSearch[title]" value=""></td>
            <td><input type="text" class="form-control" name="PostSearch[description]" value=""></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </thead>
    <tbody>
        <!-- iterate over the collection using forEach loop -->
    <c:forEach var="task" items="${tasks}">
        <!-- create an html table row -->
        <tr>
            <!-- create cells of row -->
            <td>${task.id}</td>
            <td>${task.completed}</td>
            <td>${task.description}</td>
            <td>
                <a href="http://localhost:8083/timesheet/tasks/${task.id}">
                    <span class="glyphicon glyphicon-eye-open"></span>
                </a>
            </td>
            <td>
                <ul>
                    <li><a href="http://localhost:8083/timesheet/tasks/${task.id}?update">
                          <span class="glyphicon glyphicon-pencil"></span>  
                        </a><span>Update</span>
                    </li>
                    <li>
                        <a href="http://localhost:8083/timesheet/task_ajax/${task.id}?updateAjax">
                           <span class="glyphicon glyphicon-pencil"></span>  
                        </a><span>UpdateAjax</span>
                    </li>
                    <li>
                        <a href="http://localhost:8083/timesheet/task_ajax2/${task.id}?updateAjax2">
                           <span class="glyphicon glyphicon-pencil"></span> 
                        </a><span>UpdateAjax2</span>
                    </li>
                    <li>
                        <a href="http://localhost:8083/timesheet/task_ajaxform/${task.id}?updateAjaxForm">
                           <span class="glyphicon glyphicon-pencil"></span> 
                        </a><span>UpdateAjaxForm</span>
                    </li>
                    <li>
                        <a href="http://localhost:8083/timesheet/task_ajax_servlet?id=${task.id}">
                            <span class="glyphicon glyphicon-pencil"></span>
                        </a><span>UpdateAjaxServlet</span>
                    </li>
                </ul>
            </td>
            <td>
                <a href="http://localhost:8083/timesheet/tasks/delete/${task.id}">
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

