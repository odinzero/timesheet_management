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
</style>

<h1> Signup </h1>

<p>Please fill out the following fields to signup:</p>

<div class="row">
    <div class="col-lg-5">
        <form:form method = "POST" action = "/timesheet/site/signup" commandName = "userCreate" >
            <form:errors path = "*" cssClass = "errorblock" element = "div" />

            <div class="form-group">
                <form:label path =  "username" cssClass="control-label">Username</form:label>
                <form:input path =  "username" id="create_username" cssClass="form-control" maxlength="64" />   
                <form:errors path = "username" cssClass = "help-block" />
            </div>

            <div class="form-group">
                <form:label path = "email" cssClass="control-label">Email</form:label>
                <form:input path = "email" id="create_email" cssClass="form-control" maxlength="64" />
                <form:errors path = "email" cssClass = "help-block" />
            </div>

            <div class="form-group">
                <form:label path = "password" cssClass="control-label">Password</form:label>
                <form:input path = "password" id="create_password" cssClass="form-control" maxlength="64" />
                <form:errors path = "password" cssClass = "help-block" />
            </div>

            <div class="form-group"> 
                <input type = "submit" class="btn btn-primary" value = "Signup"/>
            </div>

        </form:form>
    </div>
</div>

<!-- when button "Create" has been already clicked add and remove classes for error and right filled fields  -->
<c:if test='${try_signup == "signup" }'>
    <script>

        var d = $("#create_username");
        if (d.val().length <= 0) {
            d.closest('.form-group').addClass("has-error");
            d.closest('.form-group').removeClass("has-success");
        } else {
            d.closest('.form-group').removeClass("has-error");
            d.closest('.form-group').addClass("has-success");
        }

        var n = $("#create_email");
        if (n.val().length <= 0) {
            n.closest('.form-group').addClass("has-error");
            n.closest('.form-group').removeClass("has-success");
        } else {
            n.closest('.form-group').removeClass("has-error");
            n.closest('.form-group').addClass("has-success");
        }

        var pwd = $("#create_password");
        if (pwd.val().length <= 0) {
            pwd.closest('.form-group').addClass("has-error");
            pwd.closest('.form-group').removeClass("has-success");
        } else {
            pwd.closest('.form-group').removeClass("has-error");
            pwd.closest('.form-group').addClass("has-success");
        }
    </script>
</c:if>      
