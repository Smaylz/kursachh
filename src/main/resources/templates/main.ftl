<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">
<#import "/spring.ftl" as spring/>
<@c.page>

    <#if isUser>
        <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample"
            aria-expanded="false" aria-controls="collapseExample">
        <@spring.message "message.add"/>
        </button>
    </#if>
<#include "parts/messageEdit.ftl" />
<#include "parts/messageList.ftl" />
</@c.page>