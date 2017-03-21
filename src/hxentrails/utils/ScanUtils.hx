package hxentrails.utils;

import haxe.macro.Expr;

import hxentrails.descriptors.ScanOption;
import hxentrails.builders.BuilderFactory;
import hxentrails.builders.DescriptorBuilder;

@:final
class ScanUtils {

    macro public static function describe(type:Expr, useCache:Bool = false) {
        return processType(type, useCache);
    }

    #if macro
    public static function processType(
        type:Expr,
        useCache:Bool,
        ?options:Array<ScanOption>,
        ?descriptorFactory:DescriptorFactory
    ):Expr {
        var descriptor = BuilderFactory.createDescriptorBuilder(type)
            .withFactory(descriptorFactory)
            .withOptions(options)
            .withCache(useCache)
            .build();

        descriptor.analyze();

        return descriptor.result;
    }
    #end

}
