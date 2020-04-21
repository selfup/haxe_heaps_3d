# notes

* smooth sprites: `s2d.defaultSmooth` (default is false)
* make it snow

```haxe
var parts = new h3d.parts.GpuParticles(world);
var group = parts.addGroup();
group.size = 0.2;
group.gravity = 1;
group.life = 10;
group.nparts = 10000;
group.emitMode = CameraBounds;
parts.volumeBounds = h3d.col.Bounds.fromValues(-20, -20, 15, 40, 40, 40);
```

* figure out how to make a valid FBX export from Blender
