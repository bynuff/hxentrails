package hxentrails.descriptions;

@:enum
abstract TypeKind(Int) from Int to Int {
    var Undefined:Int = -1;
    var Class:Int = 0;
    var Interface:Int = 1;
    var Enum:Int = 2;
    var Typedef:Int = 3;
}