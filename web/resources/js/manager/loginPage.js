// 더미 데이터 

function employee(Number, id, password, job, gender, department, mail, address, showText){
    this.Number = Number;
    this.employeeId = id;
    this.password = password;
    this.job = job;
    this.gender = gender;
    this.department = department;
    this.mail = mail;
    this.address = address;
    this.showText = showText;
 
    this.toString = function toString(){
        alert("사번 : "+this.Number+", Id : "+this.employeeId + 
        ", password: "+this.password + ", job: "+this.job+ ", gender: " +this.gender
        + ", department: "+this.department+ ", mail: "+this.mail + ", mail: "+this.mail
        + ", address: "+this.address + ", showText: "+this.showText);
    }
}
var number = 0; // -1

var arrayEmployee = new Array(
    new employee(++number, 'Boss', 'Boss', '사 장', '남', '임 시', 'Boss@naver.com', '주소', '없음'),
    new employee(++number, 'qweasd1', 'qweasd1', '사 원', '남', '기 획', 'asfdv@naver.com', '주소', '없음'),
    new employee(++number, 'asdfa1', 'asdfa1', '대 리', '여', '기 획', 'asdfa1@naver.com', '주소', '없음'),
    new employee(++number, 'sdaqqq', 'sdaqqq', '과 장', '남', '인 사', 'sdaqqq@naver.com', '주소', '없음'),
    new employee(++number, 'davsdqv', 'davsdqv', '팀 장', '남', 'R&D', 'davsdqv@naver.com', '주소', '없음')
);

//이름 정규분포
$(function(){
   $('#clearN').click(function(){
        var regExp = /^[가-힣]/;
        if(!regExp.test($('#pName').val())){
            alert("이름을 정확히 입력해주세요");
            return false;
        }else{
            return true;
        }
    });
});
    

// 사진 등록 스크립트
    function ShowImage(value){
        console.log(value.files)
        console.log(value.files[0]) // file 속성 받아 온다.
            if(value.files && value.files[0]){
                var reader = new FileReader();//FileReader 객체는 웹 애플리케이션이 비동기적으로 
                ///데이터를 읽기 위하여 읽을 파일을 가리키는File 혹은 Blob 객체를 
                //이용해 파일의 내용을(혹은 raw data버퍼로) 읽고 사용자의 컴퓨터에 
                //저장하는 것을 가능하게 해줍니다.
                reader.onload = function(e){
                    document.getElementById("Show").setAttribute('src', e.target.result)
                }
            reader.readAsDataURL(value.files[0]);
        }
    }
// 회원 2. 테스트 용
    function fileShow(value){
        var reader = new FileReader();
        //createFile();
        reader.onload = function(e){
            console.log(e.target.result); //base64 코드로 경로 표시
            document.getElementById('show2').src =  e.target.result;
        };
        reader.readAsDataURL(value.files[0]);

    }

// 파일 생성 -> new ActiveXObject() 은 크롬에서 실행 x 파일 생성은 자바에서 해주어야 될듯
    // function createFile(){

    //     var fileObject = new ActiveXObject("Scripting.FileSystemObject");

    //     fWrite = fileObject.CreateTextFile("C:\Users\최홍석\Desktop\2020_01_19\managerView", true);

    //     fWrite.fWrite('Hello JavaScript');

    //     fWrite.close();

    // }


    function showId(value){

        for(var i = 1; i<=4; i++){
            if(i == value){

                document.getElementById('change'+i).style.display = "block";
                //document.getElementById('change'+i).eval(ch1);
            }else{
                document.getElementById('change'+i).style.display = 'none';
                // document.getElementById('change'+i).style.visibility='hidden';
            }
        }
    }

   (function (){
            for(var i = 1; i<=4; i++){
            // document.getElementById('change'+i).style.visibility='hidden';
            document.getElementById('change'+i).style.display = 'none';
            }  



    })()
          
// 1. 가입 페이지 ------------
var checknumber = "";
var checkId = false;
var checkPassword = false;
var checkEmail = false;

    function numberCheck(){
        var number = document.getElementById('N11').value;

        for(var i = 0; i<arrayEmployee.length; i++){
            if(arrayEmployee[i] == undefined){
                break;    
            }

            if(number == arrayEmployee[i].Number){
                alert('중복 되는 사번이 있습니다.');
                checknumber = false;
                console.log(checknumber);
                return;
            }
        }
        checknumber = true;
        alert('중복 되는 사번이 없습니다.');
        console.log(checknumber);
    };

// 아이디 확인
    function IdCheck(){
        
        var id = document.getElementById('N12').value;
        var idRegExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;;

        for(var i = 0; i<arrayEmployee.length; i++){
            
            if(idRegExp.test(id)){
                alert('아이디 작성시 특수문자를 쓸수 없습니다.');
                document.getElementById('N12').focus();
                checkId = false;
                return;
            }

            if(id == arrayEmployee[i].employeeId){
                alert('중복 되는 id가 있습니다.');
                checkId = false;
                console.log(checkId);
                return;
            }
        }
        checkId = true;
        alert('중복 되는 id가 없습니다.');
        console.log(checkId);
    };

        function passwordCheck(){
        if($('#N13').val()==$('#N13e').val()){
            alert("비밀번호 일치");
        }else{
            alert("비밀번호가 틀립니다.");
            $('N13e').focus();
            return false;
        }
    }


    document.getElementById('N15').onclick = function(){
        document.getElementById('N14').value = document.getElementById('N15').value;
    }


    //이메일 정규표현식 적용
    function emailCheck(){

        var mailRegExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

        var email = document.getElementById('N14').value;

        if(!mailRegExp.test(email)){
            alert('이메일 작성이 잘못 되었습니다.');
            document.getElementById('N14').focus();
            checkEmail = false;
            return;
        }

        for(var i = 0; i<arrayEmployee.length; i++){
            
            if(email == arrayEmployee[i].employeeId){
                alert('중복 되는 email이 있습니다.');
                checkEmail = false;
                document.getElementById('N14').focus();
                console.log(checkEmail);
                return;
            }
        }
        alert('이메일 형식 올바르게 입력 되었습니다.')
        checkEmail = true;
    }

    // document.getElementById('N15').onclick = function(){
    //     alert('나중에 공공api로 구현');
    //     document.getElementById('N16').value = "서울 강남구 삼성동";
    // }

    function showAddress(){
        alert('나중에 공공api로 구현');
        document.getElementById('N16').innerHTML = "서울 강남구 삼성동";
    }

// 확인 버튼
document.getElementById('regist').onclick = function(){
    //employee(Number, id, password, job, gender, department, mail, address, showText)
    
    var id = document.getElementById('N12').value;

    //alert(window.checknumber == "")

    if(!checknumber){
        alert('사번의 중복 확인을 해주세요.');
        return;
    }

    var password = document.getElementById('N13').value;
    
    var job = document.getElementById('CompanyRank11').value;

    // 성별 값 체크 
    var gender = ""; // 성별 값 저장
    var num = 0;
    for(var i = 0; i<=1; i++){
        if(num == 2){
            alert('성별 값을 체크 해주세요. ');
            return;
        }else if(document.getElementsByName('gender1')[i].checked){
            gender = document.getElementsByName('gender1')[i].value;
        }
    }

    var department = document.getElementById('Department11').value;

    if(!checkEmail){
        alert('이메일 중복 확인을 해주세요.');
        return false;
    }

    var mail = document.getElementById('N14').value;

    var address = document.getElementById('N16').innerText;

    var showText = document.getElementById('N17').value;

    arrayEmployee.push(new employee(++number, 
        id, password, job, gender, department, mail, address, showText));

    
    arrayEmployee[number-1].toString()

   // --- html 상에서 확인 후에 보여주는 자료 지우기
   document.getElementById('N11').value = "";
   document.getElementById('N12').value = "";
   document.getElementById('N13').value = "";
   document.getElementById('CompanyRank11').options[0].selected = true;
   for(var i = 0; i<=1; i++){
       document.getElementsByName('gender1')[i].checked = false;
   }
   document.getElementById('Department11').options[0].selected = true;
   document.getElementById('N14').value = "";
   document.getElementById('N15').options[0].selected = true;
   document.getElementById('N16').value = "";
   document.getElementById('N17').value = "";

}
          
// 2. 회원 수정 페이지
var ModifyUser = "";
var ModifyNumber = "";

function showModify(){
    var number = document.getElementById('N21').value;
    console.log(number);
    for(var i = 0; i<=arrayEmployee.length-1; i++){

        // 배열에서 찾는 유저가 있으면 if문 실행
        if(arrayEmployee[i].Number == number){
            ModifyUser = arrayEmployee[i];
            ModifyNumber = number;
            console.log(ModifyUser);
            console.log(ModifyNumber);

            document.getElementById('inputFunction22').value = ModifyUser.employeeId;
            document.getElementById('inputFunction24').value = ModifyUser.password;

            // 직 급 을 확인 하기 위한 코드
            for(var i =0; i < document.getElementById('CompanyRank2').length; i++){
                var choose = document.getElementById('CompanyRank2');

                if(choose.options[i].value == ModifyUser.job){
                    choose.options[i].selected = true;
                    break;
                }
            }

            document.getElementById('gender2').innerHTML = ModifyUser.gender;
            document.getElementById('Department2').value = ModifyUser.department;

            // 부 서 을 확인 하기 위한 코드
            for(var i =0; i < document.getElementById('Department2').length; i++){
                 var choose = document.getElementById('Department2');
            
                if(choose.options[i].value == ModifyUser.job){
                    choose.options[i].selected = true;
                    break;
                }
            }
            document.getElementById('modifyEmailShow').value = ModifyUser.mail;
            document.getElementById('inputFunction26').innerHTML = ModifyUser.address;
            document.getElementById('modifyShowText').innerHTML = ModifyUser.showText;
            return;
        }
    }// end for
    
    alert('찾는 회원이 없습니다.');
    document.getElementById('N21').focus();
    return;
}


// 아이디 확인
function IdModify(){
        
    var id = document.getElementById('inputFunction22').value;
    var idRegExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;;
        
    if(idRegExp.test(id)){
        lert('아이디 작성시 특수문자를 쓸수 없습니다.');
        document.getElementById('inputFunction22').focus();
        return;
    }

    if(id == ""){
        alert('id가 비어 있습니다.');
        console.log(id);
        document.getElementById('inputFunction22').focus();
        return;
    }
    
    alert('쓸수 있는 아이디 입니다.');
};

function passwordModify(){
        
    var password = document.getElementById('inputFunction24').value;

    if(password == ""){
        alert('password가 비어 있습니다.');
        console.log(checkPassword);
        document.getElementById('inputFunction24').focus();
        return;
    }

    alert('쓸수 있는 password 입니다.');
};

function ModifyEmail(){
    var mailRegExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

    var email = document.getElementById('modifyEmailShow').value;

    if(!mailRegExp.test(email)){
        alert('이메일 작성이 잘못 되었습니다.');
        document.getElementById('modifyEmailShow').focus();
        checkEmail = false;
        return;
    }

        
    if(email == ""){
        alert('email이 비아 있습니다.');
        document.getElementById('modifyEmailShow').focus();
        console.log(email);
        return;
    }
    
    alert('쓸수 있는 email 입니다.');

}

function ModifyAddress(){
    var inputString = prompt('공공api 적용은 나중에 // 주소를 적으시요');
    document.getElementById('inputFunction26').innerHTML = inputString;
}

document.getElementById('modify').onclick = function(){

    ModifyUser.employeeId = document.getElementById('inputFunction22').value;
    ModifyUser.password = document.getElementById('inputFunction24').value
    ModifyUser.job = document.getElementById('CompanyRank2').value;
    ModifyUser.gender = document.getElementById('gender2').innerText;
    ModifyUser.department = document.getElementById('Department2').value;
    ModifyUser.mail = document.getElementById('modifyEmailShow').value;
    ModifyUser.address = document.getElementById('inputFunction26').innerText;
    ModifyUser.showText = document.getElementById('modifyShowText').value;

    arrayEmployee.splice(ModifyNumber-1, 1, ModifyUser); //= ModifyUser;

    arrayEmployee[ModifyNumber-1].toString();
    
    alert('수정 되었습니다.');

// html 화면의 데이터를 지운다.
    document.getElementById('N21').value = "";
   document.getElementById('inputFunction22').value = "";
   document.getElementById('inputFunction24').value = "";
   document.getElementById('CompanyRank2').options[0].selected = true;
    document.getElementsByName('gender2').innerHTML = "";
   document.getElementById('Department2').options[0].selected = true;
   document.getElementById('modifyEmailShow').value = "";
   document.getElementById('inputFunction26').innerHTML = "";
   document.getElementById('modifyShowText').value = "";

    
}

var deleteUser = "";
var deletNumber = "";
var checkDelete = "";

// 3. 회원 수정 페이지
function showDeleteList(){
    var number = document.getElementById('deleteNumber').value;
    
    for(var i = 0; i<=arrayEmployee.length-1; i++){

        // 배열에서 찾는 유저가 있으면 if문 실행
        if(arrayEmployee[i].Number == number){
            deleteUser = arrayEmployee[i];
            deletNumber = number;

            // 아이디
            document.getElementById('delete1').innerHTML = deleteUser.employeeId;
            // 비밀 번호
            document.getElementById('delete2').innerHTML = deleteUser.password;
            // 직 급
            document.getElementById('delete3').innerHTML = deleteUser.job;
            // 성 별
            document.getElementById('delete4').innerHTML = deleteUser.gender;
            // 부 서
            document.getElementById('delete5').innerHTML = deleteUser.department;
            // 메 일
            document.getElementById('delete6').innerHTML = deleteUser.mail;
            // 주 소
            document.getElementById('delete7').innerHTML = deleteUser.address;
            //특이 상항
            document.getElementById('delete8').innerHTML = deleteUser.showText;
            checkDelete = true;
            return;
        }
        
    }// end for
    document.getElementById('deleteNumber').select();
    //회원 x
    checkDelete = false;
    alert('검색 하신 회원이 존재 하지 않습니다.');

}// end showDeleteList

    function deleteExecute(){
        if(deleteUser == ""){
            alert("삭제 할 회원 검색이 없습니다. 다시 입력 해주세요.");
            document.getElementById('deleteNumber').select();
        }
        if(!checkDelete){
            alert("사 번 를 클릭 하셔서 회원을 검색 해주세요");
            return ;
        }
        var check = confirm(deleteUser.id+'삭제를 하시겠습니까?');

        if(check){

            arrayEmployee.splice(deletNumber-1, 1);

            document.getElementById('deleteNumber').innerHTML = "";
            for(var i = 1; i <= 8; i++){
                document.getElementById('delete'+i).innerHTML = "";
            }
            alert("삭제가 완료 되었습니다.");
        }

        

    }


















