package hxentrails.descriptions;

@:enum
abstract FieldAccess(Int) from Int to Int {
    var Normal:Int = 0;
    var No:Int = 1;
    var Never:Int = 2;
    var Resolve:Int = 3;
    var Call:Int = 4;
    var Inline:Int = 5;
    var Require:Int = 6;
}
