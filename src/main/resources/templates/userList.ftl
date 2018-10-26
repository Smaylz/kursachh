<#import "parts/common.ftl" as C>
<#import "parts/login.ftl" as l>
<#import "/spring.ftl" as spring/>

<@C.page>
<div class="mb-4"><h2><@spring.message "list.of.user"/></h2></div>

<table class="table">
    <thead class="thead-dark">
    <tr>
        <th scope="col"><@spring.message "select"/></th>
        <th scope="col"><@spring.message "name"/></th>
        <th scope="col"><@spring.message "role"/></th>
        <th scope="col"><@spring.message "date.of.registration"/></th>
        <th scope="col"><@spring.message "active"/></th>
        <th scope="col"></th>
        <th scope="col"></th>
    </tr>
    </thead>
    <body>
<#list users as user>
<tr>
    <td>
        <form action="/user/block/${user.id}" method="post">
            <button class="btn btn-primary" type="submit"><#if user.active == false><@spring.message "unblock"/><#else><@spring.message "block"/></#if></button>
        </form>
    </td>
    <td scope="row">${user.username}</td>
    <td><#list user.roles as role>${role}<#sep>, </#list> </td>
    <td scope="row">${user.dateOfRegistration?ifExists}</td>
    <td>${user.active?string}</td>
    <td>
        <form action="user/${user.id}" method="get">
            <button class="btn btn-primary" type="submit"><@spring.message "edit"/></button>
        </form>
    </td>
    <td>
        <form action="/user/delete/${user.id}" method="post">
            <button class="btn btn-primary" type="submit"><@spring.message "delete"/></button>
        </form>
    </td>
</tr>
</#list>
    </body>
</table>
</@C.page>