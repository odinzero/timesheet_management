<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .error {
        color: #ff0000;
    }

    .errorblock {
        color: #000;
        background-color: #ffEEEE;
        border: 3px solid #ff0000;
        padding: 8px;
        margin: 16px;
    }
    .radio label, .checkbox label {
        min-height: 20px;
        padding-left: 20px;
        margin-bottom: 0;
        font-weight: 400;
        cursor: pointer;
    }
</style>

<h1> Login </h1>

<p>Please fill out the following fields to login:</p>

<div class="row">
    <div class="col-lg-5">
        <form:form method = "POST" action = "/timesheet/site/login" commandName = "userLogin" >
            <form:errors path = "*" cssClass = "errorblock" element = "div" />

            <div class="form-group">
                <form:label path =  "username" cssClass="control-label">Username</form:label>
                <form:input path =  "username" id="login_username" cssClass="form-control" maxlength="64" />   
                <form:errors path = "username" cssClass = "help-block" />
            </div>

            <div class="form-group">
                <form:label path = "password" cssClass="control-label">Password</form:label>
                <form:input path = "password" id="login_password" cssClass="form-control" maxlength="64" />
                <form:errors path = "password" cssClass = "help-block" />
            </div>

            <div class="checkbox">
                <form:label path = "remenberMe" cssClass="control-label">
                    <form:checkbox path = "remenberMe" id="completed"  value=""/>
                    Remenber Me
                </form:label>
            </div>

            <p>If you forgot your password you can 
                <a href="http://localhost:8083/timesheet/site/">reset it.</a>
            </p>

            <div class="form-group"> 
                <input type = "submit" class="btn btn-primary" value = "Login"/>
            </div>

        </form:form>
    </div>
</div>

<!-- when button "Login" has been already clicked add and remove classes for error and right filled fields  -->
<c:if test='${try_login == "login" }'>
    <script>

        var d = $("#login_username");
        if (d.val().length <= 0) {
            d.closest('.form-group').addClass("has-error");
            d.closest('.form-group').removeClass("has-success");
        } else {
            d.closest('.form-group').removeClass("has-error");
            d.closest('.form-group').addClass("has-success");
        }

        var pwd = $("#login_password");
        if (pwd.val().length <= 0) {
            pwd.closest('.form-group').addClass("has-error");
            pwd.closest('.form-group').removeClass("has-success");
        } else {
            pwd.closest('.form-group').removeClass("has-error");
            pwd.closest('.form-group').addClass("has-success");
        }
    </script>
</c:if>      
