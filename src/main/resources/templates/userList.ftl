<#import "parts/common.ftl" as C>
<#import "parts/login.ftl" as l>

<@C.page>
<div class="mb-4"><h2>List of user</h2></div>

<table class="table">
    <thead class="thead-dark">
    <tr>
        <th scope="col">Name</th>
        <th scope="col">Role</th>
        <th scope="col"></th>
        <th scope="col"></th>
    </tr>
    </thead>
    <body>
<#list users as user>
<tr>
    <td scope="row">${user.username}</td>
    <td><#list user.roles as role>${role}<#sep>, </#list> </td>
    <td>
        <form action="user/${user.id}" method="get">
            <button class="btn btn-primary" type="submit">Edit</button>
        </form>
    </td>
    <td>
        <form action="/user/delete" method="post">
        <input type="hidden" value="${user.id}" name="userId">
        <button class="btn btn-primary" type="submit">Delete</button>
    </form>
    </td>
</tr>
</#list>
    </body>
</table>
</@C.page>