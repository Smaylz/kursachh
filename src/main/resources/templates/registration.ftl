<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>
<#import "/spring.ftl" as spring/>

<@c.page >
<div class="mb-1"><h2><@spring.message "add.new.user"/></h2></div>
    ${message?ifExists}
    <@l.login "/registration" true />
</@c.page>