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
          <ul class="nav nav-pills">
              <#if isUser>
              <li class="nav-item">
                  <div class="m-3">
                      <h5><@spring.message "put.a.rating"/></h5>
                  </div>
              </li>
              <li class="nav-item">
                  <form action="/main/rang" method="post">
                      <input type="hidden" value="${message.id}" name="messageId">
                      <div class="m-3">
                          <button name="rang" value="1" class="fa fa-star btn-rang1 btn-outline-rang1 btn-sm" type="submit">1</button>
                          <button name="rang" value="2" class="fa fa-star btn-rang2 btn-outline-rang2 btn-sm" type="submit">2</button>
                          <button name="rang" value="3" class="fa fa-star btn-rang3 btn-outline-rang3 btn-sm" type="submit">3</button>
                          <button name="rang" value="4" class="fa fa-star btn-rang4 btn-outline-rang4 btn-sm" type="submit">4</button>
                          <button name="rang" value="5" class="fa fa-star btn-rang5 btn-outline-rang5 btn-sm" type="submit">5</button>
                      </div>
                  </form>
              </li>
              </#if>
              <li class="nav-item">
                  <div class="m-3">
                      <h5 ><@spring.message "the.rating"/>: ${message.rang}</h5>
                  </div>
              </li>
          </ul>

          <div class="m-2">
              <i><span>#${message.tag}</span></i>
          </div>
          <div class="card-footer text-muted">
              <a href="/user/profile/${message.author.id}">${message.authorName}</a>
          </div>
      </div>
    <#if isUser>
<div class="row justify-content-end ">
    <form action="/add" method="post"  style="width: 100%">
        <div class="input-group">
            <input type="hidden" value="${message.id}" name="mes_id">
            <input class="form-control input-append" id="disabledInput" name="text" placeholder="<@spring.message "enter.comment"/>"/>
            <span class="input-group-btn">
                <button class="btn btn-primary fa fa-paper-plane" type="submit" style="height: 100%;"><@spring.message "add.comment"/></button>
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
                <a href="/user/profile/${comment.author.id}">${comment.authorName}</a>

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
                </ul>

            </div>
            <div class="m-2">
                ${comment.text}
                 <#if isUser>
                    <div class="container">
                        <div class="row">
                            <a class="col align-self-center"  href="/main/${comment.id}/like">
                                <#assign l=false>
                                <#list likeComments as like>
                                    <#if like.comment_id == comment.id && like.author.id == currentUserId>
                                        <#assign l = true>
                                        <#break >
                                    </#if>
                                </#list>
                                <#if l>
                                <i class="fa fa-heart" style="color:red;"></i>
                                <#else >
                                <i class="fa fa-heart-o" style="color:red;"></i>
                                </#if>
                                ${comment.likec}
                            </a>
                        </div>
                    </div>
                 </#if>
            </div>
        </div>
    </div>
        <div class="collapse row justify-content-end " id="collapseComment${comment.id}">
            <form action="/main/comment/update" method="post" style="width: 90%;">
                <div class="input-group">
                    <input type="hidden" value="${comment.id}" name="id">
                    <input class="form-control" id="disabledInput" name="text" placeholder="<@spring.message "enter.comment"/>">
                    <span class="input-group-btn">
                        <button class="btn btn-primary" type="submit"><@spring.message "update.comment"/></button>
                    </span>
                </div>
            </form>
        </div>
        </#if>
    </#list>
<#else>
    <@spring.message "no.message"/>
</#list>
<@p.pager url page />