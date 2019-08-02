
<style>
    .table td, table th {
        text-align: center;
        border-top: none !important; 
    }
    .table > tbody > tr > td, .table > thead > tr > th {
     vertical-align: middle;
    }
</style>
<body>
    <!--
    <h3>
         $ {task}   
    </h3>
    -->

    <!--
    <h3>
         $ {unassigned}  
    </h3>
    -->

    <h1> ${task.description} </h1>

    <p>
        <a class="btn btn-primary" href="/timesheet/tasks/${task.id}?update">Update</a>
        <a class="btn btn-danger" href="/timesheet/tasks/delete/${task.id}" 
           data-confirm="Are you sure you want to delete this item?" data-method="post">Delete</a>
    </p>
    <!--provide an html table start tag -->
    <table class="table table-bordered">
        <thead>
            <tr class="active">
                <th rowspan="2">ID</th>
                <th rowspan="2">Completed</th>
                <th rowspan="2">Description</th>
                <th id="empolyees" colspan="2">Employee</th>
                <th id="managers" colspan="2">Manager</th> 
            </tr>
            <tr class="active">

                <th>Assigned</th>
                <th>Unassigned</th>

                <th>Assigned</th>
                <th>Unassigned</th>
            </tr>
        </thead>
        <!-- create an html table row -->
        <tbody>
            <tr>
                <!-- create cells of row -->
                <td>${task.id}</td>
                <td>${task.completed}</td>
                <td>${task.description}</td>
                <!-- employee ASSIGNED -->
                <td colspan="1"> 
                    <table class="table">
                        <c:forEach var="assigned" items="${task.assignedEmployees}">
                                <tr>
                                    <td>
                                      <a href="http://localhost:8083/timesheet/employees/${assigned.id}">${assigned.name}</a>
                                    </td>
                                </tr>
                        </c:forEach>
                    </table>
                </td>
                <!-- employee UNASSIGNED -->
                <td> 
                    <table class="table">
                        <c:forEach var="unassigned" items="${unassigned}">
                            <tr>
                                <td>
                                    <a href="http://localhost:8083/timesheet/employees/${unassigned.id}">${unassigned.name}</a>
                                </td>
                            </tr> 
                        </c:forEach>
                    </table>
                </td>
                <!-- manager ASSIGNED -->
                <td colspan="1"> 
                    <table class="table">
                        <tr>
                            <td>
                                <a href="http://localhost:8083/timesheet/managers/${task.manager.id}">${task.manager.name}</a>
                            </td>
                        <tr>
                    </table>
                </td>
                <!-- manager UNASSIGNED -->
                <td></td>
                <!-- close row -->
            </tr>
        </tbody>
        <!-- close table -->
    </table>

