package hxentrails.descriptions;

class TypeInfo {

    public var type(default, null):Class<Dynamic>;
    public var typeName(default, null):String;
    public var typePath(default, null):String;
    public var module(default, null):String;
    public var file(default, null):String;
    // TODO replace String to TypeInfo
    public var params(default, null):Array<String>;
    public var isPrivate(default, null):Bool = false;
    public var isExtern(default, null):Bool = false;
    public var position(default, null):Position;
    public var platforms(default, null):Array<String>;
    public var meta(default, null):Array<Metadata>;
    public var typeKind(default, null):TypeKind;

    public function new() {}

}

typedef Position = {
    var file:String;
    var min:Int;
    var max:Int;
}
