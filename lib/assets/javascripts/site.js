$(document).ready(function(){
    $(".indexTopBotMidinput1").on("focus", function(){
        $(this).css("border", "2px solid #20a9ef");
    });
    $(".indexTopBotMidinput1").on("blur", function(){
        $(this).css("border", "2px solid #006ab5");
    });

    var setHeight = {
                left:$('.mainleft'),
                right:$('.mainright'),
                init:function(){
                        var Hl = this.left.height(),
                                Hr = this.right.height();
                        if(Hl>Hr){
                                this.right.css("height",Hl);
                                this.left.css("height",Hl)
                        }else if(Hl<Hr){
                                this.right.css("height",Hr);
                                this.left.css("height",Hr)
                        }
                }
        }
    setHeight.init();
    function zahe_1(name,cursel,n)
    {
          for(i=1;i<=n;i++)
                  {
                          var menu=document.getElementById(name+i);
                          var con=document.getElementById("con_"+name+"_"+i);
                          menu.className=i==cursel?"hover":"";
                          con.style.display=i==cursel?"block":"none";
                  }
    }


    //add by rainyang
    $(".insuranceTab a").on("click",function(){
        var dataid = $(this).attr("data-id");
        $(".insuranceType").hide();
        $(".insuranceTab a").removeClass("hover");
        $("#con_click_"+dataid).show();
        $(this).addClass("hover");
    });

//  if($( ".datepicker" ).length > 0){
//      $( ".datepicker" ).datepicker({
//          showOn: "button",
//          buttonImage: "images/calendar.gif",
//          buttonImageOnly: true
//      });
//  }

    /**
     * 保险详情页合作品牌滚动图
     * @auto 是否开启自动滚动
     * @speed 滚动速度
     * scroll 滚动图片数，如1为一次滚动1张图片，如需一次滚动4张就调成4
     */
    if($( ".piclist" ).length > 0){
        $(".piclist").jCarouselLite({
            btnNext: ".insuranceCobrandingTr",
            btnPrev: ".insuranceCobrandingTl",
            //auto: 800,
            speed: 1000,
            scroll: 1
        });
    }

    $("#btn-add-person").on("click",function(){
        var person = tmpl("tmpl-person-body");
        $("#add-person").append(person);
    });

    $(".btn-del-person").click(function(){
        $(this).parent().parent().find(".bnt").remove();
    });

    $("#add-person").on("click",".del-person",function(){
        $(this).parent().parent().remove();
    });

    $("#recommend").show();
    $("#bnt-discount").mouseover(function(){
        $("#discount").show();
        $("#recommend").hide();
        $(this).removeClass("hover");
        $("#bnt-recommend").removeClass("hover");
        $(this).addClass("hover");
    });

    $("#bnt-recommend").mouseover(function(){
        $("#discount").hide();
        $("#recommend").show();
        $(this).removeClass("hover");
        $("#bnt-discount").removeClass("hover");
        $(this).addClass("hover");
    });

    $(".nav .nav1, .sub-page-menu").mouseover(function(){
        $(".sub-page-menu").show();
        $(".nav1").addClass("nav1-up");
    });

    $(".sub-page-menu, .nav .nav1").mouseout(function(){
        $(".sub-page-menu").hide();
        $(".nav1").removeClass("nav1-up");
    });

    $(".add-linkman-title").click(function(){
        $(".add-linkman-form").show();
    });

    $("#bnt-linkman-submit").click(function(){
        $(".add-linkman-form").hide();
    });

    $(".prod_prop_list").click(function(){
        var $t = $(this);
        var $dataid = $t.attr("data-id");
        var $text= $t.text();
        $(".my-select").append('<ul><li><strong><label>'+$t.closest("dl").find("dt").text()+'</label>'+$text+'<span></span></strong></li></ul>');
    });

    $(".lay-prod-navgation").on("click",".my-select span",function(){
        $(this).closest("ul").remove();
    });

    $("#dev_clearAllProp").click(function(){
        $(".my-select").empty();
    });

    $("#dev_showOrHide").click(function(){
        $("#dev_MoreFilters").toggle();
    })
});
