package hxentrails.descriptors;

#if macro

import sys.FileSystem;
import haxe.macro.Type;
import haxe.macro.Expr;
import haxe.macro.Context;

import hxentrails.common.BinaryFilter;
import hxentrails.descriptions.Metadata;
import hxentrails.descriptions.BaseDescription;

using hxentrails.utils.DescriptorUtils;

class BaseDescriptor<T:BaseType> implements IDescriptor {

    public var result(get, never):Expr;

    var _type:T;
    var _typeExpr:Expr;
    var _useCache:Bool;
    var _filter:BinaryFilter;
    var _specialTypeName:String;
    var _insertBlock:Array<Expr> = [];
    var _descriptionBaseType:Class<BaseDescription>;

    public function new(
        type:T,
        typeExpr:Expr,
        filter:BinaryFilter,
        descriptionBaseType:Class<BaseDescription>,
        useCache:Bool
    ) {
        _type = type;
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

        parseType();

        var specialType = createDescriptionSpecialType();

        Context.defineType(specialType);

        DescriptorCache.cache(_specialTypeName);
    }

    function createDescriptionSpecialType():TypeDefinition {
        var baseTypePath = _descriptionBaseType.getTypePathFromClass();
        return macro class $_specialTypeName extends $baseTypePath {

            static var __instance__;

            public function new() {
                super();
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
        addRangeToInitializeBlock([
            macro @:privateAccess typeInfo.typeName = $v{_type.name},
            macro @:privateAccess typeInfo.module = $v{_type.module},
            macro @:privateAccess typeInfo.typePath = $v{getTypePath()},
            macro @:privateAccess typeInfo.file = $v{getFileFullPath()},
            macro @:privateAccess typeInfo.type = Type.resolveClass(typeInfo.typePath),
            macro @:privateAccess typeInfo.isExtern = $v{_type.isExtern},
            macro @:privateAccess typeInfo.isPrivate = $v{_type.isPrivate},
            macro @:privateAccess typeInfo.position = $v{Context.getPosInfos(_type.pos)},
            // TODO: implement
            macro @:privateAccess typeInfo.params = null,
            // TODO: implement
            macro @:privateAccess typeInfo.platforms = null,
            macro $b{getMetadata(_type.meta, macro @:privateAccess typeInfo.meta)}
        ]);

//        trace('PARAMS :: ${_type.params}');
    }

    function getTypePath():String {
        var splittedResult = _type.module.split(".");
        if (splittedResult.length > 0 && splittedResult.pop() == _type.name) {
            return _type.module;
        } else {
            return '${_type.module}.${_type.name}';
        }
    }

    function getFileFullPath():String {
        return FileSystem.fullPath(Context.getPosInfos(_type.pos).file);
    }

    function getMetadata(metaAccess:MetaAccess, metaFieldExpr:Expr):Array<Expr> {
        var result:Array<Expr> = [];
        if (_filter.hasFlag(DescriptorFlag.META)) {
            result.push(macro $metaFieldExpr = []);
            for (m in metaAccess.get()) {
                var metaParamsExpr = macro {{
                    var metaParams:Array<Dynamic> = null;
                    $b{{
                        var blockResult = [];
                        if (m.params != null && m.params.length > 0) {
                            blockResult.push(macro metaParams = []);
                            for (p in m.params) {
                                blockResult.push(macro metaParams.push($p));
                            }
                        }
                        blockResult;
                    }};
                    metaParams;
                }};

                var isRuntime:Bool = m.name.charAt(0) != ":";

                result.push(
                    macro $metaFieldExpr.push(
                        new hxentrails.descriptions.Metadata(
                            $v{isRuntime ? m.name : m.name.substr(1)},
                            $metaParamsExpr,
                            $v{isRuntime}
                        )
                    )
                );
            }
        }
        return result;
    }

    function addToInitializeBlock(expr:Expr) {
        _insertBlock.push(expr);
    }

    function addRangeToInitializeBlock(exprs:Array<Expr>) {
        for (e in exprs) {
            addToInitializeBlock(e);
        }
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
