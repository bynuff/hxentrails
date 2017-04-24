package hxentrails.descriptions;

class FieldsDescription extends BaseDescription {

    public var fields(default, null):Array<FieldInfo> = [];

}

typedef FieldInfo = {
    var name(default, null):String;
    var type(default, null):Class<Dynamic>;
    var isPublic(default, null):Bool;
    var isOverride(default, null):Bool;
    var readAccess(default, null):FieldAccess;
    var writeAccess(default, null):FieldAccess;
    var params(default, null):Array<String>;
    var platforms(default, null):Array<String>;
    var meta(default, null):Array<Metadata>;
    var line(default, null):Int;
    var overloads(default, null):Array<FieldInfo>;
    var isFunction(default, null):Bool;
}
