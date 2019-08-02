package org.timesheet.web;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.timesheet.comparators.employeeComparator;
import org.timesheet.domain.Employee;
import org.timesheet.forms.EmployeeForm;
import org.timesheet.service.dao.EmployeeDao;
import org.timesheet.utils.QueryConstants;
import org.timesheet.web.exceptions.EmployeeDeleteException;

/**
 * Controller for handling Employees.
 */
@Controller
@RequestMapping("/employees")
public class EmployeeController {

    // private static final Logger logger = LoggerFactory.getLogger(EmployeeController.class);
    static final Logger logger = Logger.getLogger(EmployeeController.class);

    private EmployeeDao employeeDao;

    @Autowired
    public void setEmployeeDao(EmployeeDao employeeDao) {
        this.employeeDao = employeeDao;
    }

    public EmployeeDao getEmployeeDao() {
        return employeeDao;
    }

    /**
     * Retrieves employees, puts them in the model and returns corresponding
     * view
     *
     * @param model Model to put employees to
     * @return employees/list
     */
    // http://localhost:8083/timesheet/employees?page={1...9}&pageSize={1...10}
    @RequestMapping(method = RequestMethod.GET)
    public String showEmployees(
            @RequestParam(value = "page", required = false) String page,
            @RequestParam(value = "pageSize", required = false) String pageSize,
            Model model) {

        logger.info("=== EmployeeController === method:showEmployees --- start");

        Long totalCount = employeeDao.countTotalItems();

        if (pageSize == null) {
            pageSize = "2";
            page = "1";

            pagination(totalCount, page, pageSize, model);

        } else {

            pagination(totalCount, page, pageSize, model);
        }

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("page", page);
        model.addAttribute("totalCount", totalCount);

//        List<Employee> employees1 = employeeDao.list();
//
//        ArrayList employees = (ArrayList) employees1;
//        model.addAttribute("employees", employees);
        model.addAttribute("view", "employees/list");

        logger.info("=== EmployeeController === method:showEmployees --- end");

        //return "employees/list";
        return "layout/content";
    }

    public double pagination(Long totalCount, String page, String pageSize, Model model) {

        double NumberOfPage = Math.ceil(totalCount / Double.parseDouble(pageSize));

        List<Employee> employees1 = null;
        // number rows is less then 'pageSize'
        if (NumberOfPage <= 1) {
            model.addAttribute("isNeedPagination", false);

            employees1 = employeeDao.list();

            ArrayList employees = (ArrayList) employees1;

            model.addAttribute("employees", employees);
            // number rows is more then 'pageSize' then need PAGINATION
        } else {
            model.addAttribute("isNeedPagination", true);

            if (page != null) {
                int p = Integer.parseInt(page);
                int s = Integer.parseInt(pageSize);

                employees1 = employeeDao.findAllPaginated(p, s);

                ArrayList employees = (ArrayList) employees1;

                model.addAttribute("employees", employees);

                // calculate number PAGES
                List<Integer> pages = new ArrayList();
                for (int i = 0, cntPages = 0; i < totalCount; i += Integer.parseInt(pageSize)) {

                    cntPages++;
                    pages.add(cntPages);
                }
                model.addAttribute("pages", pages);
            }
        }
        return NumberOfPage;
    }

    /**
     * Deletes employee with specified ID
     *
     * @param id Employee's ID
     * @return redirects to employees if everything was ok
     * @throws EmployeeDeleteException When employee cannot be deleted
     */
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    // @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String deleteEmployee(@PathVariable("id") long id)
            throws EmployeeDeleteException {

        logger.info("=== EmployeeController === method:deleteEmployee --- start");

        Employee toDelete = employeeDao.find(id);
        boolean wasDeleted = employeeDao.removeEmployee(toDelete);

        if (!wasDeleted) {
            throw new EmployeeDeleteException(toDelete);
        }

        logger.info("=== EmployeeController === method:deleteEmployee --- end");

        // everything OK, see remaining employees
        return "redirect:/employees";
    }

    /**
     * Handles EmployeeDeleteException
     *
     * @param e Thrown exception with employee that couldn't be deleted
     * @return binds employee to model and returns employees/delete-error
     */
    @ExceptionHandler(EmployeeDeleteException.class)
    public ModelAndView handleDeleteException(EmployeeDeleteException e) {

        logger.info("=== EmployeeController === method:handleDeleteException --- start");

        ModelMap model = new ModelMap();
        model.put("employee", e.getEmployee());

        logger.info("=== EmployeeController === method:handleDeleteException --- end");

        return new ModelAndView("employees/delete-error", model);
    }

    /**
     * Returns employee with specified ID
     *
     * @param id Employee's ID
     * @param model Model to put employee to
     * @return employees/view
     */
    // http://localhost:8083/timesheet/employees/{id}
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String getEmployee(@PathVariable("id") long id, Model model) {

        logger.info("=== EmployeeController === method:getEmployee --- start");

        Employee employee = employeeDao.find(id);
        model.addAttribute("employee", employee);
        model.addAttribute("view", "employees/");

        logger.info("=== EmployeeController === method:getEmployee --- end");

        //return "employees/view";
        return "layout/content";
    }

    // ========================== UPDATE =======================================
    @ModelAttribute("employeeUpdate")
    public EmployeeForm updateEmployeeForm() {
        return new EmployeeForm();
    }

    // http://localhost:8083/timesheet/employees/{id}?update
    @RequestMapping(value = "/{id}", params = "update", method = RequestMethod.GET)
    //public ModelAndView updateEmployeeForm(@PathVariable("id") long id, Model model) {
    public String updateEmployeeForm(@PathVariable("id") long id, Model model) {

        logger.info("=== EmployeeController === method:updateEmployeeForm --- start");

        Employee employee = employeeDao.find(id);
        model.addAttribute("employee", employee);

        model.addAttribute("view", "employees/update_get");

        logger.info("=== EmployeeController === method:updateEmployeeForm --- end");

        // return "employees/new";
        //return new ModelAndView("employees/update", "command", new EmployeeForm());
        return "layout/content";
    }

    /**
     * Updates employee with specified ID
     *
     * @param id Employee's ID
     * @param employee Employee to update (bounded from HTML form)
     * @return redirects to employees
     */
    // http://localhost:8083/timesheet/employees/{id}
    @RequestMapping(value = "/{id}", method = RequestMethod.POST)
    // public String updateEmployee(@PathVariable("id") long id, Employee employee) {
    public String updateEmployee(@PathVariable("id") long id,
            @ModelAttribute("employeeUpdate") @Validated EmployeeForm employeeForm,
            BindingResult bindingResult, Model model) {

//        ReloadableResourceBundleMessageSource source = new ReloadableResourceBundleMessageSource();
//			source.setBasename("classpath:employeeUpdate");
//			source.setCacheSeconds(0); 
//			source.setDefaultEncoding("UTF-8");
        ApplicationContext context = new ClassPathXmlApplicationContext("classpath*:update.xml");

        logger.info("=== EmployeeController === method:updateEmployee --- start");

        Employee employee = employeeDao.find(id);
        employee.setId(id);

        if (bindingResult.hasErrors()) {

            // just for keeping in form action URL ${employee.id}
            model.addAttribute("employee", employee);
            // set selected value in DROPDOWN LIST =Department=
            model.addAttribute("selectedDepartment", employeeForm.getDepartment());

            // when button "Update" has been clicked             
            model.addAttribute("try_update", "updated");
            model.addAttribute("view", "employees/update_post");

            return "layout/content";
            //return "employees/update";
        }

        employee.setName(employeeForm.getName());
        employee.setDepartment(employeeForm.getDepartment());

        employeeDao.update(employee);

        logger.info("=== EmployeeController === method:updateEmployee --- end");

        return "redirect:/employees";
    }

    // ========================== CREATE =======================================
    @ModelAttribute("employeeCreate")
    public EmployeeForm createEmployeeForm() {
        return new EmployeeForm();
    }

    /**
     * Creates form for new employee
     *
     * @param model Model to bind to HTML form
     * @return employees/new
     */
    // http://localhost:8083/timesheet/employees?new
    @RequestMapping(params = "new", method = RequestMethod.GET)
    //public ModelAndView createEmployeeForm(Model model) {
    public String createEmployeeForm(Model model) {

        logger.info("=== EmployeeController === method:createEmployeeForm --- start");

        model.addAttribute("view", "employees/create_get");

        logger.info("=== EmployeeController === method:createEmployeeForm --- end");

        // return "employees/new";
        // return new ModelAndView("employees/new", "command", new EmployeeForm());
        return "layout/content";
    }

    /**
     * Saves new employee to the database
     *
     * @param employee Employee to save
     * @return redirects to employees
     */
    // http://localhost:8083/timesheet/employees
    @RequestMapping(method = RequestMethod.POST)
    // public String addEmployee(Employee employee) {
    public String addEmployee(@ModelAttribute("employeeCreate") @Validated EmployeeForm employeeForm,
            BindingResult bindingResult, Model model) {

//        ReloadableResourceBundleMessageSource source = new ReloadableResourceBundleMessageSource();
//			source.setBasename("classpath:employeeCreate");
//			source.setCacheSeconds(0); 
//			source.setDefaultEncoding("UTF-8");
        logger.info("=== EmployeeController === method:addEmployee --- start");

        if (bindingResult.hasErrors()) {

            // set selected value in DROPDOWN LIST =Department=
            model.addAttribute("selectedDepartment", employeeForm.getDepartment());

            // when button "Create" has been clicked             
            model.addAttribute("try_create", "created");
            // see file content.jsp
            model.addAttribute("view", "employees/create_post");

            return "layout/content";
            //return "employees/new";
        }

        Employee employee = new Employee(employeeForm.getName(), employeeForm.getDepartment());
        employeeDao.add(employee);

        logger.info("=== EmployeeController === method:addEmployee --- end");

        return "redirect:/employees";
    }

    // ========================== SORTING ======================================
    public List sortedPagination(Long totalCount, String page, String pageSize,
            String sortBy, String sortOrder, String sortLocalOrGlobal, Model model) {

        double NumberOfPage = Math.ceil(totalCount / Double.parseDouble(pageSize));

        List<Employee> employees1 = null;
        // number rows is less then 'pageSize'
        if (NumberOfPage <= 1) {
            model.addAttribute("isNeedPagination", false);

            employees1 = employeeDao.findAllSorted(sortBy, sortOrder);

            ArrayList employees = (ArrayList) employees1;

            model.addAttribute("employees", employees);
            // number rows is more then 'pageSize' then need PAGINATION
        } else {
            model.addAttribute("isNeedPagination", true);

            if (page != null) {
                int p = Integer.parseInt(page);
                int s = Integer.parseInt(pageSize);

                if (sortLocalOrGlobal == "global") {
                    employees1 = employeeDao.findAllPaginatedAndSorted(p, s, sortBy, sortOrder);
                }

                if (sortLocalOrGlobal == "local") {
                    employees1 = employeeDao.findAllPaginated(p, s);

                    Collections.sort(employees1, sortLocalChoice(sortBy, sortOrder)); 
                }

                ArrayList employees = (ArrayList) employees1;

                model.addAttribute("employees", employees);

                //logger.info(":: Employee :: " + employees.toString());
                // calculate number PAGES
                List<Integer> pages = new ArrayList();
                for (int i = 0, cntPages = 0; i < totalCount; i += Integer.parseInt(pageSize)) {

                    cntPages++;
                    pages.add(cntPages);
                }
                model.addAttribute("pages", pages);
            }
        }
        return employees1;
    }

    public Comparator sortLocalChoice(String sortBy, String sortOrder) {

        Comparator<Employee> c = null;

        if (sortBy.equals("id") && sortOrder.equals("asc") ) {
            c = new employeeComparator.idAscComparator();
        }
        if (sortBy.equals("id") && sortOrder.equals("desc") ) {
            c = new employeeComparator.idDescComparator();
        }
        if (sortBy.equals("department") && sortOrder.equals("asc") ) {
            c = new employeeComparator.departmentAscComparator();
        }
        if (sortBy.equals("department") && sortOrder.equals("desc") ) {
            c = new employeeComparator.departmentDescComparator();
        }
        if (sortBy.equals("name") && sortOrder.equals("asc") ) {
            c = new employeeComparator.nameAscComparator();
        }
        if (sortBy.equals("name") && sortOrder.equals("desc") ) {
            c = new employeeComparator.nameDescComparator();
        }

        return c;
    }

    // http://localhost:8083/timesheet/employees?page={1,2,3...}&pageSize={1,2,3...}&sortBy={id,department,name}&sortOrder={asc,desc}
    @RequestMapping(params = {QueryConstants.SORT_BY}, method = RequestMethod.GET)
    //@ResponseBody
    public String findAllSorted(
            @RequestParam(value = "page", required = false) String page,
            @RequestParam(value = "pageSize", required = false) String pageSize,
            @RequestParam(value = QueryConstants.SORT_BY)  String sortBy,
            @RequestParam(value = QueryConstants.SORT_ORDER, required = false) String sortOrder,
            Model model) {
        logger.info(" ==== EmployeeController ======= method:findAllSorted ====== start ");

        Long totalCount = employeeDao.countTotalItems();

        List<Employee> employees1 = null;

        // PAGINATION
        if (pageSize == null) {
            pageSize = "2";
            page = "1";

            employees1 = sortedPagination(totalCount, page, pageSize, sortBy, sortOrder, "local", model);
        } else {

            employees1 = sortedPagination(totalCount, page, pageSize, sortBy, sortOrder, "local", model);
        }

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("page", page);
        model.addAttribute("totalCount", totalCount);

        ArrayList employees = (ArrayList) employees1;

        model.addAttribute("sortBy", sortBy);
        model.addAttribute("order", sortOrder);

        if (sortOrder == "desc") {
            model.addAttribute("class", "desc");
        }
        if (sortOrder == "asc") {
            model.addAttribute("class", "asc");
        }

        model.addAttribute("searchedByFields", false);

        model.addAttribute("employees", employees);
        model.addAttribute("view", "employees/list");

        logger.info(" ==== EmployeeController ======= method:findAllSorted ====== end ");

        return "layout/content";
    }

    public List sortedAndFieldSearchPagination(String[] sortByItem, String[] inputtedWord,
            Long totalCount, String page, String pageSize,
            String sortBy, String sortOrder, Model model) {

        double NumberOfPage = Math.ceil(totalCount / Double.parseDouble(pageSize));

        List<Employee> employees1 = null;
        // number rows is less then 'pageSize'
        if (NumberOfPage <= 1) {
            model.addAttribute("isNeedPagination", false);

            employees1 = employeeDao.findAllSorted(sortByItem, inputtedWord, sortBy, sortOrder);

            ArrayList employees = (ArrayList) employees1;

            model.addAttribute("employees", employees);
            // number rows is more then 'pageSize' then need PAGINATION
        } else {
            model.addAttribute("isNeedPagination", true);

            if (page != null) {
                int p = Integer.parseInt(page);
                int s = Integer.parseInt(pageSize);

                employees1 = employeeDao.findAllPaginatedAndSorted(sortByItem, inputtedWord, p, s, sortBy, sortOrder);

                ArrayList employees = (ArrayList) employees1;

                model.addAttribute("employees", employees);

                // calculate number PAGES
                List<Integer> pages = new ArrayList();
                for (int i = 0, cntPages = 0; i < totalCount; i += Integer.parseInt(pageSize)) {

                    cntPages++;
                    pages.add(cntPages);
                }
                model.addAttribute("pages", pages);
            }
        }
        return employees1;
    }

    // http://localhost:8083/timesheet/employees/search?id={id}&department={department}&name={name}
    @RequestMapping(value = "/search", method = RequestMethod.GET)
    //@ResponseBody
    public String searchAll(
            @RequestParam(value = "page", required = false) String page,
            @RequestParam(value = "pageSize", required = false) String pageSize,
            @RequestParam(value = "id") String id,
            @RequestParam(value = "department") String department,
            @RequestParam(value = "name") String name,
            @RequestParam(value = QueryConstants.SORT_BY, required = false) String sortBy,
            @RequestParam(value = QueryConstants.SORT_ORDER, required = false) String sortOrder,
            Model model) {

        logger.info(" ==== EmployeeController ======= method:searchAll ====== start :" + page);

        String[] sortByItem = {"id", "department", "name"};

        // to save values in text FIELDS
        model.addAttribute("field_id", id);
        model.addAttribute("field_department", department);
        model.addAttribute("field_name", name);

        if (id != "") {
            if (!id.matches("\\d+")) {

                List<Employee> employees1 = employeeDao.list();

                ArrayList employees = (ArrayList) employees1;

                model.addAttribute("error_id", true);

                model.addAttribute("employees", employees);
                model.addAttribute("view", "employees/list");

                return "layout/content";
            }
        }

        if (department == null) {
            department = "";
        }
        if (name == null) {
            name = "";
        }

        String[] word = {id, department, name};

        if (sortBy == null) {
            sortBy = "";
        }
        if (sortOrder == null) {
            sortOrder = "";
        }

        model.addAttribute("searchedByFields", true);

        model.addAttribute("sortBy", sortBy);
        model.addAttribute("order", sortOrder);

        if (sortOrder == "desc") {
            model.addAttribute("class", "desc");
        }
        if (sortOrder == "asc") {
            model.addAttribute("class", "asc");
        }

        List<Employee> employees1 = null;

        employees1 = employeeDao.findAllSorted(sortByItem, word, sortBy, sortOrder);

        Long totalCount = Long.valueOf(employees1.size());

        // PAGINATION
        // if 'pageSize' is not present in URL
        if (pageSize == null) {
            pageSize = "2";
            page = "1";

            employees1 = sortedAndFieldSearchPagination(sortByItem, word, totalCount, page, pageSize, sortBy, sortOrder, model);

        } else {

            employees1 = sortedAndFieldSearchPagination(sortByItem, word, totalCount, page, pageSize, sortBy, sortOrder, model);
        }

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("page", page);
        model.addAttribute("totalCount", totalCount);

       // List<Employee> employees1 = employeeDao.findAllSorted(sortByArr, word, sortBy, sortOrder);
        ArrayList employees = (ArrayList) employees1;
        // show view
        model.addAttribute("employees", employees);
        model.addAttribute("view", "employees/list");

        logger.info(" ==== EmployeeController ======= method:searchAll ====== end : ");

        return "layout/content";
    }

}
