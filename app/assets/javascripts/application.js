// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require jquery.ui.datepicker-zh-CN
//= require turbolinks
//- require bootstrap
//- require placeholder.min
//= require china_city/jquery.china_city
//= require jquery.customSelect
//= require jcarousellite
//= require site
//= require_tree .

window.setTimeout(function() {
  $("div.alert").fadeTo(500, 0).slideUp(500, function() {
    $(this).remove();
  });
}, 2000);

/*
function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".elevator-entry").hide();
//$(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
}
*/
