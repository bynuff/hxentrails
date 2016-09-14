package hxentrails.utils;

import haxe.macro.Expr;

import hxentrails.common.BinaryFilter;
import hxentrails.builders.BuilderFactory;
import hxentrails.descriptors.DescriptorFlag;
import hxentrails.descriptors.DescriptorType;

@:final
class ScanUtils {

    macro public static function describe(type:Expr, useCache:Bool, flags:Array<Expr>):Expr {
        // TODO: check descriptor type by expr
//        return describeType(type, useCache, makeDescriptorBinaryFilterFromExprs(flags), getDescriptorType(type));
        return macro null;
    }

    macro public static function describeTypedef(type:Expr, useCache:Bool, flags:Array<Expr>):Expr {
        return describeType(type, useCache, makeDescriptorBinaryFilterFromExprs(flags), DescriptorType.TYPEDEF);
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
#end

}
