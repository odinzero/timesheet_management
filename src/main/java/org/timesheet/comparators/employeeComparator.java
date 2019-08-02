package org.timesheet.comparators;

import java.util.Comparator;
import org.timesheet.domain.Employee;

public class employeeComparator {

    public static class idDescComparator implements Comparator<Employee> {

        @Override
        public int compare(Employee o1, Employee o2) {

            Employee e1 =  o1;
            Employee e2 =  o2;

            if (e1.getId() == e2.getId()) {
                return 0;
            } else if (e1.getId() > e2.getId()) {
                return -1;
            } else {
                return 1;
            }
        }

        
    }

    public static class idAscComparator implements Comparator<Employee> {

        @Override
        public int compare(Employee o1, Employee o2) {

            Employee e1 =  o1;
            Employee e2 =  o2;

            if (e1.getId() == e2.getId()) {
                return 0;
            } else if (e1.getId() > e2.getId()) {
                return 1;
            } else {
                return -1;
            }
        }
    }

    public static class departmentAscComparator implements Comparator<Employee> {

        @Override
        public int compare(Employee o1, Employee o2) {

            Employee e1 =  o1;
            Employee e2 =  o2;

            return e1.getDepartment().compareTo(e2.getDepartment());
        }
    }   
    
    public static class departmentDescComparator implements Comparator<Employee> {

        @Override
        public int compare(Employee o1, Employee o2) {

            Employee e1 =  o1;
            Employee e2 =  o2;

            return e2.getDepartment().compareTo(e1.getDepartment());
        }
    }
    
    public static class nameAscComparator implements Comparator<Employee> {

        @Override
        public int compare(Employee o1, Employee o2) {

            Employee e1 =  o1;
            Employee e2 =  o2;

            return e1.getName().compareTo(e2.getName());
        }
    }   
    
    public static class nameDescComparator implements Comparator<Employee> {

        @Override
        public int compare(Employee o1, Employee o2) {

            Employee e1 =  o1;
            Employee e2 =  o2;

            return e2.getName().compareTo(e1.getName());
        }
    }

}
