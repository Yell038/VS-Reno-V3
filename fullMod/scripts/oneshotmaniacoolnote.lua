local lart

local angleImpact = false --controls wheter the side notes get rotated on note hit

function onCreatePost()
    if downscroll then
        lart = 1
    else
        lart = -1
    end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    setPropertyFromGroup('playerStrums', noteData, 'y', getPropertyFromGroup('playerStrums', noteData, 'y') + (5 * lart))

    noteTweenY('woe'..noteData, 4 + noteData, defaultPlayerStrumY1, 1, 'cubeOut')

    if angleImpact then

        if noteData == 0 then
            setPropertyFromGroup('playerStrums', 0, 'angle', getPropertyFromGroup('playerStrums', 0, 'angle') - (10))

            noteTweenAngle('larty'..noteData, 4, 0, 1, 'cubeOut')
        end

        if noteData == 3 then
            setPropertyFromGroup('playerStrums', 3, 'angle', getPropertyFromGroup('playerStrums', 3, 'angle') + (10))

            noteTweenAngle('larty2'..noteData, 7, 0, 1, 'cubeOut')
        end

    end
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    setPropertyFromGroup('opponentStrums', noteData, 'y', getPropertyFromGroup('playerStrums', noteData, 'y') + (5 * lart))

    noteTweenY('woe2'..noteData, noteData, defaultPlayerStrumY1, 1, 'cubeOut')

    if angleImpact then

        if noteData == 0 then
            setPropertyFromGroup('opponentStrums', 0, 'angle', getPropertyFromGroup('playerStrums', 0, 'angle') - (10))

            noteTweenAngle('larty3'..noteData, noteData, 0, 1, 'cubeOut')
        end

        if noteData == 3 then
            setPropertyFromGroup('opponentStrums', 3, 'angle', getPropertyFromGroup('playerStrums', 3, 'angle') + (10))

            noteTweenAngle('larty4'..noteData, noteData, 0, 1, 'cubeOut')
        end
    
    end
    
end