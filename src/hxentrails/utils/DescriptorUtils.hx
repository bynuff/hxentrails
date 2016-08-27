package hxentrails.utils;

#if macro

import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.Context;

using haxe.macro.ExprTools;

@:final
class DescriptorUtils {

    public static function getTypeName(typeExpr:Expr):String {
        return typeExpr.toString();
    }

    public static function getType(typeExpr:Expr):Type {
        return getTypeByName(getTypeName(typeExpr), typeExpr.pos);
    }

    public static function getTypeByName(typeName:String, pos:Position):Type {
        return try {
            Context.getType(typeName);
        } catch (e:Dynamic) {
            Context.error('Type with name $typeName is not exist.', pos);
        }
    }

    public static function createFilter(flagsExpr:Array<Expr>):DescriptorFilter {
        var filter = new DescriptorFilter();
        var flags = [];
        for (flag in flagsExpr) {
            switch (flag.expr) {
                case EField(e = {expr: EConst(CIdent("DescriptorFlag")), pos: _}, field = "ALL" | "CONSTRUCTOR" | "VARIABLES" | "PROPERTIES" | "IMPLEMENTATIONS" | "FUNCTIONS" | "RUNTIME_META" | "COMPILE_META"):
                    switch (field) {
                        case "ALL":
                            flags.push(DescriptorFlag.ALL);
                        case "CONSTRUCTOR":
                            flags.push(DescriptorFlag.CONSTRUCTOR);
                        case "VARIABLES":
                            flags.push(DescriptorFlag.VARIABLES);
                        case "PROPERTIES":
                            flags.push(DescriptorFlag.PROPERTIES);
                        case "IMPLEMENTATIONS":
                            flags.push(DescriptorFlag.IMPLEMENTATIONS);
                        case "FUNCTIONS":
                            flags.push(DescriptorFlag.FUNCTIONS);
                        case "RUNTIME_META":
                            flags.push(DescriptorFlag.RUNTIME_META);
                        case "COMPILE_META":
                            flags.push(DescriptorFlag.COMPILE_META);
                        case _:
                    }
                case _: Context.error("Wrong descriptor flag value.", flag.pos);
            }
        }
        return filter += flags;
    }

//    public static function getTypeQalifiedName(classType:ClassType):String {
//        try {
//            return classType.module + "." + classType.name;
//        } catch (e:Dynamic) {
//            // throw
//            return null;
//        }
//    }
//
//    public static function getClassType(type:Expr):ClassType {
//        try {
//            return switch (Context.getType(type.toString())) {
//                case TInst(ref, _):
//                    ref.get();
//                case _:
//                    null;
//            }
//        } catch (e:Dynamic) {
//            throw
//            return null;
//        }
//    }

}

#end
