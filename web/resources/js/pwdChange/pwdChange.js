function cancel(){
    window.close();
}

function submit2(){
    
    var changePwd1 = document.getElementById('changePwd1');
    var changePwd2 = document.getElementById('changePwd2');

    if( changePwd1.value != changePwd2.value ){
        alert("수정할 비밀번호가 다릅니다.");
        changePwd2.select();
        return false;
    }
    return true;
}