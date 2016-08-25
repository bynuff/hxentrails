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
