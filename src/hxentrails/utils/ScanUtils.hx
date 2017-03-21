package hxentrails.utils;

import haxe.macro.Expr;
import haxe.macro.Context;

import hxentrails.common.BinaryFilter;
import hxentrails.builders.BuilderFactory;
import hxentrails.descriptors.DescriptorFlag;
import hxentrails.descriptors.DescriptorType;

using hxentrails.utils.DescriptorUtils;

@:final
class ScanUtils {

    macro public static function describe(type:Expr, useCache:Bool, flags:Array<Expr>):Expr {
        return describeType(type, useCache, makeDescriptorBinaryFilterFromExprs(flags), getDescriptorType(type));
    }

    macro public static function describeTypedef(type:Expr, useCache:Bool, flags:Array<Expr>):Expr {
        if (getDescriptorType(type) != DescriptorType.TYPEDEF) {
            Context.error("Wrong type definition. It should be typedef only.", type.pos);
        }
        return describeType(type, useCache, makeDescriptorBinaryFilterFromExprs(flags), DescriptorType.TYPEDEF);
    }

    macro public static function describeClass(type:Expr, useCache:Bool, flags:Array<Expr>):Expr {
        if (getDescriptorType(type) != DescriptorType.CLASS) {
            Context.error("Wrong type definition. It should be class only.", type.pos);
        }
        return describeType(type, useCache, makeDescriptorBinaryFilterFromExprs(flags), DescriptorType.CLASS);
    }

#if macro
    inline static function describeType(
        type:Expr,
        useCache:Bool,
        filter:BinaryFilter,
        descriptorType:DescriptorType
    ):Expr {
        var descriptor = BuilderFactory.createDescriptorBuilder(type, descriptorType)
            .withFilter(filter)
            .withCache(useCache)
            .build();

        descriptor.analyze();

        return descriptor.result;
    }

    inline static function makeDescriptorBinaryFilterFromExprs(flags:Array<Expr>):BinaryFilter {
        return makeBinaryFilterFromExprs(flags, DescriptorFlag.parseFromExprs, [DescriptorFlag.ALL]);
    }

    inline static function makeBinaryFilterFromExprs(
        flags:Array<Expr>,
        parser:Array<Expr> -> Array<Int>,
        defaults:Array<Int>
    ):BinaryFilter {
        var filter = new BinaryFilter();
        filter += flags != null ? parser(flags) : defaults;
        return filter;
    }

    inline static function getDescriptorType(typeExpr:Expr):DescriptorType {
        return switch (typeExpr.getType()) {
            case TEnum(t, params):
                DescriptorType.ENUM;
            case TInst(t, params):
                DescriptorType.CLASS;
            case TType(t, params):
                DescriptorType.TYPEDEF;
//            case TFun(args, ret):
//            case TAnonymous(a):
//            case TDynamic(t):
//            case TLazy(f):
            case TAbstract(t, params):
                DescriptorType.ABSTRACT;
            case _:
                Context.error('Type ${typeExpr.getType()} not supported.', typeExpr.pos);
        }
    }
#end

}
