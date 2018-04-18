@a = (1, -98, 25, 66, 19);
$max = $a[0];
for($i=1;$i<@a;$i++)
{
    if($max < $a[$i]) 
    {
        $max = $a[$i];
    }
}
for($i=0;$i<@a;$i++)
{
    print "$a[$i]\t";
}
print "\n";
print "max: $max\n";
