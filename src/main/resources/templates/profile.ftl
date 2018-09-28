<#import "parts/common.ftl" as C>
<@C.page>
<h5>${username}</h5>
<form method="post">
    <div class="form-group">
        <label for="exampleInputEmail1"> Password: </label>
        <input type="password" name="password"  class="form-control col-sm-4"  placeholder="Enter password"/>
    </div>
    <button type="submit" class="btn btn-primary">Save</button>
</form>
</@C.page>