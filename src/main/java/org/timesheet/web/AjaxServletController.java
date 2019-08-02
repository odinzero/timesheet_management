
package org.timesheet.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;
import org.timesheet.domain.Manager;
import org.timesheet.domain.Task;
import org.timesheet.service.dao.EmployeeDao;
import org.timesheet.service.dao.ManagerDao;
import org.timesheet.service.dao.TaskDao;
import org.timesheet.service.impl.TaskDaoImpl;

//@WebServlet(
//  name = "AnnotationExample",
//  description = "Example Servlet Using Annotations",
//  urlPatterns = {"/task_ajax_servlet"}
//)
//@WebServlet("/task_ajax_servlet")
public class AjaxServletController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public void init(ServletConfig config) throws ServletException {
      super.init(config);
      SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this,
      config.getServletContext());
 //     SpringBeanAutowiringSupport.processInjectionBasedOnCurrentContext(this);
  }
    
    @Autowired
    private TaskDao taskDao;
    @Autowired
    private EmployeeDao employeeDao;
    @Autowired
    private ManagerDao managerDao;

    
    public void setTaskDao(TaskDao taskDao) {
        this.taskDao = taskDao;
    }

    
    public void setEmployeeDao(EmployeeDao employeeDao) {
        this.employeeDao = employeeDao;
    }

    
    public void setManagerDao(ManagerDao managerDao) {
        this.managerDao = managerDao;
    }

    public EmployeeDao getEmployeeDao() {
        return employeeDao;
    }

    public TaskDao getTaskDao() {
        return taskDao;
    }

    public ManagerDao getManagerDao() {
        return managerDao;
    }
    
    // http://localhost:8083/timesheet/task_ajax_servlet/loaddata
   // @RequestMapping(value = "/loaddata", method = RequestMethod.POST)
   // @ResponseBody
   // public String loadData(@RequestParam Long id) {
      public String loadData( Long id) {
        Task task = taskDao.find(id);

        String description = task.getDescription();
        // list of managers to choose from DROPDOWN LIST =MANAGERS=
//        List<Manager> managers = managerDao.list();
//        // get CHECKBOX state
//        String bool = Boolean.toString(task.isCompleted());
//
//        List<org.timesheet.domain.Employee> assignedEmployees = task.getAssignedEmployees();
//
//        // add all remaining employees
//        List<org.timesheet.domain.Employee> employees = employeeDao.list();
//        Set<org.timesheet.domain.Employee> unassignedEmployees = new HashSet<org.timesheet.domain.Employee>();
//
//        for (org.timesheet.domain.Employee employee : employees) {
//            if (!task.getAssignedEmployees().contains(employee)) {
//                unassignedEmployees.add(employee);
//            }
//        }

        return description + "&&" ;
//                + managers.toString() + "&&" + bool + "&&"
//                + assignedEmployees.toString() + "&&" + unassignedEmployees.toString();
    }
    
    // http://localhost:8083/timesheet/task_ajax_servlet?id=7
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        request.setAttribute("id", id);
        
       // response.setContentType("text/html");
       // PrintWriter out = response.getWriter();
       // out.println("<p>Hello World!</p>");
        
        //ServletContext otherContext = request.getServletContext().getContext("/WEB-INF/views/tasks");
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/tasks/updateAjaxServlet.jsp");
        dispatcher.forward(request, response);
    }
    
     @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //request.setAttribute("selectedCatId", categoryId);
        // Long id = Long.parseLong(request.getParameter("id"));
        //Long id = request.getParameter("id");
        
         int loaddata = Integer.parseInt(request.getParameter("loaddata"));
        if(loaddata == 1) {
           // String data = loadData(7L);
             Task task = taskDao.find(7L);

            String description = task.getDescription();
            
            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("" + description);
        }
 
       // listCategory(request, response);
    }
}
