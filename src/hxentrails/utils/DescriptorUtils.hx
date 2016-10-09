package hxentrails.utils;

#if macro

import Type in StdType;

import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.Context;

using haxe.macro.ExprTools;

@:final
class DescriptorUtils {

    inline public static function getTypeName(typeExpr:Expr):String {
        return typeExpr.toString();
    }

    inline public static function getType(typeExpr:Expr):Type {
        return getTypeByName(getTypeName(typeExpr), typeExpr.pos);
    }

    inline public static function getTypeByName(typeName:String, pos:Position):Type {
        return try {
            Context.getType(typeName);
        } catch (e:Dynamic) {
            Context.error('Type with name $typeName is not exist.', pos);
        }
    }

    inline public static function getTypePathFromClass(type:Class<Dynamic>):TypePath {
        var typeName = StdType.getClassName(type);
        var macroType = getTypeByName(typeName, Context.currentPos());

        return switch (macroType) {
            case TInst(t, _) if (t.get() != null):
                {
                    pack: t.get().pack,
                    name: t.get().name
                }
            case _:
                Context.error('Can not execute type path from $typeName', Context.currentPos());
        }
    }

    inline public static function getBaseType(typeExpr:Expr):BaseType {
        return try {
            switch (Context.getType(getTypeName(typeExpr))) {
                case TInst(ref, _):
                    ref.get();
                case TType(ref, _):
                    ref.get();
                case _:
                    null;
            }
        } catch (e:Dynamic) {
            null;
        }
    }

}

#end
