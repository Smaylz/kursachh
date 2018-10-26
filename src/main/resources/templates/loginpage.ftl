<#import "parts/common.ftl" as C>
<#import "parts/login.ftl" as l>
<#import "/spring.ftl" as spring/>

<@C.page>
<div class="mb-1"><h2><@spring.message "login.page"/></h2></div>
<#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>
    <div class="alert alert-danger" roles="alert">
        ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}
    </div>
</#if>
    <@l.login"/loginpage"false/>
</@C.page>