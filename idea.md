# Neovim plugin that imports cards into Anki. (Without having to use notion.so inbetween)

# For reference
## Loading nvim with runtimepath set to current directory.
`nvim --cmd "set rtp+=$(pwd)"`

## Requirements
### Communication
* Need to be able to communicate with anki through HTTP Requests 
 * https://github.com/FooSoft/anki-connect

## GUI

### Settings
GUI has to have the following things:
* Possibility to specify port anki-connect is running on
* Possibility to specify address anki-connect is running on

### Extension view
* Anki deck
* Question
* Answer
* Insert stuff from Anki that is needed. 

### Anki information (that I don't know about yet)

## Anki-connect
Exposes an api that can communicate with the Anki client.
### API
Sample successful response: `{"result": ["Default", "Filtered Deck 1"], "error": null}`
Samples of failed responses: 
```
{"result": null, "error": "unsupported action"}
{"result": null, "error": "guiBrowse() got an unexpected keyword argument 'foobar'"}
```

Query to get all cards.
```
{
    "action": "findCards",
    "version": 6,
    "params": {
        "query": "deck:current"
    }
}
```
Example request to anki-connect `curl localhost:8765 -X POST -d '{"action": "deckNames", "version": 6}'`
