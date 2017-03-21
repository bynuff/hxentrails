package hxentrails.builders;

#if macro

import haxe.macro.Expr;
import haxe.macro.Context;

import hxentrails.common.BinaryFilter;
import hxentrails.descriptors.IDescriptor;
import hxentrails.descriptors.DescriptorKind;
import hxentrails.descriptors.ClassDescriptor;
import hxentrails.descriptors.TypedefDescriptor;

@:final
class BuilderFactory {

    public static function createDescriptorBuilder(typeExpr:Expr):DescriptorBuilder {
        return new DescriptorBuilder(typeExpr, defaultDescriptorFactory);
    }

    static function defaultDescriptorFactory(
        typeExpr:Expr,
        descriptorType:DescriptorKind,
        filter:BinaryFilter,
        useCache:Bool
    ):IDescriptor {
        return switch (descriptorType) {
//            case DescriptorType.ENUM:
            case DescriptorKind.Class:
                new ClassDescriptor(typeExpr, filter, useCache);
            case DescriptorKind.Typedef:
                new TypedefDescriptor(typeExpr, filter, useCache);
//            case DescriptorType.ABSTRACT:
            case _:
                Context.error("Not supported descriptor type.", Context.currentPos());
        }
    }

}

#end
