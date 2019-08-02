 
<style>
    .table td, table th {
        text-align: left;
        border-top: none !important; 
    }
    .table > tbody > tr > td, .table > tbody > tr > th {
     vertical-align: middle;
    }
    #tableInside {
        margin-top: 2px;
    }
</style>

        <h1> ${manager.name}'s tasks  </h1>

        <h4><!--$ {tasks} --></h4>

        <c:choose>

            <c:when test="${not empty tasks}">

                <table class="table table-bordered table-condensed">
                    <tbody>
                        <!-- create an html table row -->
                        <c:forEach var="task" items="${tasks}">
                            <tr>
                                <th class="alert-success">ID</th>
                                <td>${task.id}</td>
                            <tr>    
                            <tr>
                                <th class="alert-success">Completed</th>
                                <td>${task.completed}</td>
                            </tr>    
                            <tr>
                                <th class="alert-success">Description</th>
                                <td>${task.description}</td>
                            </tr>    
                            <tr> 
                                <th class="alert-success">Employee</th>
                                <td>
                                <!-- employee ASSIGNED --> 
                                <table class="table"  id="tableInside">
                                        <c:forEach var="assigned" items="${task.assignedEmployees}">
                                            <tr>
                                                <td>
                                                    <a href="http://localhost:8083/timesheet/employees/${assigned.id}">${assigned.name}</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </table>
                                </td>                
                            </tr>
                        </c:forEach>
                    </tbody>
                    <!-- close table -->
                </table>

            </c:when>  
             
            <c:otherwise>
                <h1>No tasks</h1>
            </c:otherwise>      

        </c:choose>    
