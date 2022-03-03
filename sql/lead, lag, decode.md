* 首先使用decode判断当前行id是奇数还是偶数，如果是奇数用lead函数往下一行偏移查数据，如果是偶数用lag函数往上一行偏移查数据。
* lead(field, num, defaultvalue) field需要查找的字段，num往后查找的num行的数据，defaultvalue没有符合条件的默认值。
* lag(field, num, defaultvalue)与lead(field, num, defaultvalue)刚好相反，是往前查找num行的数据。

作者：wurr
链接：https://leetcode-cn.com/problems/exchange-seats/solution/oracleli-yong-decode-laghe-leadhan-shu-b-8zcx/
来源：力扣（LeetCode）
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。