<#import "parts/common.ftl" as C>
<#include "parts/security.ftl">
<@C.page>
    <#if isUser>
       <h2>Hello,${name}</h2>
    <#else >
       <h2>Hello, guest</h2>
    </#if>
</@C.page>