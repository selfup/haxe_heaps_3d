import hl.types.IntMap;
import hxd.Key in K;

class Main extends hxd.App {
	var world:h3d.scene.World;
	var shadow:h3d.pass.DefaultShadowMap;

	override function init() {
		world = new h3d.scene.World(64, 128, s3d);

		var cube = world.loadModel(hxd.Res.xx);

		for (i in 0...1000) {
			addToWorld(cube);
		}

		world.done();

		new h3d.scene.fwd.DirLight(new h3d.Vector(0.3, -0.4, -0.9), s3d);
		s3d.lightSystem.ambientLight.setColor(0x909090);

		s3d.camera.target.set(72, 72, 0);
		s3d.camera.pos.set(120, 120, 40);

		shadows();

		#if castle
		new hxd.inspect.Inspector(s3d);
		#end

		snow();

		s3d.camera.zNear = 1;
		s3d.camera.zFar = 100;
		new h3d.scene.CameraController(s3d).loadFromCamera();
	}

	function snow() {
		var parts = new h3d.parts.GpuParticles(world);
		var group = parts.addGroup();
		group.size = 0.2;
		group.gravity = 1;
		group.life = 10;
		group.nparts = 10000;
		group.emitMode = CameraBounds;
		parts.volumeBounds = h3d.col.Bounds.fromValues(-20, -20, 15, 40, 40, 40);
	}

	function shadows() {
		shadow = s3d.renderer.getPass(h3d.pass.DefaultShadowMap);
		shadow.size = 2048;
		shadow.power = 200;
		shadow.blur.radius = 0;
		shadow.bias *= 0.1;
		shadow.color.set(0.7, 0.7, 0.7);
	}

	function addToWorld(element) {
		var x = Math.random() * 128;
		var y = Math.random() * 128;
		var z = 0;
		var scale = 1.0;
		var rotation = hxd.Math.srand(Math.PI);

		world.add(element, x, y, z, scale, rotation);
	}

	static function main() {
		hxd.Res.initEmbed();
		new Main();
	}
}
