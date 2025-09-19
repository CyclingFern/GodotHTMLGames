var TextureOscillator = pc.createScript('textureOscillator');

TextureOscillator.attributes.add('flowSpeed', {
    type: 'number',
    default: 0.1,
    title: 'Flow Speed'
});

TextureOscillator.prototype.initialize = function() {
    this.material = this.entity.render.meshInstances[0].material;
    this.flowOffset = 0;
};

TextureOscillator.prototype.update = function(dt) {
    this.flowOffset += this.flowSpeed * dt;
    this.material.diffuseMapOffset.set(-this.flowOffset, 0);
    this.material.normalMapOffset.set(this.flowOffset, 0);
    this.material.opacityMapOffset.set(this.flowOffset/2, 0);
    this.material.update();
};