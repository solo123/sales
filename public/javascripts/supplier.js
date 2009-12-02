// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function DeleteData() { //定义删除函数
      $('#data-list a.delete').bind('click', function() {//将delete链接与click绑定
          if ( !confirm("确认要删除吗？")){
              return false;
          }
        var deleteLink = $(this)  //将这个链接的dom赋值给deleteLink变量
        $.ajax({       //Ajax函数
          type: 'get',   //定义http方法 (chrome不支持delete）
          url: deleteLink.attr('href'),    //请求的URL
          success: function(){deleteLink.parent().parent().parent().remove()}, //请求成功之后的动作
            error: displayError
        })
        return false//阻止普通的提交方式和页面导航

      })
    }

function CreateData() {//添加product函数
  $('#new-data').submit(function() {//点击submit的函数
    $(this).ajaxSubmit({//点击submit发起ajax请求
      target: '#data-list',  //目标是对id=product0list的dom进行局部更新
      clearForm: true,
      success: DeleteData,
      error: displayError//发生错误,譬如validate?为false时
    })
    return false
  })
}

function displayError(request, errorType) {
  var msg = '<div class="error">'+request.responseText+'(click to close)</div>'
  $('#data-list').append(msg)
  $('.error').click(function(){$(this).hide()})
}

$(function() {
  DeleteData();
  CreateData();
});