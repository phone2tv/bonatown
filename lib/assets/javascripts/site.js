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

    //选项卡特效
    function setTab(name,cursel,n){
     for(i=1;i<=n;i++){
      var menu=document.getElementById(name+i);
      var con=document.getElementById("con_"+name+"_"+i);
      menu.className=i==cursel?"hover":"";
      con.style.display=i==cursel?"block":"none";
     }
    }
});
