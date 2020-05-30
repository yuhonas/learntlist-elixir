# learntlist.com ![Elixir CI](https://github.com/yuhonas/learntlist.com/workflows/Elixir%20CI/badge.svg)

A dispassionate list of day to day learnings

## Why?

This is mostly a personal project that may have some wider appeal but for the last four years
I've kept a notebook of learnings in [evernote](https://evernote.com/features/webclipper) thing's I uttered thats interesting! and wished to revise at some point in the future, they were ingested into evernote in the following ways

1) Using the [evernote web clipper](https://evernote.com/features/webclipper)
2) Adding a note that contains a short summary and a link to wikipedia (if an article resides there)

Lately I've been thinking

* How can I easily search/sort/view these learnings
* What's the ontology between all these items, what is the "bigger picture"
* How could I present what i've learnt in a richer way
* How can I summarise/report on what i've learnt to reflect on it

Thankfully most of these are related to wikipedia articles from which I can derive structured content from, so...

### Evernotes not the right fit, f*ck it, let's build something

First of all let's get the data out of evernote into something more usable, I dumped my entire notebok into the evernote [enml](https://dev.evernote.com/doc/articles/enml.php) format eg. `learnt-list.enex`, then I used [yq](https://github.com/kislyuk/yq) which has XML support to transform it into CSV and `COPY` it into Postgres

1) Exporting notes I added using the webclipper

```bash
xq --raw-output '.[] | .note | [.[] | select(.["note-attributes"]["source-url"]| tostring | contains("wikipedia"))] | unique_by(.["note-attributes"]["source-url"]) | .[] |  [ .created, .updated, .title, .["note-attributes"]["source-url"] ] | @csv' ~/Downloads/learnt-list.enex | psql learntlist_dev -c "COPY learnt_items (inserted_at,updated_at,title,url) from STDIN DELIMITER ',' NULL '' CSV"
```

2) Exporting notes I added by hand that _somewhere_ in the body contained a wikipedia link

```bash
$ xq --raw-output '.[] | .note | .[] | select(.["note-attributes"]["source-url"] == null) | (.content |  capture("(?<url>https://en.wikipedia.org/wiki/[\\\w%]+)")) as $attributes | [ .created, .updated, .title, $attributes.url ] | @csv' learnt-list.enex | psql learntlist_dev -c "COPY learnt_items (inserted_at,updated_at,title,url) from STDIN DELIMITER ',' NULL '' CSV"
```

### Prerequisites

* Elixir ~> 1.10.x

## Installation

Install our elixir dependencies using mix

```
$ mix deps.get
```

## Running the tests

```
mix test
```

### Linting

[credo](https://github.com/rrrene/credo) is used for linting/style checking and runs as part of the `test` task see [mix.exs](./mix.exs)

If you wish to run it in isolation

```
mix credo
```

## Deployment

There is a CI/CD pipeline setup on `master` which deploys to heroku see [travis.yml](./travis.yml)

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags).


## Acknowledgements

* [A template to make a good README](https://gist.github.com/PurpleBooth/109311bb0361f32d87a2)
