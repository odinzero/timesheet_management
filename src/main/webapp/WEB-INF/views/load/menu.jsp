<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <script type="text/javascript" src="<spring:url value="/resources/js/jquery-3.4.1.js"/>"></script>
        <title>JSP Page</title>
    </head>
    <body>
        
        <h3>Table:</h3>
        <hr>

        <button id="loadtables" >Load tables</button>
        <span id="result1"></span>
        <br><br>

        <button id="removetables" >Remove tables</button>
        <span id="result2"></span>
        <br>
        <br>
        
        <h3>Table Data:</h3>
        <hr>

        <button id="loadtablesdata" >Load tables data</button>
        <span id="result3"></span>
        <br><br>

        <button id="removetablesdata" >Remove tables data</button>
        <span id="result4"></span>
        <br>
        
        <script>
            
            // BUTTON 'Load tables' 
            $(document).on('click', '#loadtables', function() {

               // alert("1");
               
                $('#result1').empty();

                $.post("http://localhost:8083/timesheet/loadschema/createtables", {
                }, function(data) {
                     alert(data);
                })
                        .done(function(data) {
                            $('#result1').append(data);
                        })
                        .fail(function(xhr, textStatus, errorThrown) {
                            alert("fail:" + xhr.toString() + "  " + textStatus + "  " + errorThrown);
                        });
            });
            
            
            // BUTTON 'Remove tables' 
            $(document).on('click', '#removetables', function() {

               // alert("1");
               
                $('#result2').empty();

                $.post("http://localhost:8083/timesheet/loadschema/removetables", {
                }, function(data) {
                     alert(data);
                })
                        .done(function(data) {
                            $('#result2').append(data);
                        })
                        .fail(function(xhr, textStatus, errorThrown) {
                            alert("fail:" + xhr.toString() + "  " + textStatus + "  " + errorThrown);
                        });
            });
            
            
            // BUTTON 'Load tables data' 
            $(document).on('click', '#loadtablesdata', function() {

               // alert("1");
               
                $('#result3').empty();

                $.post("http://localhost:8083/timesheet/loadschema/loadtablesdata", {
                }, function(data) {
                     alert(data);
                })
                        .done(function(data) {
                            $('#result3').append(data);
                        })
                        .fail(function(xhr, textStatus, errorThrown) {
                            alert("fail:" + xhr.toString() + "  " + textStatus + "  " + errorThrown);
                        });
            });

            // BUTTON 'Remove tables data' 
            $(document).on('click', '#removetablesdata', function() {

                //alert("2");
                $('#result4').empty();
                
                 $.post("http://localhost:8083/timesheet/loadschema/removetablesdata", {
                }, function(data) {
                    // alert(data);
                })
                        .done(function(data) {
                            $('#result4').append(data);
                        })
                        .fail(function(xhr, textStatus, errorThrown) {
                            alert("fail:" + xhr.toString() + "  " + textStatus + "  " + errorThrown);
                        });
            });
        </script>
    </body>
</html>
