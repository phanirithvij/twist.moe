# Twist.moe grabber

This branch has a kind of node js implementation



## To get all anime titles and urls

- Launch a chrome session

    On Linux

    ```shell
    google-chrome --remote-debugging-port=9222 --no-first-run --no-default-browser-check --user-data-dir=$(mktemp -d)
    ```

    Taken from [here](https://medium.com/@jaredpotter1/connecting-puppeteer-to-existing-chrome-window-8a10828149e0)

- Then run `node src/main.js`
    A `allAnime.json` is generated
- Then to format it
    ```shell
    python3 -m json.tool allAnime.json > formatted.json
    ```
