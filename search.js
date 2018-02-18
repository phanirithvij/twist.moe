	//Search functions
	//search.js
	
	const seart = document.querySelector('[name=anisearch]');
	const sears = document.querySelector('[name=kitssearch]');
	function findMatches(wordToMatch, anime) {
  		return anime.filter(ani => {
    
    // here we need to figure out if the name matches what was searched 
    
    	const regex = new RegExp(wordToMatch, 'gi');
    	if (ani.alt){
    	return ani.title.match(regex) || ani.name.match(regex) || ani.alt.match(regex)
    	}else{
    		return ani.title.match(regex) || ani.name.match(regex)
    	}
  		});
	}

	function twinkle(e){
		console.log(e);
		ele = e;
	}

	function displayMatches(inp,m2) {
		var sear = '';
		/*if m2 is not defined
		search by the value found in this search bar
		*/
		if(!m2){
		sear = seart.value;
		//console.log("!m2" + sear);
		}
		else{
		//if m2 is found search by m2	
		sear = m2;
		
		}
  		const matchArray = findMatches(sear, anime);
 	    const html = matchArray.map(ani => {
    	const regex = new RegExp(sear, 'gi');
    	
    	//aniname is japanese(or name from twist.moe directly)
    	
    	const aniName = ani.title;
    	var engName = '';
    	
    	//if there is english name(ani.alt)
    	
    	if(ani.alt != false){
    	engName = ani.alt;
    	}
    	
    	//title is englishname (if not found aniname)
    	
    	const title = engName || aniName;
    	//console.log(title);
    	return`
    	<a onmouseover="//twinkle(this)" href="https://twist.moe/a/${ani.name}" title="${title}">
      	<li>
        <span class="name">${aniName}</span><br>
      	</li>
      	</a>`;
  		}).join('');
  		
  		/*
  		IF box is empty and
  		input didn't come from 
  		m2(as a second argument)
		*/

  		if(seart.value != "" && !m2){
  		//console.log(seart.value != "");
  		suggestions.innerHTML = html;
  		//console.log("html" + html);
  		//console.log(seart.value);
  		}
  		else{
  		toggleSearch();
  		suggestions.innerHTML += html;
  		if(suggestions.innerHTML == ""){

  		}
  		}
  		//console.clear();
	}

	const suggestions = document.querySelector('.suggestions');
