function onCreatePost()
    setTextString("centerMark", "- coolio. -")
    setProperty("camHUD.y", 700)
    setProperty("camHUD.alpha", 0)
    doTweenY("muahahadadf", "camHUD", 0, 2.5, "circOut")
    doTweenAlpha("muahahadadf2", "camHUD", 1, 3.5, "linear")
end