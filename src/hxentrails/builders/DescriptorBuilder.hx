package hxentrails.builders;

#if macro

import haxe.macro.Expr;

import hxentrails.common.BinaryFilter;
import hxentrails.descriptors.ScanOption;
import hxentrails.descriptors.IDescriptor;
import hxentrails.descriptors.DescriptorKind;

using hxentrails.utils.DescriptorExtensions;

typedef DescriptorFactory = Expr -> DescriptorKind -> BinaryFilter -> Bool -> IDescriptor;

@:final
class DescriptorBuilder {

    var _typeExpr:Expr;
    var _useCache:Bool;
    var _filter:BinaryFilter;
    var _factory:DescriptorFactory;

    public function new(typeExpr:Expr, defaultFactoryDelegate:DescriptorFactory) {
        _typeExpr = typeExpr;
        _factory = defaultFactoryDelegate;
        _filter = new BinaryFilter(ScanOption.All);
    }

    public function withFactory(factory:DescriptorFactory):DescriptorBuilder {
        if (factory != null) {
            _factory = factory;
        }
        return this;
    }

    public function withOptions(options:Array<ScanOption>):DescriptorBuilder {
        if (options != null && options.length > 0) {
            _filter = new BinaryFilter();
            _filter += options;
        }
        return this;
    }

    public function withCache(useCache:Bool):DescriptorBuilder {
        _useCache = useCache;
        return this;
    }

    public function build():IDescriptor {
        return _factory(_typeExpr, _typeExpr.getDescriptorType(), _filter, _useCache);
    }

}

#end
