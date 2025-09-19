var SineBob = pc.createScript('sineBob');

SineBob.attributes.add('amplitude', {
    type: 'number',
    default: 1.0,
    title: 'Amplitude',
    description: 'The height of the sine wave'
});

SineBob.attributes.add('frequency', {
    type: 'number',
    default: 1.0,
    title: 'Frequency',
    description: 'The speed of the sine wave oscillation'
});

// initialize code called once per entity
SineBob.prototype.initialize = function() {
    // Store the entity's starting position to add the sine offset to
    this.initialY = this.entity.getPosition().y;
    this.time = 0;
};

// update code called every frame
SineBob.prototype.update = function(dt) {
    // Increment the time variable by the delta time (dt)
    this.time += dt;
    
    // Get the current position of the entity
    var position = this.entity.getPosition();
    
    // Calculate the sine offset based on time, frequency, and amplitude
    var yOffset = Math.sin(this.time * this.frequency) * this.amplitude;
    
    // Set the new y position
    position.y = this.initialY + yOffset;
    
    // Update the entity's position with the new value
    this.entity.setPosition(position);
};
