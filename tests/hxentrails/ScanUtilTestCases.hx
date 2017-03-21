package hxentrails;

import utest.Assert;

import hxentrails.utils.ScanUtils;
import hxentrails.descriptions.TypedefDescription;

@:keep
class ScanUtilTestCases {

    public function new() {}

    public function testScanUtil() {
        var descr1 = ScanUtils.describe(TestTypedef, false);
        var descr2 = ScanUtils.describe(TestTypedef, true);
        var descr3 = ScanUtils.describe(TestTypedef, true);
        var descr4 = ScanUtils.describe(TestTypedef, true);

        Assert.notNull(descr1);
        Assert.notNull(descr2);
        Assert.notNull(descr3);
        Assert.notNull(descr4);

        Assert.is(descr1, TypedefDescription);
        Assert.is(descr2, TypedefDescription);
        Assert.is(descr3, TypedefDescription);
        Assert.is(descr4, TypedefDescription);

        Assert.equals(descr2, descr3);
        Assert.notEquals(descr2, descr4);
    }

}

@:keep
typedef TestTypedef = {
    var name:String;
}
