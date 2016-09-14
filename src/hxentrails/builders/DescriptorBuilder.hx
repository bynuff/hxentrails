package hxentrails.builders;

#if macro

import haxe.macro.Expr;

import hxentrails.common.BinaryFilter;
import hxentrails.descriptors.IDescriptor;
import hxentrails.descriptors.DescriptorType;

typedef DescriptorFactoryDelegate = Expr -> DescriptorType -> BinaryFilter -> Bool -> IDescriptor;

@:final
class DescriptorBuilder {

    var _typeExpr:Expr;
    var _useCache:Bool;
    var _filter:BinaryFilter;
    var _descriptorType:DescriptorType;
    var _factoryDelegate:DescriptorFactoryDelegate;

    public function new(
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

    public function withFilter(filter:BinaryFilter):DescriptorBuilder {
        _filter = filter;
        return this;
    }

    public function withCache(useCache:Bool):DescriptorBuilder {
        _useCache = useCache;
        return this;
    }

    public function build():IDescriptor {
        return _factoryDelegate(_typeExpr, _descriptorType, _filter, _useCache);
    }

}

#end
