	
	//Kitsu and togglesearch
	//kitsu.js
	
	function doneTyping () {
	//user is "finished typing," do something
	    kitsSearch();
	}

	const suggestions2 = document.querySelector('.suggestions2');
	const kitapi = "https:kitsu.io/api/edge/";
	const kit = "https:kitsu.io/";
	const mkit = "https:media.kitsu.io/";
	var url = '';
	var resp = '';
	var resu = '';
	
	function kitsSearch(){

		//console.log(this);
		//console.log(sears.value);
		
		//Get anime results matching sears.value
		//from kitsu.io

		var link = '';
		link = kitapi + 'anime' + '?filter[text]' + sears.value;
		console.log(link);
		resp = $.getJSON(link,(data)=>{
			processData(data)
		});
		url=link;
	}

	function processData(da){
		resu = da;
		console.log(resu);
		console.log(resu.data);
		var json = JSON.stringify(resu);
		const html = resu.data.map((v) => {
			const name = v.attributes.canonicalTitle;
			const rating = v.attributes.averageRating;
			const slu =  "" + v.attributes.slug;
			return `
				<li>
				<button class="kitbutt" onclick="twistSearch(\'${slu}\',\'${name}\')">
				<span class="name">${name}</span>
				<span class="name">${rating}</span>
				<p style="display: none;" id="${slu}">${json}</p>
				</button>
				</li>

			`;
		}).join('');
		//console.log(html);
		suggestions2.innerHTML = html;
	}

	function twistSearch(a,b){
		console.log(a,b);
		suggestions.innerHTML = '';
		displayMatches(a,a);
		displayMatches(a,b);
	}

	function toggleSearch(){
			
			/*
			search bars get replaced
			*/

			const t = document.querySelector('#twis');
			const s = document.querySelector('#kits');
		//	console.log(t);
		//	console.log(s);
			if(t.style.display == "none"){
			s.style.display = "none";
			t.style.display = "block";
			}
			else{
			t.style.display = "none";
			s.style.display = "block";
			}
	}

