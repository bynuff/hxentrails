package hxentrails.utils;

import hxentrails.builders.DescriptorBuilderExtensions;
import hxentrails.builders.DescriptorBuilder;
import hxentrails.data.TypedefDescription;

using hxentrails.builders.DescriptorBuilderExtensions;

class ScanExtensions {

    macro public static function describeTypedef(
        type:haxe.macro.Expr,
        ?factory:DescriptorFactoryDelegate,
        ?filter:Int = DescriptorFlag.ALL,
        ?store:Bool = true
    ):haxe.macro.Expr.ExprOf<TypedefDescription> {

        var descriptor = type.createDescriptorBuilder(DescriptorType.TYPEDEF)
            .withFilter(filter)
            .withFactory(factory)
            .build();

        descriptor.analyze();
        if (store) {
            descriptor.store();
        }

        // FIXME
        return macro descriptor.result;
    }

}
