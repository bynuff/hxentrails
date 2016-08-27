package hxentrails.builders;

#if macro

import haxe.macro.Expr;

import hxentrails.descriptors.IDescriptor;
import hxentrails.builders.DescriptorBuilder;
import hxentrails.descriptors.TypedefDescriptor;

@:final
class DescriptorBuilderExtensions {

    public static function createDescriptorBuilder(
        typeExpr:Expr,
        descriptorType:DescriptorType
    ):DescriptorBuilder {
        return new DescriptorBuilder(typeExpr, descriptorType, defaultDescriptorFactory);
    }

    static function defaultDescriptorFactory(
        typeExpr:Expr,
        descriptorType:DescriptorType,
        filter:DescriptorFilter,
        store:Bool
    ):IDescriptor {
        return switch (descriptorType) {
//            case DescriptorType.ENUM:
//            case DescriptorType.CLASS:
            case DescriptorType.TYPEDEF:
               new TypedefDescriptor(typeExpr, filter, store);
//            case DescriptorType.ABSTRACT:
//            case DescriptorType.INTERFACE:
            case _:
                // TODO: throw error
                null;
        }
    }

}

#end
