function onEndSong()
    addHaxeLibrary('StoryMenuState')
    rcom = runHaxeCode("return StoryMenuState.weekCompleted.get('weekR') ? true : false;")
    dcom = runHaxeCode("return StoryMenuState.weekCompleted.get('dsides') ? true : false;")
    ncom = runHaxeCode("return StoryMenuState.weekCompleted.get('weekN') ? true : false;")

if rcom and dcom then
    saveFile('charselect/default.json', [[
        {
            "characters": 
            [
                ["Default Character", "Please, DO NOT REMOVE THIS LINE!!!"],
                ["Boyfriend (RenoSkin)", "bf-renoskin"],
                ["Hoodie Boyfriend (RenoSkin)", "bf-renoskin-hood"],
                ["D-Sides Boyfriend (RenoSkin)", "bf-renoskin-dsides"],
                ["Boyfriend (HeV)", "bf"],
                ["Girlfriend", "gf_playable"],
                ["Pico", "pico-player"]
            ]
        }
        ]], false)
    else if rcom then
        saveFile('charselect/default.json', [[
{
    "characters": 
    [
        ["Default Character", "Please, DO NOT REMOVE THIS LINE!!!"],
        ["Boyfriend (RenoSkin)", "bf-renoskin"],
        ["Hoodie Boyfriend (RenoSkin)", "bf-renoskin-hood"],
        ["Boyfriend (HeV)", "bf"],
        ["Girlfriend", "gf_playable"],
        ["Pico", "pico-player"]
    ]
}
]], false)
    else if dcom then
        saveFile('charselect/default.json', [[
{
    "characters": 
    [
        ["Default Character", "Please, DO NOT REMOVE THIS LINE!!!"],
        ["Boyfriend (RenoSkin)", "bf-renoskin"],
        ["D-Sides Boyfriend (RenoSkin)", "bf-renoskin-dsides"],
        ["Boyfriend (HeV)", "bf"],
        ["Girlfriend", "gf_playable"],
        ["Pico", "pico-player"]
    ]
}
]], false)
else
    saveFile('charselect/default.json', [[
{
    "characters": 
    [
        ["Default Character", "Please, DO NOT REMOVE THIS LINE!!!"],
        ["Boyfriend (RenoSkin)", "bf-renoskin"],
        ["Boyfriend (HeV)", "bf"],
        ["Girlfriend", "gf_playable"],
        ["Pico", "pico-player"]
    ]
}
]], false)
    end
end
end
end