package hxentrails.descriptors;

#if macro

import haxe.macro.Type;
import haxe.macro.Expr;

using StringTools;
using haxe.macro.TypeTools;

class FieldsDescriptor<T:BaseType> extends BaseDescriptor<T> {

    override function parseType() {
        super.parseType();

        addRangeToInitializeBlock([for (cf in getFields()) parseClassField(cf)]);
    }

    function parseClassField(field:ClassField, inner:Bool = false):Expr {
        return macro {
            var fieldInfo = {
                name: $v{field.name},
                type: ${getType(field.type.toString())},
                isPublic: $v{field.isPublic},
                isOverride: false, // TODO
                readAccess: hxentrails.descriptions.FieldAccess.Normal, // TODO
                writeAccess: hxentrails.descriptions.FieldAccess.Normal, // TODO
                params: $v{getParams(field.params)},
                // TODO: implement
                platforms: null,
                meta: null,
                line: $v{getLine(field.pos)},
                // prevent recursive when get overloads for processed field
                overloads: $v{inner ? null : $b{getOverloads(field)}},
                isFunction: $v{isFunction(field)}
            };
            $b{getMetadata(field.meta, macro fieldInfo.meta)};
            fields.push(fieldInfo);
        };
    }

    // TODO: tempoary solution for getting method return type
    override function getType(typePath:String):Expr {
        if (typePath.endsWith("Void")) {
            return macro null;
        }
        return super.getType(typePath.split("->").pop().trim());
    }

    // TODO: move to BaseDescriptor, maybe create 'line' field in TypeInfo
    function getLine(pos:Position):Int {
        var linePattern:EReg = ~/:([0-9]+):/;
        if (linePattern.match('$pos')) {
            return Std.parseInt(linePattern.matched(1));
        }
        return -1;
    }

    // TODO: refactor getOverloads like getMetadata
    function getOverloads(field:ClassField):Array<Expr> {
        var overloads:Array<ClassField> = field.overloads.get();
        if (overloads != null) {
            var result:Array<Expr> = [];
            for (f in overloads) {
                result.push(parseClassField(f, true));
            }
            return result.length > 0 ? result : null;
        }
        return null;
    }

    // TODO: refactor
    function isFunction(field:ClassField):Bool {
        return switch (field.kind) {
            case FMethod(_):
                true;
            case _:
                false;
        }
    }

    function getFields():Array<ClassField> {
        throw "Abstract method getFields at FieldDescriptor must be implemented.";
    }

}

#end
