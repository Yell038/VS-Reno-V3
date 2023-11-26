-- Script made by XTihX https://gamebanana.com/members/2066788

local characters = { -- The variable that stores the amount of characters that you want
    { 
        charName = 'dadda', -- The name of your character that can be used in functions like "setProperty('pico.scale.x', 400)" or "doTweenX('tag', 'pico', 300, 2.5, 'linear')"
        characterName = 'dad', -- The name of your .json character in the folder "characters"
        x = -300, -- The X Pos of your character
        y = 0, -- The Y Pos of your character
        group = 'dadGroup', -- The Group of your character, can be 'boyfriendGroup', 'dadGroup' or 'gfGroup' (DONT LEAVE THIS VALUE IN BLANK)
        noteTypes = { -- The note types of your characters, to add a new one make like the exemple down here.
            { name = 'customSingLeft',    animSuffix = '' },
            { name = 'customSingLeftDouble',    animSuffix = '' }
        } 
    },
    { 
        charName = 'playgf', -- The name of your character that can be used in functions like "setProperty('pico.scale.x', 400)" or "doTweenX('tag', 'pico', 300, 2.5, 'linear')"
        characterName = 'gf_playable-charfix', -- The name of your .json character in the folder "characters"
        x = 0, -- The X Pos of your character
        y = 100, -- The Y Pos of your character
        group = 'boyfriendGroup', -- The Group of your character, can be 'boyfriendGroup', 'dadGroup' or 'gfGroup' (DONT LEAVE THIS VALUE IN BLANK)
        noteTypes = { -- The note types of your characters, to add a new one make like the exemple down here.
            { name = 'customSingRight',    animSuffix = '' },
            { name = 'customSingRightDouble',    animSuffix = '' }
        } 
    }
};

isExtraKeys = false -- change it to true if this script is running on the psych engine extra keys.


--DONT CHANGE ANYTHING DOWN HERE UNLESS YOU KNOW WHAT YOU ARE DOING!!--------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
function onCreatePost()
    luaDebugMode = true;

    addHaxeLibrary('Note');
    addHaxeLibrary('FlxMath', 'flixel.math');
    addHaxeLibrary('Math');
    addHaxeLibrary('Std');

    for i, char in ipairs(characters) do
        runHaxeCode([[
            game.variables[']]..char.charName..[['] = new Character(]]..char.x..[[, ]]..char.y..[[, ']]..char.characterName..[[');
            game.]]..char.group..[[.add(game.variables[']]..char.charName..[[']);
        ]]);

        setProperty('playgf.alpha', 0)
    end
end

function onStartCountdown()
    runTimer('startTimer', crochet / 1000 / playbackRate, 5);
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'startTimer' then
        for i, char in ipairs(characters) do
            runHaxeCode([[
                if (game.variables[']]..char.charName..[['].danceIdle && ]]..loopsLeft..[[ % Math.round(game.variables[']]..char.charName..[['].danceEveryNumBeats) == 0 && game.variables[']]..char.charName..[['].animation.curAnim != null && !StringTools.startsWith(game.variables[']]..char.charName..[['].animation.curAnim.name, 'sing') && !game.variables[']]..char.charName..[['].stunned) {
                    game.variables[']]..char.charName..[['].dance();
                }
                if (!game.variables[']]..char.charName..[['].danceIdle && ]]..loopsLeft..[[ % game.variables[']]..char.charName..[['].danceEveryNumBeats == 0 && game.variables[']]..char.charName..[['].animation.curAnim != null && !StringTools.startsWith(game.variables[']]..char.charName..[['].animation.curAnim.name, 'sing') && !game.variables[']]..char.charName..[['].stunned) {
                    game.variables[']]..char.charName..[['].dance();
                }
            ]]);
        end
    end
end

function onBeatHit()
    for i, char in ipairs(characters) do
        runHaxeCode([[
            if (game.variables[']]..char.charName..[['].danceIdle && game.curBeat % Math.round(game.variables[']]..char.charName..[['].danceEveryNumBeats) == 0 && game.variables[']]..char.charName..[['].animation.curAnim != null && !StringTools.startsWith(game.variables[']]..char.charName..[['].animation.curAnim.name, 'sing') && !game.variables[']]..char.charName..[['].stunned) {
                game.variables[']]..char.charName..[['].dance();
            }
            if (!game.variables[']]..char.charName..[['].danceIdle && game.curBeat % game.variables[']]..char.charName..[['].danceEveryNumBeats == 0 && game.variables[']]..char.charName..[['].animation.curAnim != null && !StringTools.startsWith(game.variables[']]..char.charName..[['].animation.curAnim.name, 'sing') && !game.variables[']]..char.charName..[['].stunned) {
                game.variables[']]..char.charName..[['].dance();
            }
        ]]);
    end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
    characterNoteHit(id, noteData, noteType, isSustainNote);
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    characterNoteHit(id, noteData, noteType, isSustainNote);
end

function characterNoteHit(id, noteData, noteType, isSustainNote)
    for i, char in ipairs(characters) do
        for j, note in ipairs(char.noteTypes) do
            if noteType == note.name then
                if isExtraKeys then
                    runHaxeCode([[
                        var animToPlay:String = 'sing' + Note.keysShit.get(PlayState.mania).get('anims')[]]..noteData..[[];
    
                        game.variables[']]..char.charName..[['].playAnim(animToPlay + ']]..note.animSuffix..[[', true);
                        game.variables[']]..char.charName..[['].holdTimer = 0;
                    ]]);
                else
                    runHaxeCode([[
                        var animToPlay:String = game.singAnimations[Std.int(Math.abs(]]..noteData..[[))];
        
                        game.variables[']]..char.charName..[['].playAnim(animToPlay + ']]..note.animSuffix..[[', true);
                        game.variables[']]..char.charName..[['].holdTimer = 0;
                    ]]);
                end
            end
        end
    end
end
function noteMiss(id, noteData, noteType, isSustainNote)
    for i, char in ipairs(characters) do
        for j, note in ipairs(char.noteTypes) do
            if noteType == note.name then
                if isExtraKeys then
                    runHaxeCode([[
                        if(game.variables[']]..char.charName..[['].hasMissAnimations) {
                            var animToPlay:String = 'sing' + Note.keysShit.get(PlayState.mania).get('anims')[]]..noteData..[[] + 'miss';
                            game.variables[']]..char.charName..[['].playAnim(animToPlay + ']]..note.animSuffix..[[', true);
                        }
                    ]]);
                else
                    runHaxeCode([[
                        if (game.variables[']]..char.charName..[['].hasMissAnimations) {
                            var animToPlay:String = game.singAnimations[Std.int(Math.abs(]]..noteData..[[))] + 'miss';
                            game.variables[']]..char.charName..[['].playAnim(animToPlay + ']]..note.animSuffix..[[', true);
                        }
                    ]]);
                end
            end
        end
    end
end
function noteMissPress(direction)
    for i, char in ipairs(characters) do
        for j, note in ipairs(char.noteTypes) do
            if noteType == note.name then
                if isExtraKeys then
                    runHaxeCode([[
                        if (game.variables[']]..char.charName..[['].hasMissAnimations) {
                            game.variables[']]..char.charName..[['].playAnim('sing' + Note.keysShit.get(PlayState.mania).get('anims')[]]..direction..[[] + 'miss' + ']]..note.animSuffix..[[', true);
                        }
                    ]]);
                else
                    runHaxeCode([[
                        if (game.variables[']]..char.charName..[['].hasMissAnimations) {
                            game.variables[']]..char.charName..[['].playAnim(game.singAnimations[Std.int(Math.abs(]]..direction..[[))] + 'miss' + ']]..note.animSuffix..[[', true);
                        }
                    ]]);
                end
            end
        end
    end
end

local keysPressed = {false, false, false, false, false, false, false, false, false};

function onKeyPress(key)
    keysPressed[key+1] = true;
end
function onKeyRelease(key)
    keysPressed[key+1] = false;
end

function onUpdatePost(elapsed)
    local anyKeyPressed = false;
    for i, pressed in ipairs(keysPressed) do
        if pressed == true then
            anyKeyPressed = true;
            break;
        end
    end

    for i, char in ipairs(characters) do
        if char.group == 'boyfriendGroup' then
            if not botPlay then
                runHaxeCode([[
                    setVar('pressed', ]]..tostring(anyKeyPressed)..[[);

                    if (StringTools.startsWith(game.variables[']]..char.charName..[['].animation.curAnim.name, 'sing')) {
                        game.variables[']]..char.charName..[['].holdTimer += ]]..elapsed..[[;
                    }

                    if (!getVar('pressed') && game.variables[']]..char.charName..[['].holdTimer >= Conductor.stepCrochet * (0.0011 / (FlxG.sound.music != null ? FlxG.sound.music.pitch : 1)) * game.variables[']]..char.charName..[['].singDuration && game.variables[']]..char.charName..[['].animation.curAnim != null && StringTools.startsWith(game.variables[']]..char.charName..[['].animation.curAnim.name, 'sing') && !StringTools.endsWith(game.variables[']]..char.charName..[['].animation.curAnim.name, 'miss')) {
                        game.variables[']]..char.charName..[['].dance();
                        
                    } else if (getVar('pressed')) {
                        game.variables[']]..char.charName..[['].holdTimer = 0;
                    }
                ]]);
            end
        end
    end
end

-- yeah
function onStepHit()
    if curStep == 1024 then
        setProperty('playgf.alpha', 1)
        doTweenX('gfmovex', 'playgf', 1100, 2, 'circOut')
        doTweenY('gfmovey', 'playgf', 400, 2, 'circOut')
    end
end

function scaleChar(char, x, y)
    x = x or 1
    y = y or x
    if not scaleChar_init then
      addHaxeLibrary('FunkinLua')
      addHaxeLibrary('Character')
      runHaxeCode([[
        function setProperty(variable:String, value:Dynamic):Bool
        {
          if(getProperty(variable, true) == null)
            return;
          var killMe:Array<String> = variable.split('.');
          if(killMe.length > 1) {
            FunkinLua.setVarInArray(FunkinLua.getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1], value);
            return true;
          }
          FunkinLua.setVarInArray(FunkinLua.getInstance(), variable, value);
          return true;
        }
        function getProperty(variable:String):Dynamic
        {
          var result:Dynamic = null;
          var killMe:Array<String> = variable.split('.');
          if(killMe.length > 1)
            result = FunkinLua.getVarInArray(FunkinLua.getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
          else
            result = FunkinLua.getVarInArray(FunkinLua.getInstance(), variable);
          return result;
        }
      ]])
      scaleChar_init = true
    end
    runHaxeCode([[
      var char:String = "]]..char:gsub('"', '\\"')..[[";
      var scale:Array<Float> = ]]..('[' .. table.concat({x, y}, ',') .. ']')..[[;
      
      var dummyChar = new Character(0, 0, getProperty(char + '.curCharacter'));
      var offsets:Map<String, Array<Dynamic>> = dummyChar.animOffsets;
      dummyChar.kill();
      dummyChar.destroy();
      
      for(offset in offsets)
      {
        offset[0] *= scale[0];
        offset[1] *= scale[1];
      }
      
      setProperty(char + '.animOffsets', offsets);
      setProperty(char + '.scale.x', scale[0]);
      setProperty(char + '.scale.y', scale[1]);
    ]])
  end