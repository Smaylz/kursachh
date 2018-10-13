<#import "parts/common.ftl" as C>
<#include "parts/security.ftl">
<@C.page>

<#if !isSocUser>
<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapsePassword"
        aria-expanded="false" aria-controls="collapsePassword">
   Password Edit
</button>

<div class="collapse" id="collapsePassword">
<form method="post">
    <div class="form-group">
        <label for="exampleInputEmail1"> Password: </label>
        <input type="password" name="password"  class="form-control col-sm-4"  placeholder="Enter password"/>
    </div>
    <button type="submit" class="btn btn-primary">Save</button>
</form>
            </div>
</#if>
    <#if isCurrentUser>
        <#include "parts/messageEdit.ftl" />
    </#if>
    <#include "parts/messageList.ftl" />
</@C.page>