package hxentrails.descriptions;

class Metadata {

    public var name(default, null):String;
    public var params(default, null):Array<Dynamic>;
    public var isRuntime(default, null):Bool;

    public function new(name:String, params:Array<Dynamic>, isRuntime:Bool) {
        this.name = name;
        this.params = params;
        this.isRuntime = isRuntime;
    }

}
