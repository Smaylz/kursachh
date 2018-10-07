<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page >
<div class="mb-1"><h2>Add new user</h2></div>
    ${message?ifExists}
    <@l.login "/registration" true />
</@c.page>