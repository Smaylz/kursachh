<#include "security.ftl">
<#list messages as message>
        <div class="card my-3">
            <div class="m-2">
                <h2>${message.text}</h2><br>
                <i><span>#${message.tag}</span></i>
            </div>
            <div class="card-footer text-muted">
                <a href="/user-message/${message.author.id}">${message.authorName}</a>
            </div>
            <#if isAdmin || message.author.id == currentUserId>
                <ul class="nav nav-pills">
                    <li class="nav-item">
                    <a class="btn btn-outline-primary btn-sm"
                       href="/user-message/${message.author.id}?message=${message.id}">
                        Edit
                    </a>
                    </li>
                    <li class="nav-item">
                    <form action="/main/delete" method="post">
                        <input type="hidden" value="${message.id}" name="messageId">
                        <button class="btn btn-outline-danger btn-sm" type="submit">Delete</button>
                    </form>
                    </li>
                </ul>
            </#if>
        </div>
<#else>
    No message
</#list>