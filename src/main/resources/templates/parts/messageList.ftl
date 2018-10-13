<#include "security.ftl">
<#import "pager.ftl" as p>
<@p.pager url page />
<#list page.content as message>
      <div class="card my-3 row justify-content-end ">
          <div  class="m-2">
                <ul class="nav nav-pills" style="float: right;" >
 <#if isAdmin || message.author.id == currentUserId>
                    <li class="nav-item">
                        <a class="fa fa-cog btn btn-outline-primary btn-sm"
                           href="/user/profile/${message.author.id}?message=${message.id}">
                        </a>
                    </li>
                    <li class="nav-item">
                        <form action="/main/delete" method="post">
                            <input type="hidden" value="${message.id}" name="messageId">
                            <button class="fa fa-close btn btn-outline-danger btn-sm" type="submit"></button>
                        </form>
                    </li>
             </#if>
                    <li class="nav-item">
                        <form action="/main/rang" method="post">
                            <input type="hidden" value="${message.id}" name="messageId">
                            <input type="range" min="1" max="5" step="1"  name="rang">
                            <button class="fa fa-close btn btn-outline-danger btn-sm" type="submit">

                            </button>
                        </form>
                    </li>
                </ul>
            <center>
                <h2>${message.name}</h2>
            </center>
                ${message.text}
          </div>
<div>
    <#if message.filename??>
         <center><img src="/img/${message.filename}" style="max-width: 100%;" ></center>
    </#if>
</div>
          <div class="m-2">
              <i><span>#${message.tag}</span></i>
          </div>
          <div class="card-footer text-muted">
              <a href="/profile/${message.author.id}">${message.authorName}</a>
          </div>
      </div>
<#if isUser>
<div class="row justify-content-end ">
    <form action="/add" method="post"  style="width: 100%">
        <div class="input-group">
            <input type="hidden" value="${message.id}" name="mes_id">
            <input class="form-control input-append" id="disabledInput" name="text" placeholder="Enter Comment">
            <span class="input-group-btn">
                <button class="btn btn-primary fa fa-paper-plane" type="submit" style="height: 100%;"> Add comment</button>
            </span>
        </div>
    </form>
</div>
</#if>
    <#list comments as comment>
        <#if message.id == comment.mes_id>
    <div class="row justify-content-end">
        <div class="card my-1" style="width: 90%;">
            <div class="m-2">
                <a href="/profile/${comment.author.id}">${comment.authorName}</a>

                <ul class="nav nav-pills" style="float: right;">
                    <#if isAdmin || comment.author.id == currentUserId>
                    <li class="nav-item">
                        <button class="fa fa-cog btn btn-outline-primary btn-sm" type="button" data-toggle="collapse" data-target="#collapseComment${comment.id}"
                                aria-expanded="false" aria-controls="collapseExample">
                        </button>
                    </li>
                    <li class="nav-item">
                        <form action="/main/comment/delete" method="post">
                            <input type="hidden" value="${comment.id}" name="commentId">
                            <button class="fa fa-close btn btn-outline-danger btn-sm" type="submit"></button>
                        </form>
                    </li>
                    </#if>
                    <#if isUser>
                    <li class="nav-item">
                        <form action="/main/like" method="post">
                            <input type="hidden" value="${comment.id}" name="commentId">
                            <button class="fa fa-heart-o btn btn-outline-danger btn-sm" type="submit"></button>
                        </form>
                    </li>
                    </#if>
                </ul>

            </div>
            <div class="m-2">
                ${comment.text}
            </div>
        </div>
    </div>
        <div class="collapse row justify-content-end " id="collapseComment${comment.id}">
            <form action="/main/comment/update" method="post" style="width: 90%;">
                <div class="input-group">
                    <input type="hidden" value="${comment.id}" name="id">
                    <input class="form-control" id="disabledInput" name="text" placeholder="Enter Comment">
                    <span class="input-group-btn">
                        <button class="btn btn-primary" type="submit">Update comment</button>
                    </span>
                </div>
            </form>
        </div>
        </#if>
    </#list>
<#else>
    No message
</#list>
<@p.pager url page />