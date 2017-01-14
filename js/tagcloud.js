function addLoadEvent(func) {
    var oldonload = window.onload;
    if (typeof window.onload != 'function') {
        window.onload = func;
    } else {
        window.onload = function() {
            oldonload();
            func();
        }
    }
}
addLoadEvent(function() {
    console.log('tag cloud plugin rock and roll!');
    try {
        TagCanvas.textFont = 'Trebuchet MS, Helvetica';
        TagCanvas.textColour = '\#222';
        TagCanvas.textHeight = 13;
        TagCanvas.outlineColour = '\#FFF';
        TagCanvas.outlineMethod = 'block';
        TagCanvas.maxSpeed = 0.05;
        TagCanvas.minBrightness = 0.2;
        TagCanvas.depth = 1;
        TagCanvas.pulsateTo = 0.8;
        TagCanvas.initial = [0.1, -0.1];
        TagCanvas.decel = 0.98;
        TagCanvas.reverse = true;
        TagCanvas.hideTags = false;
        TagCanvas.shadow = '#ccc';
        TagCanvas.shadowBlur = 1;
        TagCanvas.weight = false;
        TagCanvas.imageScale = null;
        TagCanvas.fadeIn = 1000;
        TagCanvas.clickToFront = 600;
        TagCanvas.Start('resCanvas');
        TagCanvas.tc['resCanvas'].Wheel(false)
    } catch(e) {
        console.log(e);
        document.getElementById('myCanvasContainer').style.display = 'none';
    }
});
