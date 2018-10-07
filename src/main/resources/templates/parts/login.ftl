<#macro login path isRegisterForm>
<form action="${path}" method="post" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <#if !isRegisterForm>
    <h6>login with:</h6>
    <ul class="social-icons"  >
        <li style="list-style: none;">
            <a href="/login" style="width: 80px;
                                    height: 80px;
                                    line-height: 80px;
                                    font-size: 25px;
                                    color: red;">
                <i class="fa fa-google" aria-hidden="true" > Google</i>
            </a>
        </li>
    </ul>
    <h6>Or</h6>
    </#if>
        <div class="form-group">
        <label for="exampleInputEmail1"> User Name : </label>
        <input type="text" name="username" value="<#if user??>${user.username}</#if>"
               class="form-control col-sm-4 ${(usernameError??)?string('is-invalid','')}" placeholder="Enter login"/>
          <#if usernameError??>
                    <div class="invalid-feedback">
                        ${usernameError}
                    </div>
          </#if>
    </div>
    <div class="form-group">
        <label for="exampleInputEmail1"> Password: </label>
        <input type="password" name="password"
               class="form-control col-sm-4 ${(passwordError??)?string('is-invalid','')}" placeholder="Enter password"/>
          <#if passwordError??>
                    <div class="invalid-feedback">
                        ${passwordError}
                    </div>
          </#if>
    </div>
    <#if isRegisterForm>
    <div class="form-group">
        <label for="exampleInputEmail1"> Password: </label>
        <input type="password" name="password2"
               class="form-control col-sm-4 ${(password2Error??)?string('is-invalid','')}"
               placeholder="Retype password"/>
          <#if password2Error??>
                    <div class="invalid-feedback">
                        ${password2Error}
                    </div>
          </#if>
    </div>
    </#if>
    <#if !isRegisterForm><a href="/registration">Add new user</a></#if>
    <div>
    <button type="submit" class="btn btn-primary"><#if isRegisterForm>Create<#else > Sign In</#if></div>
</form>

</#macro>

<#macro logout>
<form action="/logout" method="post">
    <div>
        <button class="btn btn-primary" type="submit">Sign Out</button>
    </div>
</form>
</#macro>
<#macro logun>
<form action="/loginpage" method="get">
    <div>
        <button class="btn btn-primary" type="submit">Log in</button>
    </div>
</form>
</#macro>