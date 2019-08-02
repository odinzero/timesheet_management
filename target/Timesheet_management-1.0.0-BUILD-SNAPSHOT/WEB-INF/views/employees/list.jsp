
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<style>

    a.asc:after {
        content: /*"\e113"*/ "\e151";
    }
    a.desc:after {
        content: /*"\e114"*/ "\e152";
    }

    a.asc:after, a.desc:after {
        position: relative;
        top: 1px;
        display: inline-block;
        font-family: 'Glyphicons Halflings';
        font-style: normal;
        font-weight: normal;
        line-height: 1;
        padding-left: 5px;
    }
</style>

<h1>Employees's List</h1>
<!-- BUTTON "Create Employee" -->
<div>
    <div class="col-md-10">
        <a class="btn btn-success" href="/timesheet/employees?new">Create Employee</a>
    </div>    

    <div class="col-md-2">
        <label class="form-inline">Show 
            <select name="page_size" aria-controls="dtBasicExample" id="page_size"
                    class="custom-select custom-select-sm form-control form-control-sm">

                <c:forEach var = "i" begin = "1" end = "50">
                    <c:choose>
                        <c:when test="${i == pageSize}">
                            <option value="${i}" selected="selected">${i}</option>
                        </c:when>
                        <c:otherwise>
                            <option value="${i}" >${i}</option>
                        </c:otherwise>    
                    </c:choose>
                </c:forEach>

            </select>
            entries
        </label>
    </div>
</div>

<div class="row">




</div>

<p>pageSize: ${pageSize}<!-- $ {searchedByFields} --> </p>
<p>pages: ${pages}<!--$ {sortBy} --> </p>
<p>totalCount: ${totalCount}<!-- $ {order} --> </p>
<p>sortBy: ${sortBy}<!-- $ {order} --> </p>
<p>searchedByFields: ${searchedByFields}<!-- $ {order} --> </p>

<!--provide an html table start tag -->
<table  class="table table-striped table-bordered">
    <thead>
        <tr>
            <th><a id="sort_id" 
                   <c:if test="${sortBy == 'id'}">
                       <c:if test="${order == 'desc'}">class="desc"</c:if>
                       <c:if test="${order == 'asc'}">class="asc"</c:if>
                   </c:if>
                   href="#" >ID</a></th>     
            <th><a id="sort_dpmt" 
                   <c:if test="${sortBy == 'department'}">
                       <c:if test="${order == 'desc'}">class="desc"</c:if>
                       <c:if test="${order == 'asc'}">class="asc"</c:if>
                   </c:if>
                   href="/timesheet/employees?sortBy=department&sortOrder=desc" >Department</a></th>
            <th><a id="sort_name" 
                   <c:if test="${sortBy == 'name'}">
                       <c:if test="${order == 'desc'}">class="desc"</c:if>
                       <c:if test="${order == 'asc'}">class="asc"</c:if>
                   </c:if>
                   href="/timesheet/employees?sortBy=name&sortOrder=desc" >Name</a></th>
            <th>View</th>
            <th>Update</th>
            <th>Delete</th>
        </tr>
        <tr id="w0-filters" class="filters">
            <td><input type="text" id="field_id" class="form-control"  value="${field_id}" data-search="${searchedByFields}"  >
                <p  class = "help-block" id="error_id" ></p>
            </td>
            <td><input type="text" id="field_department" class="form-control"  value="${field_department}" data-search="${searchedByFields}"></td>
            <td><input type="text" id="field_name" class="form-control"  value="${field_name}" data-search="${searchedByFields}"></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </thead>
    <tbody>
        <!-- iterate over the collection using forEach loop -->
        <c:choose>
            <c:when test="${!empty employees}">
                <c:forEach var="employee" items="${employees}">
                    <!-- create an html table row -->
                    <tr>
                        <!-- create cells of row -->
                        <td>${employee.id}</td>
                        <td>${employee.department}</td>
                        <td>${employee.name}</td>
                        <td>
                            <a href="http://localhost:8083/timesheet/employees/${employee.id}">
                                <span class="glyphicon glyphicon-eye-open"></span>    
                            </a></td>
                        <td>
                            <a href="http://localhost:8083/timesheet/employees/${employee.id}?update">
                                <span class="glyphicon glyphicon-pencil"></span>    
                            </a>
                        </td>
                        <td>
                            <a href="http://localhost:8083/timesheet/employees/delete/${employee.id}">
                                <span class="glyphicon glyphicon-trash"></span>
                            </a>
                        </td>
                        <!-- close row -->
                    </tr>
                    <!-- close the loop -->
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr><td colspan="6"><div class="empty">No results found.</div></td></tr>
            </c:otherwise>
        </c:choose>
        <!-- close table -->
    </tbody>
</table>

<c:choose>
    <c:when test="${isNeedPagination == true}">                            
        <div>  
            <div> 
                <div class="text-center">
                    <ul class="pagination" id="pagesEmployees">
                        <li class="page-item previous disabled" id="dtBasicExample_previous">
                            <a href="#" aria-controls="dtBasicExample" data-dt-idx="0" tabindex="0" class="page-link">Previous</a>
                        </li>

                        <c:forEach var = "p" items="${pages}" >

                            <c:choose>
                                <c:when test="${p == page}">
                                    <li class="page-item active">
                                        <a href="#" aria-controls="dtBasicExample" data-dt-idx="${p}" tabindex="0" class="page-link">${p}</a>
                                    </li>
                                </c:when> 
                                <c:otherwise>
                                    <li class="page-item">
                                        <a href="#" aria-controls="dtBasicExample" data-dt-idx="${p}" tabindex="0" class="page-link">${p}</a>
                                    </li>
                                </c:otherwise>
                            </c:choose>

                        </c:forEach>

                        <li class=" page-item next" id="dtBasicExample_next">
                            <a href="#" aria-controls="dtBasicExample" data-dt-idx="7" tabindex="0" class="page-link">Next</a>
                        </li>
                    </ul>
                    <div>Showing ${page} from ${fn:length(pages)} of ${totalCount} entries</div>
                </div>

            </div>

        </div> 
    </c:when>
    <c:otherwise>
        <div>Showing ${totalCount} of ${totalCount} entries</div>
    </c:otherwise>
</c:choose>



<c:if test='${error_id == true }'>
    <script>
        $('#error_id').html("ID must be an integer.");
        // add bootstrap class "has-error" and remove class "has-success"
        $("#error_id").closest('td').addClass("has-error");
        $("#error_id").closest('td').removeClass("has-success");
    </script>
</c:if>                    

<script type="text/javascript">
    $(document).ready(function() {

// ----------------------------- SORTING ---------------------------------------        

        // ID 
        $("#sort_id").click(function() {

            var searchedByFields = $("#field_id").attr("data-search");
            // when search in fields not was applied
            if (searchedByFields == "" || searchedByFields == "false") {
                $(this).sortData("id", "#sort_id");
            }
            // when search in fields was applied
            if (searchedByFields == "true") {
                $(this).sortDataAfterFieldsSearch("id", "#sort_id", $("#field_id").val(),
                        $("#field_department").val(), $("#field_name").val());
            }

        });
        // DEPARTMENT
        $("#sort_dpmt").click(function() {

            var searchedByFields = $("#field_department").attr("data-search");
            // when search in fields not was applied
            if (searchedByFields == "" || searchedByFields == "false") {
                $(this).sortData("department", "#sort_dpmt");
            }
            // when search in fields was applied
            if (searchedByFields == "true") {
                alert("bbb");
                $(this).sortDataAfterFieldsSearch("department", "#sort_dpmt", $("#field_id").val(),
                        $("#field_department").val(), $("#field_name").val());
            }
        });
        // NAME
        $("#sort_name").click(function() {

            var searchedByFields = $("#field_name").attr("data-search");
            // when search in fields not was applied
            if (searchedByFields == "" || searchedByFields == "false") {
                $(this).sortData("name", "#sort_name");
            }
            // when search in fields was applied
            if (searchedByFields == "true") {
                $(this).sortDataAfterFieldsSearch("name", "#sort_name", $("#field_id").val(),
                        $("#field_department").val(), $("#field_name").val());
            }
        });
        // FUNCTION SORT DATA WITHOUT SEARCHED IN FIELDS
        (function($) {
            $.fn.sortData = function(sortBy, idOrClass) {

                if (!$(idOrClass).hasClass('class')) {
                    alert("sort1");
                    $(idOrClass).attr('href', '/timesheet/employees?page=' +
                            $("#pagesEmployees li.active").text().trim() +
                            "&pageSize=" + $("#page_size").val() +
                            '&sortBy=' + sortBy + '&sortOrder=desc');
                }
                if ($(idOrClass).attr('class') == "desc") {
                    $(idOrClass).attr('href', '/timesheet/employees?page=' +
                            $("#pagesEmployees li.active").text().trim() +
                            "&pageSize=" + $("#page_size").val() +
                            '&sortBy=' + sortBy + '&sortOrder=asc');
                }
                if ($(idOrClass).attr('class') == "asc") {
                    $(idOrClass).attr('href', '/timesheet/employees?page=' +
                            $("#pagesEmployees li.active").text().trim() +
                            "&pageSize=" + $("#page_size").val() +
                            '&sortBy=' + sortBy + '&sortOrder=desc');
                }
                return this;
            };
        })(jQuery);
        // FUNCTION SORT DATA WHEN SEARCH WAS DONE IN FIELDS ( searchedByFields = true )
        (function($) {
            $.fn.sortDataAfterFieldsSearch = function(sortBy, idOrClass, value1, value2, value3) {

                if ($(idOrClass).attr('class') == undefined) {
                    //  any row item not founded
                    if ("${totalCount}" == 0)
                    {
                        $(idOrClass).attr('href',
                                "/timesheet/employees/search?id=" + value1 + "&department=" + value2 + "&name=" + value3 +
                                "&sortBy=" + sortBy + "&sortOrder=desc");
                    }
                    else {
                        $(idOrClass).attr('href',
                                "/timesheet/employees/search?page=" + "${page}" +
                                "&pageSize=" + $("#page_size").val() +
                                "&id=" + value1 + "&department=" + value2 + "&name=" + value3 +
                                "&sortBy=" + sortBy + "&sortOrder=desc");
                    }
                }
                if ($(idOrClass).attr('class') == "desc") {
                    //  any row item not founded
                    if ("${totalCount}" == 0)
                    {
                        $(idOrClass).attr('href',
                                "/timesheet/employees/search?id=" + value1 + "&department=" + value2 + "&name=" + value3 +
                                "&sortBy=" + sortBy + "&sortOrder=asc");
                    }
                    else {
                        $(idOrClass).attr('href',
                                "/timesheet/employees/search?page=" + "${page}" +
                                "&pageSize=" + $("#page_size").val() +
                                "&id=" + value1 + "&department=" + value2 + "&name=" + value3 +
                                "&sortBy=" + sortBy + "&sortOrder=asc");
                    }
                }
                if ($(idOrClass).attr('class') == "asc") {
                    //  any row item not founded
                    if ("${totalCount}" == 0)
                    {
                        $(idOrClass).attr('href',
                                "/timesheet/employees/search?id=" + value1 + "&department=" + value2 + "&name=" + value3 +
                                "&sortBy=" + sortBy + "&sortOrder=desc");
                    }
                    else {
                        $(idOrClass).attr('href',
                                "/timesheet/employees/search?page=" + "${page}" +
                                "&pageSize=" + $("#page_size").val() +
                                "&id=" + value1 + "&department=" + value2 + "&name=" + value3 +
                                "&sortBy=" + sortBy + "&sortOrder=desc");
                    }
                }
                return this;
            };
        })(jQuery);

// ---------------------------- SEARCHING --------------------------------------

        // FIELD "ID"
        $("#field_id").blur(function() {
            // alert("id: " + $(this).val());

            var searchedByFields = $(this).attr("data-search");
            if ($(this).val() != "") {

                $(this).redirectRulesFieldsURL(searchedByFields, $(this).val(),
                        $("#field_department").val(), $("#field_name").val());
            }

            $(this).redirectURL();
        });


        // FIELD "DEPARTMENT"
        $("#field_department").blur(function() {
            // alert("department");

            var searchedByFields = $(this).attr("data-search");

            if ($(this).val() != "") {

                $(this).redirectRulesFieldsURL(searchedByFields, $("#field_id").val(),
                        $(this).val(), $("#field_name").val());
            }

            $(this).redirectURL();
        });


        // FIELD "NAME"
        $("#field_name").blur(function() {
            // alert("name");

            var searchedByFields = $(this).attr("data-search");

            if ($(this).val() != "") {

                $(this).redirectRulesFieldsURL(searchedByFields, $("#field_id").val(),
                        $("#field_department").val(), $(this).val());
            }

            $(this).redirectURL();
        });

        // FUNCTION redirect to default URL
        (function($) {
            $.fn.redirectRulesFieldsURL = function(searchedByFields, value1, value2, value3) {

                var url = "";
                // redirect to specified employee view without SORTING and without 'searchedByFields' was applied
                if ((searchedByFields == "" || searchedByFields == "false") && ("${sortBy}" == "")) {

                    alert("-1-");

                    //  any row item not founded
                    if ("${totalCount}" == 0)
                    {
                        url = "/timesheet/employees/search?id=" + value1 +
                                "&department=" + value2 +
                                "&name=" + value3;
                    }
                    // with page
                    else {
                        url = "/timesheet/employees/search?page=" + "${page}" +
                                "&pageSize=" + $("#page_size").val() +
                                "&id=" + value1 + "&department=" + value2 + "&name=" + value3;
                    }
                }
                // redirect to specified employee view with SORTING and without 'searchedByFields' was applied
                if ((searchedByFields == "" || searchedByFields == "false") && ("${sortBy}" != "")) {

                    alert("-2-");

                    //  any row item not founded
                    if ("${totalCount}" == 0)
                    {
                        url = "/timesheet/employees/search?id=" + value1 +
                                "&department=" + value2 +
                                "&name=" + value3 +
                                "&sortBy=" + "${sortBy}" + "&sortOrder=" + "${order}";
                    }
                    // with page
                    else {
                        url = "/timesheet/employees/search?page=" + "${page}" +
                                "&pageSize=" + $("#page_size").val() +
                                "&id=" + value1 +
                                "&department=" + value2 +
                                "&name=" + value3 +
                                "&sortBy=" + "${sortBy}" + "&sortOrder=" + "${order}";
                    }
                }
                // redirect to specified employee view with SORTING and with 'searchedByFields' was applied
                if ((searchedByFields == "true") && ("${sortBy}" != "")) {

                    alert("-3-");

                    //  any row item not founded 
                    if ("${totalCount}" == 0)
                    {
                        url = "/timesheet/employees/search?id=" + value1 +
                                "&department=" + value2 +
                                "&name=" + value3 +
                                "&sortBy=" + "${sortBy}" + "&sortOrder=" + "${order}";
                    }
                    // with pages
                    else {
                        url = "/timesheet/employees/search?page=" + "${page}" +
                                "&pageSize=" + $("#page_size").val() +
                                "&id=" + value1 +
                                "&department=" + value2 +
                                "&name=" + value3 +
                                "&sortBy=" + "${sortBy}" + "&sortOrder=" + "${order}";
                    }
                }
                // redirect to specified employee view with SORTING and with 'searchedByFields' was applied
                if ((searchedByFields == "true") && ("${sortBy}" == "")) {

                    alert("-4-");

                    //  any row item not founded 
                    if ("${totalCount}" == 0)
                    {
                        url = "/timesheet/employees/search?id=" + value1 +
                                "&department=" + value2 +
                                "&name=" + value3;
                    }
                    // with pages
                    else {
                        url = "/timesheet/employees/search?page=" + "${page}" +
                                "&pageSize=" + $("#page_size").val() +
                                "&id=" + value1 +
                                "&department=" + value2 +
                                "&name=" + value3 ;
                    }
                }

                window.location.href = url;

                return this;
            };
        })(jQuery);

        // FUNCTION redirect to default URL
        (function($) {
            $.fn.redirectURL = function() {

                if ($("#field_id").val() == "" &&
                        $("#field_department").val() == "" &&
                        $("#field_name").val() == "") {

                    // redirect to specified employee view
                    var url = "/timesheet/employees?page=" + "${page}" + "&pageSize=" + $("#page_size").val();

                    window.location.href = url;
                }
                return this;
            };
        })(jQuery);

    });

    // DROPDOWN LIST "PAGE SIZE" 1,2,3 .... 50
    $("#page_size").change(function() {

        // alert($(this).val());

        $("#page_size").redirectSpecialURL("1");
        // redirect to specified employee view
        // var url = "/timesheet/employees?page=" + "1" + "&pageSize=" + pageSize;
        // window.location.href = url;
    });

    // -------------------------------- PAGINATION -----------------------------
    var pageItem = $("#pagesEmployees li").not(".previous,.next").not("#my_header");
    var prev = $("#pagesEmployees li.previous");
    var next = $("#pagesEmployees li.next");

    // PAGES "1","2","3" ...
    pageItem.click(function() {
        pageItem.removeClass("active");
        $(this).not(".previous,.next").addClass("active");

        // alert($("#page_size").val());

        var currentPage = $(this).text().trim();

        // redirect to ITEM PAGE employee view
        pageItem.redirectSpecialURL(currentPage);
    });

    // button "NEXT"
    if (next.prev("li").hasClass("active") == false) {

        next.removeClass('disabled');

        next.click(function() {
            $('#pagesEmployees li.active').removeClass('active').next().addClass('active');

            var nextPageNumber = $("#pagesEmployees li.active").text();

            var nextPage = nextPageNumber.trim();

            next.redirectSpecialURL(nextPage);
        });
    } else {
        next.addClass('disabled');
    }

    // button "PREVIOUS"
    if (prev.next("li").hasClass("active") == false) {

        prev.removeClass('disabled');

        prev.click(function() {
            $('#pagesEmployees li.active').removeClass('active').prev().addClass('active');

            var prevPageNumber = $("#pagesEmployees li.active").text();

            // alert(prevPageNumber);

            var previousPage = prevPageNumber.trim();

            // redirect to PREVIOUS PAGE employee view
            prev.redirectSpecialURL(previousPage);
        });
    }
    else {
        prev.addClass('disabled');
    }

    // FUNCTION redirect to default URL
    (function($) {
        $.fn.redirectSpecialURL = function(currentPage) {

            // redirect to specified employee view without SORTING and without 'searchedByFields'
            if (("${sortBy}" == "") && ("${searchedByFields}" == "" || "${searchedByFields}" == "false")) {
                alert("1");

                var url = "/timesheet/employees?page=" + currentPage + "&pageSize=" + $("#page_size").val();
                window.location.href = url;
            }
            // redirect to specified employee view with SORTING but without 'searchedByFields'
            if (("${sortBy}" == "id" || "${sortBy}" == "department" || "${sortBy}" == "name") &&
                    ("${searchedByFields}" == "" || "${searchedByFields}" == "false")) {
                alert("2");

                var url = '/timesheet/employees?page=' +
                        $("#pagesEmployees li.active").text().trim() +
                        "&pageSize=" + $("#page_size").val() +
                        '&sortBy=' + "${sortBy}" + '&sortOrder=' + "${order}";
                window.location.href = url;
            }
            // redirect to specified employee view with 'searchedByFields' and with SORTING
            if (("${searchedByFields}" == "true") && ("${sortBy}" != "")) {
                alert("3");

                // Any Items not founded
                if ("${totalCount}" == 0)
                {
                    var url = "/timesheet/employees/search?id=" + $("#field_id").val() +
                            "&department=" + $("#field_department").val() +
                            "&name=" + $("#field_name").val() +
                            "&sortBy=" + "${sortBy}" + "&sortOrder=" + "${order}";
                    window.location.href = url;
                }
                else
                {
                    var url = "/timesheet/employees/search?page=" + currentPage +
                            "&pageSize=" + $("#page_size").val() +
                            "&id=" + $("#field_id").val() +
                            "&department=" + $("#field_department").val() +
                            "&name=" + $("#field_name").val() +
                            "&sortBy=" + "${sortBy}" + "&sortOrder=" + "${order}";
                    window.location.href = url;
                }
            }

            // redirect to specified employee view with 'searchedByFields' and without SORTING
            if (("${searchedByFields}" == "true") && ("${sortBy}" == "")) {
                alert("4");

                // Any Items not founded
                if ("${totalCount}" == 0)
                {
                    var url = "/timesheet/employees/search?id=" + $("#field_id").val() +
                            "&department=" + $("#field_department").val() +
                            "&name=" + $("#field_name").val();
                    window.location.href = url;
                }
                else
                {
                    var url = "/timesheet/employees/search?page=" + currentPage +
                            "&pageSize=" + $("#page_size").val() +
                            "&id=" + $("#field_id").val() +
                            "&department=" + $("#field_department").val() +
                            "&name=" + $("#field_name").val();
                    window.location.href = url;
                }
            }

            return this;
        };
    })(jQuery);

    // alert("hello");
</script>

