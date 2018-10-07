<#assign
know = Session.SPRING_SECURITY_CONTEXT??
>

<#if know>
    <#assign
        user = Session.SPRING_SECURITY_CONTEXT.authentication.principal
        name= user.getUsername()
        isAdmin = user.isAdmin()
        isUser = user.isUser()
        isSocUser = user.isSocUser()
        currentUserId = user.getId()


    >
    <#else>
    <#assign
        name = "unknown"
        isAdmin = false
        isUser = false
        isSocUser = false
        currentUserId = -1
    >
</#if>