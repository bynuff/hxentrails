package hxentrails.builders;

#if macro

import haxe.macro.Expr;
import haxe.macro.Context;

import hxentrails.common.BinaryFilter;
import hxentrails.descriptors.IDescriptor;
import hxentrails.descriptors.DescriptorType;
import hxentrails.descriptors.TypedefDescriptor;

@:final
class BuilderFactory {

    public static function createDescriptorBuilder(typeExpr:Expr, descriptorType:DescriptorType):DescriptorBuilder {
        return new DescriptorBuilder(typeExpr, descriptorType, defaultDescriptorFactory);
    }

    static function defaultDescriptorFactory(
        typeExpr:Expr,
        descriptorType:DescriptorType,
        filter:BinaryFilter,
        useCache:Bool
    ):IDescriptor {
        return switch (descriptorType) {
//            case DescriptorType.ENUM:
//            case DescriptorType.CLASS:
            case DescriptorType.TYPEDEF:
               new TypedefDescriptor(typeExpr, filter, useCache);
//            case DescriptorType.ABSTRACT:
//            case DescriptorType.INTERFACE:
            case _:
                Context.error("Not supported descriptor type.", Context.currentPos());
        }
    }

}

#end
