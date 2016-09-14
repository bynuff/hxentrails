package hxentrails.descriptors;

#if macro

import haxe.macro.Expr;

interface IDescriptor {

    var result(get, never):Expr;

    function analyze():Void;

}

#end
