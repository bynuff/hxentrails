package hxentrails;

import utest.Assert;

import hxentrails.utils.ScanUtils;
import hxentrails.descriptors.DescriptorFlag;
import hxentrails.descriptions.TypedefDescription;

@:keep
class ScanUtilTestCases {

    public function new() {}

    public function testScanUtil() {
        var descr1 = ScanUtils.describeTypedef(TestTypedef, false, DescriptorFlag.VARIABLES);
        var descr2 = ScanUtils.describeTypedef(TestTypedef, true, DescriptorFlag.COMPILE_META);
        var descr3 = ScanUtils.describeTypedef(TestTypedef, true, DescriptorFlag.COMPILE_META);
        var descr4 = ScanUtils.describeTypedef(TestTypedef, true);

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
