<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">
<@c.page>

<div class="form-row">
    <div class="form-group col-md-6">
        <form method="get" action="/main" class="form-inline">
            <input type="text" name="filter" class="form-control" value="${filter?ifExists}"
                   placeholder="Search by tag">
            <button type="submit" class="btn btn-primary ml-2">Search</button>
        </form>
    </div>
</div>
    <#if isUser>
        <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample"
            aria-expanded="false" aria-controls="collapseExample">
            Message Add
        </button>
    </#if>
<#include "parts/messageEdit.ftl" />
<#include "parts/messageList.ftl" />
</@c.page>