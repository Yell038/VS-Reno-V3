-- not guranteed to pfc most of time
-- script by raltyro
-- uh ok bye
local firstToggled = true
local pressDuration = 0.23 -- default 0.23
local holdDuration = 0.29 -- default 0.29
local maxDuration = 0.15 -- default 0.15
local randomPseudoTimingMS = 8 -- set to 0 for all pfc -- default 8
local accuracyTimingMS = 33 -- timing accuracy for hit -- default 33
local boundTimingMS = 165 -- bound timing accuracy for hit -- default 165

function onCreate()
	addHaxeLibrary("Math")
	addHaxeLibrary("FlxG", "flixel")
	addHaxeLibrary("Timer", "haxe")
	addHaxeLibrary("KeyboardEvent", "openfl.events")
	runHaxeCode([[
		_temp_pb_toggle = ]] .. tostring(firstToggled) .. [[ || game.cpuControlled;
		game.cpuControlled = false;
		pb_toggle = function() {
			_temp_pb_toggle = !_temp_pb_toggle;
		}

		pb_run = function() {
			if (game.cpuControlled) {
				game.cpuControlled = false;
				pb_toggle();
			}
		}
	]])
end

function onUpdate()
	if inGameOver then return end
	runHaxeCode("pb_run();")
end

function onSongStart()
	local rateratewoah = type(getProperty("playbackRate")) == "number"
	runHaxeCode([[
		var toggled = _temp_pb_toggle;
		pb_toggle = function() {
			toggled = !toggled;
			pb_stop();
		}

		var strums = [];
		var sperms = [];
		var rate = 1;
		var rate2 = 1;

		var reqNotes = [];
		var timers = [];
		var reqNote;
		var kps = 0;

		// i have to do this because of issues with vars not sync w hscripts and timers
		setVar("mnyaa~reqNotes", reqNotes);
		setVar("mnyaa~strums", strums);

		function fillKeysPressed() {
			for (i in 0...game.keysArray.length-strums.length) {
				strums.push(-1);
				sperms.push(false);
			}
		}
		fillKeysPressed();
		setVar("kpskpskpsnyanyauwu", 0);

		function unpress(data) {
			fillKeysPressed();

			setVar("nyanya~data", data);
			setVar("fuck you ffuwu", ClientPrefs.controllerMode);
			ClientPrefs.controllerMode = true;
			game.onKeyRelease(new KeyboardEvent("keyUp", true, true, -1, game.keysArray[data][0]));
			ClientPrefs.controllerMode = getVar("fuck you ffuwu");

			getVar("mnyaa~strums")[getVar("nyanya~data")] = -1;
		}
		function press(data) {
			fillKeysPressed();

			setVar("nyanya~data", data);
			if (strums[data] >= 0) unpress(data);
			setVar("fuck you ffuwu", ClientPrefs.controllerMode);
			ClientPrefs.controllerMode = true;
			game.onKeyPress(new KeyboardEvent("keyDown", true, true, -1, game.keysArray[data][0]));
			ClientPrefs.controllerMode = getVar("fuck you ffuwu");

			// same reason, vars sync issues
			setVar("kpskpskpsnyanyauwu", getVar("kpskpskpsnyanyauwu") + 1);
			getVar("mnyaa~strums")[getVar("nyanya~data")] = ]] .. pressDuration .. [[ / (getVar("mnyaa~reqNotes").length / 18 + 1);
			getVar("mnyaa~strums")[getVar("nyanya~data")] = getVar("mnyaa~strums")[getVar("nyanya~data")] < ]] .. maxDuration .. [[ ? ]] .. maxDuration .. [[ : getVar("mnyaa~strums")[getVar("nyanya~data")];
			//sperms[data] = true;
		}

		pb_stop = function(?bool) {
			var i = timers.length;
			while (--i >= 0) timers[i].stop();
			if (!bool) for (i in 0...strums.length) unpress(i);
			reqNotes.resize(0);
			timers.resize(0);
			kps = 0;
		}

		// at this point idc if the codes looks messy, atleast its still readable to me
		reqNote = function(note) {
			var dont = false;
			reqNotes.push(note);
			timers.push(Timer.delay(function() {
				if (!dont && strums[note.noteData] >= 0) unpress(note.noteData);
			}, Math.max(32, (note.strumTime - Conductor.songPosition) / (rate * rate2) - 112)));
			for (vnote in reqNotes) {
				if (vnote == note) continue;
				if (Math.abs(vnote.strumTime - note.strumTime) < 4) return;
			}
			var diff = (note.strumTime - Conductor.songPosition) / (rate * rate2) - 12 - (FlxG.elapsed * 130 / rate2) + FlxG.random.float(-]] .. randomPseudoTimingMS .. [[, ]] .. randomPseudoTimingMS .. [[);
			var foo = function() {
				if (diff >= ]] .. accuracyTimingMS .. [[ && (note.strumTime - Conductor.songPosition) / (rate * rate2) - 8 - (FlxG.elapsed * 400 / rate2) + FlxG.random.float(-]] .. randomPseudoTimingMS .. [[, ]] .. randomPseudoTimingMS .. [[) > ]] .. accuracyTimingMS .. [[) {
					reqNotes.remove(note);
					if (note.wasGoodHit) return;
					return reqNote(note);
				}

				var i = reqNotes.length;
				while (--i >= 0) {
					var rnote = reqNotes[i];
					if (rnote.wasGoodHit) {
						reqNotes.remove(rnote);
						continue;
					}
					if (rnote == note || Math.abs(rnote.strumTime - note.strumTime) < 4) {
						reqNotes.remove(rnote);
						if (strums[rnote.noteData] > 0) unpress(rnote.noteData);
						dont = true;
						press(rnote.noteData);
					}
				}
			}
			if (diff < ]] .. accuracyTimingMS .. [[) return foo();
			timers.push(Timer.delay(foo, diff));
		}

		var closestDis = 0;
		var closestNotes = [];
		function searchNotes(daNote) {
			if (daNote.isSustainNote) {
				if (game.generatedMusic && !game.inCutscene && game.strumsBlocked[daNote.noteData] != true && daNote.isSustainNote
				&& daNote.canBeHit && daNote.prevNote.wasGoodHit && daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit && !daNote.blockHit) {
					game.goodNoteHit(daNote);
					kps += .1;
					strums[daNote.noteData] = ]] .. holdDuration .. [[ / (reqNotes.length / 16 + 1);
					strums[daNote.noteData] = strums[daNote.noteData] < ]] .. maxDuration .. [[ ? ]] .. maxDuration .. [[ : strums[daNote.noteData];
					sperms[daNote.noteData] = true;
				}
				return;
			}
			if (daNote.blockHit || !daNote.mustPress || daNote.wasGoodHit || daNote.ignoreNote) return;
			var v = daNote.strumTime - Conductor.songPosition;
			var v2 = ]] .. boundTimingMS .. [[ - (strums[daNote.noteData] * 6531);
			if (v < (v2 < ]] .. accuracyTimingMS .. [[ ? ]] .. accuracyTimingMS .. [[ : v2) && (closestNotes.length <= 0 || v < closestDis)) {
				closestNotes.push(daNote);
				closestDis = v < 0 ? 0 : v;
			}
		}

		pb_run = function() {
			if (game.cpuControlled) {
				game.cpuControlled = false;
				game.botplayTxt.visible = false;
				pb_toggle();
			}
			if (!toggled) return;
			var prev = Conductor.songPosition;
			var prevRate = rate;
			var prevRate2 = rate2;
			]] .. (rateratewoah and "rate = game.playbackRate;") .. [[
			rate2 = FlxG.timeScale;
			if (prevRate != rate || prevRate2 != rate2) pb_stop(true);
			if (FlxG.sound.music != null && FlxG.sound.music.playing && !game.startingSong) Conductor.songPosition = FlxG.sound.music.time;//FlxG.sound.music._channel.position;
			else if (game.startedCountdown) Conductor.songPosition += FlxG.elapsed * 1000 * rate;
			closestNotes.resize(0);

			kps += getVar("kpskpskpsnyanyauwu");
			setVar("kpskpskpsnyanyauwu", 0);
			if (kps > 0) kps -= (FlxG.elapsed * rate) * (kps + 1) * 3.7;
			if (kps < 0) kps = 0;
			for (i in 0...strums.length) {
				if (strums[i] < 0) {
					if (!sperms[i]) continue;
					var spr = game.playerStrums.members[i];
					if (spr != null && spr.animation.curAnim.name != 'static') {
						spr.playAnim('static');
						spr.resetAnim = 0;
						sperms[i] = false;
					}
					continue;
				}

				strums[i] -= (FlxG.elapsed * rate) * (kps / 5.6 + 1);
				if (strums[i] < 0) unpress(i);
			}

			game.notes.forEachAlive(searchNotes);
			for (note in closestNotes) {
				if (!reqNotes.contains(note)) reqNote(note);
			}
			Conductor.songPosition = prev;
		}
		return;
	]])

	-- i purposely put these here ok
	function onDestroy()
		runHaxeCode("pb_stop();")
	end

	function onPause()
		runHaxeCode("pb_stop();")
	end

	function onGameOverStart()
		runHaxeCode("pb_stop();")
		onUpdate = nil
	end
end