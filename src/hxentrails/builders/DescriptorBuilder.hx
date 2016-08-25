package hxentrails.builders;

import haxe.macro.Expr;

import hxentrails.descriptors.IDescriptor;

typedef DescriptorFactoryDelegate = Expr -> DescriptorType -> Int -> IDescriptor;

@:final
class DescriptorBuilder {

    var _typeExpr:Expr;
    var _filter:Int = DescriptorFlag.ALL;
    var _descriptorType:DescriptorType;
    var _factoryDelegate:DescriptorFactoryDelegate;

    function new(
        typeExpr:Expr,
        descriptorType:DescriptorType,
        defaultFactoryDelegate:DescriptorFactoryDelegate
    ) {
        _typeExpr = typeExpr;
        _descriptorType = descriptorType;
        _factoryDelegate = defaultFactoryDelegate;
    }

    public function withFactory(factoryDelegate:DescriptorFactoryDelegate):DescriptorBuilder {
        _factoryDelegate = factoryDelegate;
        return this;
    }

    public function withFilter(filter:Int):DescriptorBuilder {
        _filter = filter;
        return this;
    }

    public function build():IDescriptor {
        return _factoryDelegate(_typeExpr, _descriptorType, _filter);
    }

}
