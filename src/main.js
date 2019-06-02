const puppeteer = require("puppeteer-core");
const fs = require('fs');

const endPoint = "ws://127.0.0.1:9222/devtools/browser/749a29e9-1112-4e75-bd90-ee0d39a1ad70";

(async () =>{
    const browser = await puppeteer.connect({
        browserWSEndpoint: endPoint,
    });

    const page = await browser.newPage();
    let pageUrl = 'https://twist.moe/';

    await page.goto(pageUrl, {
        waitUntil: 'networkidle0' // 'networkidle0' is very useful for SPAs.
    });

    let dataJson = await page.evaluate(() => {
        return JSON.stringify(__NUXT__.state.anime.all);

        // let List = document.querySelector('ul.interactive');
        // let objectList = List.querySelectorAll('li');
        // let allAnime = [];

        // objectList.forEach((item) => {
        //     let child = item.firstChild;
        //     let title = child.innerText;
        //     let href = child.href;

        //     allAnime.push({title, href});
        // });

        // return JSON.stringify(allAnime);
    });

    fs.writeFile("allAnime.json", dataJson, function(err) {
        if(err) {
            return console.log(err);
        }

        console.log("The file was saved!");
    });
})();
