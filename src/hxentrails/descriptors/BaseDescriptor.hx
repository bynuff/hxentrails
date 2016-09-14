package hxentrails.descriptors;

#if macro

import haxe.macro.Expr;
import haxe.macro.Context;

import hxentrails.common.BinaryFilter;
import hxentrails.descriptions.BaseDescription;

using hxentrails.utils.DescriptorUtils;

class BaseDescriptor implements IDescriptor {

    public var result(get, never):Expr;

    var _typeExpr:Expr;
    var _useCache:Bool;
    var _filter:BinaryFilter;
    var _specialTypeName:String;
    var _insertBlock:Array<Expr> = [];
    var _descriptionBaseType:Class<BaseDescription>;

    public function new(
        typeExpr:Expr,
        filter:BinaryFilter,
        descriptionBaseType:Class<BaseDescription>,
        useCache:Bool
    ) {
        _typeExpr = typeExpr;
        _filter = filter;
        _useCache = useCache;
        _descriptionBaseType = descriptionBaseType;
        _specialTypeName = NameConvention.createDescriptionTypeName(typeExpr, filter);
    }

    public function analyze() {
        if (DescriptorCache.has(_specialTypeName)) {
            return;
        }

        var specialType = createDescriptionSpecialType();

        parseType();

        Context.defineType(specialType);

        DescriptorCache.cache(_specialTypeName);
    }

    function createDescriptionSpecialType():TypeDefinition {
        var baseTypePath = _descriptionBaseType.getTypePath();
        return macro class $_specialTypeName extends $baseTypePath {

            static var __instance__;

            public function new() {
                super($v{_typeExpr.getTypeName()});
                initialize();
            }

            public function initialize() {
                $b{_insertBlock};
            }

            inline public static function __cachedInstance__() {
                if (__instance__ == null) {
                    __instance__ = __createInstance__();
                }
                return __instance__;
            }

            inline public static function __createInstance__() {
                return ${Context.parse('new $_specialTypeName()', _typeExpr.pos)};
            }

        }
    }

    function parseType() {
        Context.error("BaseDescriptor:parseType is abstract method and should be overriden.", Context.currentPos());
    }

    function get_result():Expr {
        var output = _useCache
            ? macro $i{_specialTypeName}.__cachedInstance__()
            : macro $i{_specialTypeName}.__createInstance__();
        output.pos = _typeExpr.pos;
        return output;
    }

}

@:final
private class DescriptorCache {

    static var _cache(default, never):Array<String> = [];

    public static function has(cacheUId:String):Bool {
        return _cache.indexOf(cacheUId) >= 0;
    }

    public static function cache(cacheUId:String) {
        if (!has(cacheUId)) {
            _cache.push(cacheUId);
        }
    }

}

@:final
private class NameConvention {

    inline public static function createDescriptionTypeName(typeExpr:Expr, filter:BinaryFilter):String {
        return '${typeExpr.getTypeName()}Description_$filter';
    }

}

#end
