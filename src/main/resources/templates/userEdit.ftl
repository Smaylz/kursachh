<#import "parts/common.ftl" as C>
<#import "/spring.ftl" as spring/>

<@C.page>
<div class="mb-1"><h2><@spring.message "user.editor"/></h2></div>

<form action="/user/save" method="post">
    <div class="form-group">
        <label for="exampleInputEmail1"> <@spring.message "username"/> : </label>
        <input type="text"  name="username" value="${user.username}" type="email" class="form-control col-sm-4" id="exampleInputEmail1" aria-describedby="emailHelp"/>
    </div>
    <#list roles as role>
    <div class="custom-control custom-checkbox"><#import "parts/common.ftl" as c>
        <label><input type="checkbox" class="form-check-input" id="exampleCheck1" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>${role}</label>
    </div>
    </#list>
    <input type="hidden" value="${user.id}" name="userId">
    <button class="btn btn-primary" type="submit"><@spring.message "save"/></button>
</form>
</@C.page>