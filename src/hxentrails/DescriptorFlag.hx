package hxentrails;

@:final
class DescriptorFlag {
    inline public static var CONSTRUCTOR:Int = 1 << 1;
    inline public static var VARIABLES:Int = 1 << 2;
    inline public static var PROPERTIES:Int = 1 << 3;
    inline public static var IMPLEMENTATIONS:Int = 1 << 4;
    inline public static var FUNCTIONS:Int = 1 << 5;
    inline public static var RUNTIME_META:Int = 1 << 6;
    inline public static var COMPILE_META:Int = 1 << 7;
    inline public static var ALL:Int = CONSTRUCTOR | VARIABLES | PROPERTIES | IMPLEMENTATIONS | FUNCTIONS | RUNTIME_META | COMPILE_META;
}
