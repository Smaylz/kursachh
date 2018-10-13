
<div class="collapse <#if message??>show</#if>" id="collapseExample">
    <div class="form-group mt-3">
        <form method="post" enctype="multipart/form-data">
            <div class="form-group">
                <div class="form-group">
                    <input type="text" class="form-control ${(nameError??)?string('is-invalid','')}"
                           value="<#if message??>${message.name}</#if>" name="name" placeholder="Enter name"/>
                <#if textError??>
                    <div class="invalid-feedback">
                        ${nameError}
                    </div>
                </#if>
                </div>
                <input type="text" class="form-control ${(textError??)?string('is-invalid','')}"
                       value="<#if message??>${message.text}</#if>" name="text" placeholder="Enter message"/>
                <#if textError??>
                    <div class="invalid-feedback">
                        ${textError}
                    </div>
                </#if>
            </div>
            <div class="form-group">
                <input type="text" class="form-control ${(tagError??)?string('is-invalid','')}" name="tag"
                       value="<#if message??>${message.tag}</#if>" placeholder="Tag">
                <#if tagError??>
                    <div class="invalid-feedback">
                        ${tagError}
                    </div>
                </#if>
            </div>
            <div class="form-group">
                <input type="file" class="form-control" name="file">
            </div>
            <input type="hidden" name="id" value="<#if message??>${message.id}</#if>"/>
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Save</button>
            </div>
        </form>
    </div>
</div>