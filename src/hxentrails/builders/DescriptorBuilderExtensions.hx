package hxentrails.builders;

import haxe.macro.Expr;

import hxentrails.descriptors.IDescriptor;
import hxentrails.builders.DescriptorBuilder;
import hxentrails.descriptors.TypedefDescriptor;

@:final
class DescriptorBuilderExtensions {

    @:access(hxentrails.builders.DescriptorBuilder)
    public static function createDescriptorBuilder(
        typeExpr:Expr,
        descriptorType:DescriptorType
    ):DescriptorBuilder {
        return new DescriptorBuilder(typeExpr, descriptorType, defaultDescriptorFactory);
    }

    static function defaultDescriptorFactory(typeExpr:Expr, descriptorType:DescriptorType, filter:Int):IDescriptor {
        return switch (descriptorType) {
//            case DescriptorType.ENUM:
//            case DescriptorType.CLASS:
            case DescriptorType.TYPEDEF:
               new TypedefDescriptor();
//            case DescriptorType.ABSTRACT:
//            case DescriptorType.INTERFACE:
            case _:
                // TODO: throw error
                null;
        }
    }

}
