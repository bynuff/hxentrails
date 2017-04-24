package hxentrails.descriptors;

#if macro

import sys.FileSystem;

import haxe.macro.Type;
import haxe.macro.Expr;
import haxe.macro.Context;

import hxentrails.common.BinaryFilter;
import hxentrails.descriptions.Metadata;
import hxentrails.descriptions.BaseDescription;

using StringTools;
using haxe.macro.TypeTools;
using hxentrails.utils.DescriptorExtensions;

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
        typeExpr:Expr,
        filter:BinaryFilter,
        descriptionBaseType:Class<BaseDescription>,
        useCache:Bool
    ) {
        _type = cast typeExpr.getBaseType();
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
        // TODO: remove this
        var typePath = getTypePath();

        addRangeToInitializeBlock([
            macro typeName = $v{_type.name},
            macro module = $v{_type.module},
            macro typePath = $v{typePath},
            macro file = $v{getFileFullPath()},
            macro type = ${getType(typePath)},
            macro isExtern = $v{_type.isExtern},
            macro isPrivate = $v{_type.isPrivate},
            macro position = $v{Context.getPosInfos(_type.pos)},
            macro params = $v{getParams(_type.params)},
            // TODO: implement
            macro platforms = null,
            macro $b{getMetadata(_type.meta, macro meta)}
        ]);
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

    function getType(typePath:String):Expr {
        return macro {
            var t = Type.resolveClass($v{typePath});
            t != null ? t : Type.resolveClass("Dynamic");
        };
    }

    // TODO replace String to TypeInfo
    // now as is in RTTI
    function getParams(params:Array<TypeParameter>):Array<String> {
        return params.length > 0 ? [for (p in params) p.name] : null;
    }

    function getMetadata(metaAccess:MetaAccess, metaFieldExpr:Expr):Array<Expr> {
        var result:Array<Expr> = [];
        if (_filter.hasFlag(ScanOption.Meta)) {
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

                var isRuntime:Bool = !m.name.startsWith(":");

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

        // init Array<Metadata> if detected any meta,
        if (result.length > 0) {
            result.insert(0, macro $metaFieldExpr = []);
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
        return @:pos(_typeExpr.pos) output;
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
