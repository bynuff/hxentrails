package hxentrails.descriptions;

class Metadata {

    public var name(default, null):String;
    // TODO:
    public var params(default, null):Array<Dynamic>;

    public function new(name:String, params:Array<Dynamic>) {
        this.name = name;
        this.params = params;
    }

}
