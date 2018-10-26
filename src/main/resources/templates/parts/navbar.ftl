<#include "security.ftl">
<#import "login.ftl" as l>
<#import "/spring.ftl" as spring/>
<nav class="navbar navbar-expand-lg navbar-dark bg-success text-white">
    <a class="navbar-brand" href="/">Kursach</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse"
            data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
            aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/main"> <@spring.message "messages"/></a>
            </li>
            <#if isAdmin>
            <li class="nav-item">
                <a class="nav-link" href="/user"><@spring.message "user.list"/></a>
            </li>
            </#if>
             <#if isUser>
            <li class="nav-item">
                <a class="nav-link" href="/user/profile/${currentUserId}"><@spring.message "profile"/></a>
            </li>
             </#if>
        </ul>
        <center><div>
            <a href="?lang=en"><img src="../../static/image/united_states_flags_flag_17080.png"  id="language"/></a>
            <a href="?lang=ru"><img src="../../static/image/russia_flags_flag_17058.png"  id="language"/></a>
            <a href="?lang=bl"><img src="../../static/image/belarus_flags_flag_16975.png" id="language"/></a>
        </div></center>
        <div class="navbar-text mr-3">
            <div class="input-group">
                <form method="get" action="/main" class="form-inline">
                    <input type="text" name="filter" class="form-control input-append" id="disabledInput" style="opacity: 0.5;" value="${filter?ifExists}"
                           placeholder="<@spring.message"search.by.text"/>"/>
                </form>
            </div>
        </div>
        <div class="navbar-text mr-3">${name}</div>
        <#if isUser>
            <@l.logout/>
        <#else>
            <@l.logun/>
        </#if>

    </div>
</nav>