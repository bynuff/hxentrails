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
    public var position(default, null):{file:String, min:Int, max:Int};
    public var platforms(default, null):Array<String>;
    public var meta(default, null):Array<Metadata>;
    public var typeKind(default, null):TypeKind = TypeKind.UNDEFINED;

    public function new() {}

}

@:enum
abstract TypeKind(Int) from Int to Int {
    var UNDEFINED:Int = -1;
    var CLASS:Int = 0;
    var INTERFACE:Int = 1;
    var ENUM:Int = 2;
    var TYPEDEF:Int = 3;
}
