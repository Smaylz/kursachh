<#import "/spring.ftl" as spring/>
<#macro login path isRegisterForm>

<form action="${path}" method="post" >

    <#if !isRegisterForm>
    <h6><@spring.message "login.with"/>:</h6>
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
    <h6><@spring.message "or"/></h6>
    </#if>
    <#if isRegisterForm>
    <div class="form-group">
        <label for="exampleInputEmail1"> Email: </label>
        <input type="email" name="email"
               class="form-control col-sm-4 ${(passwordError??)?string('is-invalid','')}" placeholder="<@spring.message "enter.email"/>"/>
          <#if passwordError??>
                    <div class="invalid-feedback">
                        ${passwordError}
                    </div>
          </#if>
    </div>
    </#if>
        <div class="form-group">
        <label for="exampleInputEmail1"><@spring.message "username"/> : </label>
        <input type="text" name="username" value="<#if user??>${user.username}</#if>"
               class="form-control col-sm-4 ${(usernameError??)?string('is-invalid','')}" placeholder="<@spring.message "enter.login"/>"/>
          <#if usernameError??>
                    <div class="invalid-feedback">
                        ${usernameError}
                    </div>
          </#if>
    </div>
    <div class="form-group">
        <label for="exampleInputEmail1"><@spring.message "password"/> : </label>
        <input type="password" name="password"
               class="form-control col-sm-4 ${(passwordError??)?string('is-invalid','')}" placeholder="<@spring.message "enter.password"/>"/>
          <#if passwordError??>
                    <div class="invalid-feedback">
                        ${passwordError}
                    </div>
          </#if>
    </div>
    <#if isRegisterForm>
    <div class="form-group">
        <label for="exampleInputEmail1"><@spring.message "password"/> : </label>
        <input type="password" name="password2"
               class="form-control col-sm-4 ${(password2Error??)?string('is-invalid','')}"
               placeholder="<@spring.message "retype.password"/>"/>
          <#if password2Error??>
                    <div class="invalid-feedback">
                        ${password2Error}
                    </div>
          </#if>
    </div>
    </#if>
    <#if !isRegisterForm><a href="/registration"><@spring.message "add.new.user"/></a></#if>
    <div>
    <button type="submit" class="btn btn-primary"><#if isRegisterForm><@spring.message "create"/><#else > <@spring.message "sign.in"/></#if></div>
</form>

</#macro>

<#macro logout>
<form action="/logout" method="post">
    <div>
        <button class="btn btn-primary" type="submit"><@spring.message "sign.out"/></button>
    </div>
</form>
</#macro>
<#macro logun>
<form action="/loginpage" method="get">
    <div>
        <button class="btn btn-primary" type="submit"><@spring.message "sign.in"/></button>
    </div>
</form>
</#macro>