package hxentrails.utils;

import hxentrails.builders.DescriptorBuilderExtensions;
import hxentrails.builders.DescriptorBuilder;
import hxentrails.data.TypedefDescription;

using hxentrails.builders.DescriptorBuilderExtensions;
using hxentrails.utils.DescriptorUtils;

class ScanExtensions {

//    macro public static function describeTypedefFunc(type:haxe.macro.Expr):haxe.macro.Expr.ExprOf<TypedefDescription> {
//        var filter = new DescriptorFilter();
//        filter += [DescriptorFlag.COMPILE_META, DescriptorFlag.FUNCTIONS];
//        return describeTypedef(type, filter);
//    }

    macro public static function describeTypedef(
        type:haxe.macro.Expr,
        store:Bool,
        filter:Array<haxe.macro.Expr>
    ):haxe.macro.Expr.ExprOf<TypedefDescription> {

        var descriptor = type.createDescriptorBuilder(DescriptorType.TYPEDEF)
            .withFilter(filter.createFilter())
//            .withFactory(factory)
            .storeResult(store)
            .build();

        descriptor.analyze();

        return descriptor.result;
    }

}
