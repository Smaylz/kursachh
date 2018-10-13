<#import "parts/common.ftl" as c>

<@c.page>
suka
<#if isCurrentUser>
    <#include "parts/messageEdit.ftl" />
</#if>
    <#include "parts/messageList.ftl" />
</@c.page>