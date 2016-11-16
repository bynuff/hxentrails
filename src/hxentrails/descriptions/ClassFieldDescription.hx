package hxentrails.descriptions;

import hxentrails.descriptions.TypeInfo.TypeKind;

class ClassFieldDescription extends BaseDescription {

    public var fields(default, null):Array<ClassField>;

    public function new(typeKind:TypeKind) {
        super(typeKind);

        fields = [];
    }

}

typedef ClassField = {
    var name(default, null):String;
    var type(default, null):Class<Dynamic>;
    var isPublic(default, null):Bool;
    var isOverride(default, null):Bool;
    var readAccess(default, null):ClassFieldAccess;
    var writeAccess(default, null):ClassFieldAccess;
    var params(default, null):Array<String>;
    var platforms(default, null):Array<String>;
    var meta(default, null):Array<Metadata>;
    var line(default, null):Null<Int>;
    var overloads(default, null):Array<ClassField>;
    var isFunction(default, null):Bool;
}

@:enum
abstract ClassFieldAccess(Int) from Int to Int {
    var NORMAL:Int = 0;
    var NO:Int = 1;
    var NEVER:Int = 2;
    var RESOLVE:Int = 3;
    var CALL:Int = 4;
    var INLINE:Int = 5;
    var REQUIRE:Int = 6;
}
