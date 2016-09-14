package hxentrails.descriptors;

#if macro
import haxe.macro.Expr;
import haxe.macro.Context;
#end

@:enum
abstract DescriptorFlag(Int) from Int to Int {
    var CONSTRUCTOR:Int = 1 << 1;
    var VARIABLES:Int = 1 << 2;
    var PROPERTIES:Int = 1 << 3;
    var IMPLEMENTATIONS:Int = 1 << 4;
    var FUNCTIONS:Int = 1 << 5;
    var RUNTIME_META:Int = 1 << 6;
    var COMPILE_META:Int = 1 << 7;

    public static var ALL:Int =
        CONSTRUCTOR | VARIABLES | PROPERTIES
        | IMPLEMENTATIONS | FUNCTIONS
        | RUNTIME_META | COMPILE_META;

#if macro
    public static function parseFromExprs(flags:Array<Expr>):Array<DescriptorFlag> {
        return [for (flag in flags) parseFromExpr(flag)];
    }

    public static function parseFromExpr(flag:Expr):DescriptorFlag {
        return switch (flag.expr) {
            case EField(
                e = {expr: EConst(CIdent("DescriptorFlag")), pos: _},
                field = "ALL" | "CONSTRUCTOR" | "VARIABLES" | "PROPERTIES"
                        | "IMPLEMENTATIONS" | "FUNCTIONS" | "RUNTIME_META"
                        | "COMPILE_META"
            ):
                switch (field) {
                    case "ALL":
                        DescriptorFlag.ALL;
                    case "CONSTRUCTOR":
                        DescriptorFlag.CONSTRUCTOR;
                    case "VARIABLES":
                        DescriptorFlag.VARIABLES;
                    case "PROPERTIES":
                        DescriptorFlag.PROPERTIES;
                    case "IMPLEMENTATIONS":
                        DescriptorFlag.IMPLEMENTATIONS;
                    case "FUNCTIONS":
                        DescriptorFlag.FUNCTIONS;
                    case "RUNTIME_META":
                        DescriptorFlag.RUNTIME_META;
                    case "COMPILE_META":
                        DescriptorFlag.COMPILE_META;
                    case _:
                        Context.error("Wrong descriptor flag value. Use only DescriptorFlag.", flag.pos);
                }
            case _:
                Context.error("Wrong descriptor flag value. Use only DescriptorFlag.", flag.pos);
        }
    }
#end

}
