package hxentrails.descriptions;

class TypeInfo {

    public var type(default, null):Class<Dynamic>;
    public var typeName(default, null):String;
    public var typePath(default, null):String;
    public var module(default, null):String;
    public var file(default, null):String;
    public var params(default, null):Array<TypeInfo>;
    public var isPrivate(default, null):Bool = false;
    public var platforms(default, null):Array<String>;
    public var meta(default, null):Array<Metadata>;
    public var kind(default, null):TypeKind = TypeKind.NONE;

    public function new() {}

}

@:enum
abstract TypeKind(Int) from Int to Int {
    var NONE:Int = -1;
    var CLASS:Int = 0;
    var INTERFACE:Int = 1;
    var ENUM:Int = 2;
    var TYPEDEF:Int = 3;
}
