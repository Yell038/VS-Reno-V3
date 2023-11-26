HITBOX = 80 -- Edit this!

function onCreatePost()
	luaDebugMode = true

	addHaxeLibrary('Note')
	addHaxeLibrary('Conductor')
	addHaxeLibrary('Math')
	addHaxeLibrary('Std')

	runHaxeCode([[
		sortedNotesList = [];

		// The real way to remove original inputs (To save performance)
		// "keyDown" is KeyboardEvent.KEY_DOWN, "keyUp" is KeyboardEvent.KEY_UP.
		FlxG.stage.removeEventListener("keyDown", game.onKeyPress);
		FlxG.stage.removeEventListener("keyUp", game.onKeyRelease);
	]])
end

function onUpdate(elapsed)
	runHaxeCode([[
		if (!game.cpuControlled) {
			for (i in 0...4) {
				if (!game.strumsBlocked[i]) {
					if (FlxG.keys.anyJustPressed(ClientPrefs.copyKey(ClientPrefs.keyBinds.get(['note_left', 'note_down', 'note_up', 'note_right'][i])))) {
						if (game.playerStrums.members[i].animation.curAnim.name != 'confirm') {
							game.playerStrums.members[i].playAnim('pressed');
							game.playerStrums.members[i].resetAnim = 0;
						}
						for (note in game.notes.members) {
							if ((note.noteData == i) && (note.strumTime - Conductor.songPosition) < ]] .. HITBOX .. [[ && (note.strumTime - Conductor.songPosition) > ]] .. -HITBOX .. [[
								&& note.mustPress && !note.isSustainNote && note.canBeHit && !note.tooLate) {
								sortedNotesList.push(note);
							}
						}
						if (sortedNotesList.length > 0) {
							game.goodNoteHit(sortedNotesList[sortedNotesList.length-1]);
							for (epicNote in sortedNotesList) sortedNotesList.remove(epicNote);
						} else {
							if (!ClientPrefs.ghostTapping) {
								// Just ported this private function to hscript
								noteMissPress = function(direction:Int = 1) {
									if (!game.boyfriend.stunned)
									{
										game.health -= 0.05 * game.healthLoss;
										if(game.instakillOnMiss)
										{
											game.vocals.volume = 0;
											game.doDeathCheck(true);
										}
			
										if (game.combo > 5 && game.gf != null && game.gf.animOffsets.exists('sad'))
										{
											game.gf.playAnim('sad');
										}
										game.combo = 0;
			
										if(!game.practiceMode) game.songScore -= 10;
										if(!game.endingSong) {
											game.songMisses++;
										}
										game.totalPlayed++;
										game.RecalculateRating(true);
			
										FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));
										if(game.boyfriend.hasMissAnimations) {
											game.boyfriend.playAnim(game.singAnimations[Std.int(Math.abs(direction))] + 'miss', true);
										}
										game.vocals.volume = 0;
									}
								}
								noteMissPress(i);
							}
						}
						if (Conductor.songPosition > 0) Conductor.songPosition = FlxG.sound.music.time;
					}

					if (FlxG.keys.anyPressed(ClientPrefs.copyKey(ClientPrefs.keyBinds.get(['note_left', 'note_down', 'note_up', 'note_right'][i])))) {
						for (note in game.notes.members) {
							if ((note.noteData == i) && (note.strumTime - Conductor.songPosition) < Conductor.stepCrochet && (note.strumTime - Conductor.songPosition) > -Conductor.stepCrochet
								&& note.mustPress && note.isSustainNote && note.canBeHit && !note.tooLate) {
								game.goodNoteHit(note);
							}
						}
					}

					if (FlxG.keys.anyJustReleased(ClientPrefs.copyKey(ClientPrefs.keyBinds.get(['note_left', 'note_down', 'note_up', 'note_right'][i])))) {
						game.playerStrums.members[i].playAnim('static');
					}
				} else {
					game.playerStrums.members[i].playAnim('static');
				}
			}
		}
	]])
end