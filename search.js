  //Search functions
  //search.js
  
	const suggestions = document.querySelector('.suggestions');
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
      const slug = '\'' + inp + '\'';
      const matchArray = findMatches(sear, anime);
      var html = matchArray.map(ani => {
      const regex = new RegExp(sear, 'gi');
      
      //aniname is japanese(or name from twist.moe directly)
      
      const aniName = ani.title;
      //if there is english name(ani.alt)
      var engName = '';
      const animetlink ="\'" +  ani.name + "\'";
      
      if(ani.alt != false){
      engName = ani.alt;
      }
      console.log(animetlink,ani.name);
      //title is englishname (if not found aniname)
      
      const title = engName || aniName;
      //console.log(title);
      return`
      <a onclick="changVidkits(${animetlink},${slug})" href="#" title="${title}">
        <li>
        <span class="name">${aniName}</span><br>
        </li>
        </a>`;
      }).join('');
      
      /*
      If box is empty and
      input didn't come from 
      m2(as a second argument from kitsusearch)
    */

      if(seart.value != "" && !m2){
      console.log(seart.value != "");
      console.log('directly requested');
      suggestions.innerHTML = html;
      //console.log("html" + html);
      //console.log(seart.value);
      }
      else{
      console.log('requested from kitsusearch');
      toggleSearch();
      suggestions.innerHTML = html;
      if(suggestions.innerHTML == ""){
          html += '<li><span class="name">No Results Found</span><br></li>';
      suggestions.innerHTML += html;
      }
      }
      //console.clear();
  }

