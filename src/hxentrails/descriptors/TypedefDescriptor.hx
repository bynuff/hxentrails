package hxentrails.descriptors;

#if macro

import haxe.macro.Type;
import haxe.macro.Expr;

import hxentrails.common.BinaryFilter;
import hxentrails.descriptions.TypedefDescription;

using hxentrails.utils.DescriptorUtils;

class TypedefDescriptor extends BaseDescriptor<DefType> {

    public function new(typeExpr:Expr, filter:BinaryFilter, useCache:Bool) {
        super(cast typeExpr.getBaseType(), typeExpr, filter, TypedefDescription, useCache);
    }

    // TODO: implement
    override function parseType() {
        super.parseType();

        addRangeToInitializeBlock([
            //
        ]);

//        var pack:Array<String> = null;
//        var module:String = null;
//
//        switch (_typeExpr.getType()) {
//            case TType(t, p):
//
//                pack = t.get().pack;
//                module = t.get().module;
//
//                trace('PACKAGE :: $pack');
//
//
//                var anon = t.get().type;
//                switch (anon) {
//                    case TAnonymous(a):
//                        var ss = a.get();
//                        trace(ss.fields);
//                    case _:
//                }
//            case _:
//        }

    }

}

#end
