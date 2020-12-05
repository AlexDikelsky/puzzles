BEGIN { FS = "x" }
{
    s1 = $1 * $2;
    s2 = $2 * $3;
    s3 = $3 * $1;
    paper += 2 * (s1 + s2 + s3) + min(min(s1, s2), s3);

    maximum = max(max($1, $2), $3);
    ribbon += 2 * ($1 + $2 + $3 - maximum) + ($1 * $2 * $3);

}
END { print paper, ribbon; }

function min(x, y) {
    return x < y ? x : y;
}

function max(x, y) {
    return x > y ? x : y;
}
