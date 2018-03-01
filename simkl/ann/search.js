const sear = document.querySelector('#searchbar');
const disp = document.querySelector('#display');

function displayStuff(data){
	console.log('display',data);	
	disp.innerText = JSON.stringify(data);	
}



function doneTyping(){
searchANN();
}

function searchANN(){
var url = '';
console.log(sear.value);
if(isNaN(sear.value)){
url = 'https://cdn.animenewsnetwork.com/encyclopedia/nodelay.api.xml?title=~';
}
else{
url = 'https://cdn.animenewsnetwork.com/encyclopedia/nodelay.api.xml?title=';
}
$.ajax({
	url: url + sear.value,
	success:(data)=>{
	var x2j = new X2JS();
	resp = x2j.xml2json(data);
	displayStuff(resp);
	console.log('....');
	}
});
}

var resp='';

var typingTimer;                //timer identifier
var doneTypingInterval = 600;  //time in ms (1 seconds)
 //on keyup, start the countdown
  $('#searchbar').keyup(function(){
        clearTimeout(typingTimer);
        if ($('#searchbar').val()) {
           typingTimer = setTimeout(doneTyping, doneTypingInterval);
        }
 });


//sear.addEventListener('change',searchANN);
//sear.addEventListener('keyup',searchANN);
