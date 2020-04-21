import hl.types.IntMap;
import hxd.Key in K;

class Main extends hxd.App {
	var world:h3d.scene.World;
	var shadow:h3d.pass.DefaultShadowMap;

	override function init() {
		world = new h3d.scene.World(64, 128, s3d);
		var tree = world.loadModel(hxd.Res.tree);
		var rock = world.loadModel(hxd.Res.rock);

		for (i in 0...1000) {
			var worldModel = Std.random(2) == 0 ? tree : rock;
			var x = Math.random() * 128;
			var y = Math.random() * 128;
			var z = 0;
			var scale = 1.2 + hxd.Math.srand(0.4);
			var roation = hxd.Math.srand(Math.PI);

			world.add(worldModel, x, y, z, roation, scale);
		}

		world.done();

		new h3d.scene.fwd.DirLight(new h3d.Vector(0.3, -0.4, -0.9), s3d);
		s3d.lightSystem.ambientLight.setColor(0x909090);

		s3d.camera.target.set(72, 72, 0);
		s3d.camera.pos.set(120, 120, 40);

		shadow = s3d.renderer.getPass(h3d.pass.DefaultShadowMap);
		shadow.size = 2048;
		shadow.power = 200;
		shadow.blur.radius = 0;
		shadow.bias *= 0.1;
		shadow.color.set(0.7, 0.7, 0.7);

		#if castle
		new hxd.inspect.Inspector(s3d);
		#end

		s3d.camera.zNear = 1;
		s3d.camera.zFar = 100;
		new h3d.scene.CameraController(s3d).loadFromCamera();
	}

	static function main() {
		hxd.Res.initEmbed();
		new Main();
	}
}
