from fuzzywuzzy import fuzz, process
import sys
import json


def main():
    term = sys.argv[1].casefold()

    with open("new.min.json", 'r', encoding='utf-8') as cache:
        data = json.load(cache)
        titles = {}
        alts = {}
        slugs = {}
        for item in data:
            if 'slug' not in item or 'slug' not in item['slug']:
                print('bad anime', item)
                continue
            slug = item['slug']['slug'].casefold()
            slugs[slug] = slug

            if 'alt_title' in item and item['alt_title'] is not None:
                alt_title = item['alt_title'].casefold()
                alts[slug] = alt_title
                # else ignore

            if 'title' in item and item['title'] is not None:
                title = item['title'].casefold()
                titles[slug] = title
            else:
                print("No title??", item)

        # TODO: combine slug, title, alt and use token_set_ratio scorer?

        final_slugs = {}

        def initial(key):
            return 0 if key not in final_slugs else final_slugs[key]

        def reduce(key):
            # TODO: alphabetical order instead of sum/max

            # return sum([num, initial(key)])
            return max(num, initial(key))

        # reduce all the slugs by a metric
        for _, num, key in process.extractBests(
            term,
            slugs,
            limit=20,
            score_cutoff=61,
            # scorer=fuzz.QRatio
        ):
            final_slugs[key] = reduce(key)
        # reduce all the alts by a metric
        for _, num, key in process.extractBests(
            term,
            alts,
            limit=20,
            score_cutoff=61,
            # scorer=fuzz.QRatio
        ):
            final_slugs[key] = reduce(key)
        # reduce all the titles by a metric
        for _, num, key in process.extractBests(
            term,
            titles,
            limit=20,
            score_cutoff=61,
            # scorer=fuzz.QRatio
        ):
            final_slugs[key] = reduce(key)

        # fuzzy search done
        final_slugs = (
            [
                k for k, v in sorted(
                # (k, v) for k, v in sorted(
                    final_slugs.items(),
                    # key=lambda item: item[0],
                    key=lambda item: item[1],
                    reverse=True
                ) if v > 62
                # ]  # no limit
            ][:20]  # limit to 20
        )

        for slug in final_slugs:
            print(slug)

        # Now we can have more priority based on popularity, sfw type
        # eg: ('boku-no-pico', 180), ('boku-no-hero-academia', 180)
        # boku-no-hero-academia > boku-no-pico
        # academia is popular, sfw
        # pico is popular but nsfw
        # sort by popularity or trending etc..
        # add huge penalty for nsfw if nsfw is allowed
        # don't add penalty for nsfw if nsfw is allowed and explicitly filtered


if __name__ == "__main__":
    main()
