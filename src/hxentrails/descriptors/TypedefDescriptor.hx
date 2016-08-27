package hxentrails.descriptors;

#if macro

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import hxentrails.data.TypedefDescription;

using hxentrails.utils.DescriptorUtils;

class TypedefDescriptor extends BaseTypeDescriptor {

    static var COUNTER:Int = 0;

    public function new(typeExpr:Expr, filter:DescriptorFilter, store:Bool) {
        super(typeExpr, filter, TypedefDescription, store);
    }

    override public function analyze() {

        var pack:Array<String> = null;
        var module:String = null;

        switch (_typeExpr.getType()) {
            case TType(t, p):

                pack = t.get().pack;
                module = t.get().module;

                trace('PACKAGE :: $pack');


                var anon = t.get().type;
                switch (anon) {
                    case TAnonymous(a):
                        var ss = a.get();
                        trace(ss.fields);
                    case _:
                }
            case _:
        }


        var nnn = '__${_typeExpr.getTypeName()}_descr${COUNTER++}';

        _descriptionId = module + "::" + nnn;


        var c:TypeDefinition = macro class $nnn extends hxentrails.data.TypedefDescription {

            public function new() {
                super($v{_typeExpr.getTypeName()});
                trace(Type.resolveClass($v{pack.join(".")} + ".Zzz"));
                filter = $v{_filter};
                id  = $v{_descriptionId};
            }

        }

        haxe.macro.Context.defineType(c);

        result = Context.parse('new $nnn()', _typeExpr.pos);
    }

}

#end
