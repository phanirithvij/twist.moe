// ==UserScript==
// @name         Back to top
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        *://*/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    var b = document.createElement('script');
    b.src = "https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js";
    document.body.appendChild(b);
    var s= document.createElement('script');
    s.innerHTML = "function Top(){$('html, body').animate({scrollTop:0}, 'slow');console.log(\"TO top\");};";
    document.body.appendChild(s);
        var butt = document.createElement('button');
    butt.onclick="Top()";
    butt.innerHTML='top';
    butt.id = "btop";
    document.body.appendChild(butt);
    var st = document.createElement('style');
    st.innerHTML='#btop{bottom:10px;right:10px;position:fixed;width:60px;height:30px;border-radius:20%;z-index:999;}';
    document.body.appendChild(st);
    butt.addEventListener('click',Top,false);
})();