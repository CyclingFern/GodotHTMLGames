var OrbitAround = pc.createScript('orbitAround');

// Editable attributes in the PlayCanvas editor
OrbitAround.attributes.add('target', { type: 'entity', title: 'Target Entity' });
OrbitAround.attributes.add('radius', { type: 'number', default: 5, title: 'Orbit Radius' });
OrbitAround.attributes.add('speed', { type: 'number', default: 1, title: 'Orbit Speed (rev/sec)' });
OrbitAround.attributes.add('axis', { type: 'vec3', default: [0, 1, 0], title: 'Orbit Axis' });

// Called once when the script is initialized
OrbitAround.prototype.initialize = function () {
    this.angle = 0;
};

// Called every frame
OrbitAround.prototype.update = function (dt) {
    if (!this.target) return;

    // Increase angle based on speed
    this.angle += dt * this.speed * 2 * Math.PI; // convert rev/sec to radians/sec

    // Calculate orbit position
    var targetPos = this.target.getPosition();
    var x = targetPos.x + Math.cos(this.angle) * this.radius;
    var z = targetPos.z + Math.sin(this.angle) * this.radius;

    // Keep Y the same as target (or adjust if you want vertical offset)
    var y = targetPos.y;

    this.entity.setPosition(x, y, z);

    // Optional: make the object face the target
    this.entity.lookAt(targetPos);
    this.entity.rotateLocal(-90, 0, 180);
};