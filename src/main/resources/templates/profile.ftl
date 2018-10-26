<#import "parts/common.ftl" as C>
<#include "parts/security.ftl">
<#import "/spring.ftl" as spring/>
<@C.page>

<#if !isSocUser>
<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapsePassword"
        aria-expanded="false" aria-controls="collapsePassword">
    <@spring.message "password.edit"/>
</button>

<div class="collapse" id="collapsePassword">
<form method="post">
    <div class="form-group">
        <label for="exampleInputEmail1"> <@spring.message "password"/>: </label>
        <input type="password" name="password"  class="form-control col-sm-4"  placeholder="<@spring.message "enter.password"/>"/>
    </div>
    <button type="submit" class="btn btn-primary"><@spring.message "save"/></button>
</form>
            </div>
</#if>
    <#if isCurrentUser>
        <#include "parts/messageEdit.ftl" />
<div class="m-3">
<form action="/user/profile/${currentUserId}" method="get">
    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <@spring.message "sorting"/>
    </a>
    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
        <button class="btn btn-link dropdown-item" value="text.asc" name="sort" type="submit"><@spring.message "text.asc" /></button>
        <button class="btn btn-link dropdown-item" value="text.desc" name="sort" type="submit"><@spring.message "text.desc" /></button>
        <button class="btn btn-link dropdown-item" value="tag.asc" name="sort" type="submit"><@spring.message "tag.asc" /></button>
        <button class="btn btn-link dropdown-item" value="tag.desc" name="sort" type="submit"><@spring.message "tag.desc" /></button>
        <button class="btn btn-link dropdown-item" value="rang.asc" name="sort" type="submit"><@spring.message "rang.asc" /></button>
        <button class="btn btn-link dropdown-item" value="rang.desc" name="sort" type="submit"><@spring.message "rang.desc" /></button>
    </div>

</form>
</div>
    </#if>
        <#include "parts/messageList.ftl" />
</@C.page>