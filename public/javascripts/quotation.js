// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
 function BindDeleteProduct() { //定义删除函数
    $('#quotation-list a.delete').bind('click', function() {//将delete链接与click绑定
        if ( !confirm("确认要删除吗？")){
            return false;
        }
        var deleteLink = $(this)  //将这个链接的dom赋值给deleteLink变量
        $.ajax({       //Ajax函数
            type: 'delete',   //定义http方法
            url: deleteLink.attr('href'),    //请求的URL
            success: function(){
                deleteLink.parent().parent().parent().remove()
                }, //请求成功之后的动作
            error: displayError
        })
        return false//阻止普通的提交方式和页面导航

    })
    $(".error_brand").click(add_new_brand);
}
function after_create(){
    $("#quotation_quotation_price").val("");
    $("#quotation_model_short_name").val("");
    $("#quotation_model_short_name").focus();
    BindDeleteProduct();
}
function BindCreateProduct() {//添加product函数

    $('#new-brand').ajaxForm(function(){
        sn = $('#brand_short_name').val();
        nn = $('#brand_brand_name').val();
        $('.error_brand').each(function(){
            ff = $(this);
            if (ff.text()==sn){
                ff.text(nn);
                ff.removeClass("error_brand error_input_text");
            }
        })
        $('#dialog').dialog("close");
    });
}

function displayError(request, errorType) {
    var msg = '<div class="error">'+request.responseText+'(click to close)</div>'
    $('#quotation-list').append(msg)
    $('.error').click(function(){
        $(this).hide()
        })
}

function edit_quotation(qid){
    $('#dialog_edit').dialog('open');
    $('#dialog_edit iframe').attr('src', "/quotations/"+ qid +"/edit");
}

function add_new_brand(){
    $('#brand_short_name').val($(this).text());
    $('#brand_brand_name').val($(this).text());
    $('#dialog').dialog('open');
    $('#brand_brand_name').focus();
    return false;
}

function add_new_mobile(brand, model, remark, price){
    var jsonStr="({";
    jsonStr+="\"brand_id\":";
    jsonStr+="\""+ brand +"\"";
    jsonStr+=",";
    jsonStr+="\"model\":";
    jsonStr+="\""+ model +"\"";
    jsonStr+=",";
    jsonStr+="\"remark\":";
    jsonStr+="\""+ remark +"\"";
    jsonStr+=",";
    jsonStr+="\"price\":";
    jsonStr+="\""+ price +"\"";
    jsonStr+="})";
    var para = eval(jsonStr);//关键在于转换。

    $.ajax({
        url: '/mobiles/add',
        type: 'POST',
        dataType: 'json',
        timeout: 20000,//超时时间设定
        data: para,//参数设置
        error: function(){
            alert('添加新手机出错！');
        },
        success: function(mobile){
            if(mobile){
                refresh_list();
            }else
                alert('添加新手机出错。 msg=[' + mobile + ']');
        }
    });
}

function submit_quotation(){
    $.get("/quotations/submit_quotation/0", function(data){
        $("#quotation-list").html(data);
    })
}

function refresh_list(){
    $('#quotation-list').load('/quotations/list/0', function(){
        BindDeleteProduct();
    });
}

$(function() {
    BindDeleteProduct();

    jQuery.validator.messages.required = "<span class='error_star'>*</span>";
    $("#new-quotation").validate({
        submitHandler: function(form){
            $(form).ajaxSubmit({
                target: '#quotation-list',  //目标是对id=product0list的dom进行局部更新
                clearForm: false,
                success: after_create,
                error: displayError//发生错误,譬如validate?为false时
            });
        },
        rules: {
            'quotation[quotation_date]':{required:true},
            'quotation[supplier_id]':{required:true,min:1},
            'quotation[brand_short_name]':{required:true},
            'quotation[model_short_name]':{required:true},
            'quotation[quotation_price]':{required:true,min:0.01}
        }
    });
    $(".error_brand").click(add_new_brand);

    // Dialog
    $('#dialog').dialog({
        autoOpen: false,
        width: 600,
        buttons: {
            "关闭": function() {
                $(this).dialog("close");
            }
        }
    });

    // Dialog
    $('#dialog_edit').dialog({
        autoOpen: false,
        width: 340,
        height: 420,
        buttons: {
            "关闭": function() {
                $(this).dialog("close");
            }
        }
    });

    $('#new-brand').ajaxForm(function(msg) {
        if (msg=="success") {
            refresh_list();
            $('#dialog').dialog('close');
        } else
            alert(msg);
    });
    SetupAjaxIndicator();

});