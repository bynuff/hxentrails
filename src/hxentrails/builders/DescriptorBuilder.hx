package hxentrails.builders;

#if macro

import haxe.macro.Expr;

import hxentrails.descriptors.IDescriptor;

typedef DescriptorFactoryDelegate = Expr -> DescriptorType -> DescriptorFilter -> Bool -> IDescriptor;

@:final
class DescriptorBuilder {

    var _typeExpr:Expr;
    var _store:Bool;
    var _filter:DescriptorFilter;
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
        _filter = new DescriptorFilter(DescriptorFlag.ALL);
    }

    public function withFactory(factoryDelegate:DescriptorFactoryDelegate):DescriptorBuilder {
        _factoryDelegate = factoryDelegate;
        return this;
    }

    public function withFilter(filter:DescriptorFilter):DescriptorBuilder {
        if (filter != 0) {
            _filter = filter;
        }
        return this;
    }

    public function storeResult(store:Bool):DescriptorBuilder {
        _store = store;
        return this;
    }

    public function build():IDescriptor {
        return _factoryDelegate(_typeExpr, _descriptorType, _filter, _store);
    }

}

#end
