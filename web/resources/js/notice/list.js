$(function(){
    var year = new Date().getFullYear();
    var month = new Date().getMonth();
    var date = new Date().getDate();
    var sType = $('#searchType').val();
    var i = $('#list tr').length-1;
    var type = $('#list tbody>tr');
       
       $('#write').click(function(){

        if(i == 7){
            return false;
        }
     
        i++;
        var enrollDate = $('#list td:nth-child(6n)').text(year+"-"+(month+1)+"-"+date);
        var output = "";
        output += "<tr align='center' class='table-line'><td><input type='checkbox' name='list'></td>";
        output += "<td>" + i + "</td><td>";
        output +=  "부서" + "</td><td>";
        output += "title" + "</td><td>";
        output += "name" + "</td><td>" + enrollDate;
        output += "</td><td>" + "조회수" + "</td></tr>";
        var list = $('#list tbody').html($('#list tbody').html() +output);  
        
    });

        $('#searchType').change(function(){
          type.css('visibility','hidden');
        
        type.each(function(index,item){
            if(type.eq(index-1).children('td:nth-child(3)').text() == $('#searchType').val()){
                console.log(type.eq(index-1).children('td:nth-child(3)').text());
                $(this).css('visibility','visible');
            }
        });
                                                
        if($('#searchType').val() == "전체"){
           $('#list tbody tr').css('visibility','visible');
        }
        });
    $('#checkAll').click(function(){
        if($(this).prop('checked')){
            $('input[name=list]').attr('checked','true');
        }else{
            $('input[name=list]').attr('checked',null);
        }
    });

});
