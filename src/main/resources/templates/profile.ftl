<#import "parts/common.ftl" as C>
<#include "parts/security.ftl">
<@C.page>
<h5>${username}</h5>
<#if !isSocUser>
<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample"
        aria-expanded="false" aria-controls="collapseExample">
   Password Edit
</button>

<div class="collapse <#if message??>show</#if>" id="collapseExample">
<form method="post">
    <div class="form-group">
        <label for="exampleInputEmail1"> Password: </label>
        <input type="password" name="password"  class="form-control col-sm-4"  placeholder="Enter password"/>
    </div>
    <button type="submit" class="btn btn-primary">Save</button>
</form>
            </div>
</#if>
</@C.page>