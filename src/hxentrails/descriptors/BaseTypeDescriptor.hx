package hxentrails.descriptors;

#if macro

import haxe.macro.Expr;

class BaseTypeDescriptor implements IDescriptor {

    public var result(get, null):Expr;

    var _descriptionId:String;
    var _typeExpr:Expr;
    var _store:Bool;
    var _filter:DescriptorFilter;
    var _resultType:Class<Dynamic>;

    public function new(typeExpr:Expr, filter:DescriptorFilter, resultType:Class<Dynamic>, store:Bool) {
        _typeExpr = typeExpr;
        _filter = filter;
        _resultType = resultType;
        _store = store;
    }

    public function analyze() {
    }

    function get_result():Expr {
        if (_store) {
            return macro {
                hxentrails.storage.DescriptionStorage.tryGetOrCreate(
                    $v{_resultType},
                    $v{_descriptionId},
                    $v{_filter},
                    function () return $result
                );
            };
        }
        return result;
    }

}

#end
