package hxentrails.descriptors;

#if macro

import haxe.macro.Expr;

interface IDescriptor {
    var result(get, null):Expr;
    function analyze():Void;
}

#end
