package hxentrails.utils;

#if macro

import sys.FileSystem;
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
        };
    }

    inline public static function getTypePathFromTypeExpr(typeExpr:Expr):String {
        return getTypePathFromBaseType(getBaseType(typeExpr));
    }

    inline public static function getTypeModuleFromTypeExpr(typeExpr:Expr):String {
        return try {
            getBaseType(typeExpr).module;
        } catch (e:Dynamic) {
            null;
        };
    }

    inline public static function getTypePathFromBaseType(baseType:BaseType):String {
        try {
            return baseType.module + "." + baseType.name;
        } catch (e:Dynamic) {
//             throw
            return null;
        }
    }

    inline public static function getFileFullPath(typeExpr:Expr):String {
        return try {
            FileSystem.fullPath(Context.getPosInfos(getBaseType(typeExpr).pos).file);
        } catch (e:Dynamic) {
            null;
        };
    }

    inline public static function getBaseType(typeExpr:Expr):BaseType {
        try {
            return switch (Context.getType(getTypeName(typeExpr))) {
                case TInst(ref, _):
                    ref.get();
                case TType(ref, _):
                    ref.get();
                case _:
                    null;
            }
        } catch (e:Dynamic) {
//            throw
            return null;
        }
    }

}

#end
