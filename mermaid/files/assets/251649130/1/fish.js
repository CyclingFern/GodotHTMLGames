var Fish = pc.createScript('fish');

Fish.attributes.add('target', {
    type: 'entity',
    title: 'Target Position'
});


// initialize code called once per entity
Fish.prototype.initialize = function() {
    this.speed = 0.5;
};

// update code called every frame
Fish.prototype.update = function(dt) {
    if (this.target) {
        this.entity.lookAt(this.target.position)

        this.entity.translateLocal(0, 0, -this.speed * dt);
    }
};

// uncomment the swap method to enable hot-reloading for this script
// update the method body to copy state from the old instance
// Fish.prototype.swap = function(old) { };

// learn more about scripting here:
// https://developer.playcanvas.com/user-manual/scripting/