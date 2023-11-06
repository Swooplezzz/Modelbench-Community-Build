function copy_sign(valx, valy)
{
    if (valy >= 0)
    {
        return abs(valx);
    }
    else
    {
        return -abs(valx);
    }
}