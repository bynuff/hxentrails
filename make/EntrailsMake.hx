import hxmake.test.TestTask;
import hxmake.haxelib.HaxelibExt;
import hxmake.idea.IdeaPlugin;
import hxmake.haxelib.HaxelibPlugin;

using hxmake.haxelib.HaxelibPlugin;

class EcxMake extends hxmake.Module {

    function new() {
        config.classPath = ["src"];
        config.testPath = ["tests"];
        config.devDependencies = [
            "utest" => "haxelib"
        ];

        apply(HaxelibPlugin);
        apply(IdeaPlugin);

        library(function(ext:HaxelibExt) {
            ext.config.version = "0.0.1";
            ext.config.description = "Runtime type description.";
            ext.config.url = "https://github.com/bynuff/hxentrails";
            ext.config.tags = ["type description", "type info", "runtime type info", "rtti", "cross", "utility", "magic"];
            ext.config.contributors = ["bynuff"];
            ext.config.license = "MIT";
            ext.config.releasenote = "Initial release.";

            ext.pack.includes = ["src", "haxelib.json", "README.md"];
        });

        var tt = new TestTask();
        tt.debug = true;
        tt.targets = ["neko", "swf", "node", "js", "cpp", "java", "cs"];
        tt.libraries = ["hxentrails"];
        task("tests", tt);
    }

}