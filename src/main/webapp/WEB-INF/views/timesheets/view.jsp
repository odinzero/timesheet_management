
<style>
    .table td, table th {
        text-align: center;
        border-top: none !important; 
    }
    .table > tbody > tr > td, .table > thead > tr > th {
     vertical-align: middle;
    }
    #tableInside {
        margin-top: 15px;
    }
</style>

<h1>
    Timesheet's  ${tsCommand.timesheet.who.name} 
</h1>

<p>
    <a class="btn btn-primary" href="/timesheet/timesheets/${tsCommand.timesheet.id}?update">Update</a>
    <a class="btn btn-danger" href="/timesheet/timesheets/delete/${tsCommand.timesheet.id}" 
       data-confirm="Are you sure you want to delete this item?" data-method="post">Delete</a>
</p>
<!--provide an html table start tag -->
<table class="table table-bordered">
    <thead>
        <tr class="active">
            <th rowspan="3" colspan="1" >Hours</th>
            <th colspan="5" style="text-align: center;">Timesheet</th>
        </tr>
        <tr class="active">

            <th rowspan="2">Who</th>
            <th colspan="4">Task</th>
        </tr>
        <tr class="active">
            <th>Description</th>
            <th>Assigned Employees</th>
            <th>Manager</th>
            <th>Completed</th>
        </tr>
    </thead>
    <tbody>
        <!-- create an html table row -->
        <tr>
            <!-- create cells of row -->
            <td colspan="1">${tsCommand.hours}</td>
            <td colspan="1"> 
                <a href="http://localhost:8083/timesheet/employees/${tsCommand.timesheet.who.id}">${tsCommand.timesheet.who.name}</a>  
            </td>
            <td> 
                ${tsCommand.timesheet.task.description}
            </td>
            <td>
                <table id="tableInside" class="table">
                    <c:forEach var="assigned" items="${tsCommand.timesheet.task.assignedEmployees}">
                        <tr>
                            <td>
                                <a href="http://localhost:8083/timesheet/employees/${assigned.id}">${assigned.name}</a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </td>
            <td>   
                <a href="http://localhost:8083/timesheet/managers/${tsCommand.timesheet.task.manager.id}">${tsCommand.timesheet.task.manager.name}</a>
            </td>
            <td>
                ${tsCommand.timesheet.task.completed}
            </td>
            <!-- close row -->
        </tr>
    </tbody>
    <!-- close table -->
</table>