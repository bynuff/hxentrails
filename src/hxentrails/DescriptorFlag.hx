package hxentrails;

@:enum
abstract DescriptorFlag(Int) from Int to Int {
    var CONSTRUCTOR:Int = 1 << 1;
    var VARIABLES:Int = 1 << 2;
    var PROPERTIES:Int = 1 << 3;
    var IMPLEMENTATIONS:Int = 1 << 4;
    var FUNCTIONS:Int = 1 << 5;
    var RUNTIME_META:Int = 1 << 6;
    var COMPILE_META:Int = 1 << 7;
    var ALL:Int = CONSTRUCTOR | VARIABLES | PROPERTIES | IMPLEMENTATIONS | FUNCTIONS | RUNTIME_META | COMPILE_META;
}
